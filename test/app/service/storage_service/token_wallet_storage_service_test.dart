import 'package:app/app/service/storage_service/token_wallet_storage_service/token_wallet_storage_service.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:nekoton_repository/nekoton_repository.dart';

final _owner = Address(address: '0:${'1' * 64}');
final _otherOwner = Address(address: '0:${'3' * 64}');
final _rootTokenContract = Address(address: '0:${'2' * 64}');

Transaction _transaction(DateTime createdAt) => Transaction(
  id: TransactionId(
    lt: createdAt.microsecondsSinceEpoch.toString(),
    hash: '${createdAt.year}',
  ),
  createdAt: createdAt,
  aborted: false,
  origStatus: AccountStatus.uninit,
  endStatus: AccountStatus.active,
  totalFees: BigInt.zero,
  inMessage: Message(
    hash: 'in-${createdAt.year}',
    value: BigInt.zero,
    bounce: false,
    bounced: false,
  ),
  outMessages: const [],
  boc: null,
);

TransactionWithData<TokenWalletTransaction?> _tx(DateTime createdAt) =>
    TransactionWithData<TokenWalletTransaction?>(
      transaction: _transaction(createdAt),
      data: null,
    );

void main() {
  group('TokenWalletStorageService', () {
    late TokenWalletStorageService service;

    setUp(() {
      service = TokenWalletStorageService();
    });

    test(
      'addFoundTransactions deduplicates and sorts descending by createdAt',
      () async {
        final older = _tx(DateTime(2024));
        final newer = _tx(DateTime(2025));

        await service.addFoundTransactions(
          networkId: 1,
          group: 'mainnet',
          owner: _owner,
          rootTokenContract: _rootTokenContract,
          transaction: [older],
        );
        await service.addFoundTransactions(
          networkId: 1,
          group: 'mainnet',
          owner: _owner,
          rootTokenContract: _rootTokenContract,
          transaction: [older, newer],
        );

        final result = await service
            .transactionsStream(
              networkId: 1,
              group: 'mainnet',
              owner: _owner,
              rootTokenContract: _rootTokenContract,
            )
            .first;

        expect(result, [newer, older]);
      },
    );

    test('clear resets cached transactions', () async {
      await service.addFoundTransactions(
        networkId: 1,
        group: 'mainnet',
        owner: _owner,
        rootTokenContract: _rootTokenContract,
        transaction: [_tx(DateTime(2024))],
      );

      await service.clear();

      final result = await service
          .transactionsStream(
            networkId: 1,
            group: 'mainnet',
            owner: _owner,
            rootTokenContract: _rootTokenContract,
          )
          .first;

      expect(result, isNull);
    });

    test('transactions are isolated by owner and token contract', () async {
      final first = _tx(DateTime(2024));
      final second = _tx(DateTime(2025));

      await service.addFoundTransactions(
        networkId: 1,
        group: 'mainnet',
        owner: _owner,
        rootTokenContract: _rootTokenContract,
        transaction: [first],
      );
      await service.addFoundTransactions(
        networkId: 1,
        group: 'mainnet',
        owner: _otherOwner,
        rootTokenContract: _rootTokenContract,
        transaction: [second],
      );

      expect(
        await service
            .transactionsStream(
              networkId: 1,
              group: 'mainnet',
              owner: _owner,
              rootTokenContract: _rootTokenContract,
            )
            .first,
        [first],
      );
      expect(
        await service
            .transactionsStream(
              networkId: 1,
              group: 'mainnet',
              owner: _otherOwner,
              rootTokenContract: _rootTokenContract,
            )
            .first,
        [second],
      );
    });
  });
}
