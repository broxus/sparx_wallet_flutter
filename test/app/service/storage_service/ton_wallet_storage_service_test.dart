import 'package:app/app/service/storage_service/ton_wallet_storage_service/ton_wallet_storage_service.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:nekoton_repository/nekoton_repository.dart';

final _address = Address(address: '0:${'3' * 64}');
final _otherAddress = Address(address: '0:${'4' * 64}');

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

TransactionWithData<TransactionAdditionalInfo?> _tx(DateTime createdAt) =>
    TransactionWithData<TransactionAdditionalInfo?>(
      transaction: _transaction(createdAt),
      data: null,
    );

PendingTransactionWithData _pending({
  required String messageHash,
  required DateTime createdAt,
}) => PendingTransactionWithData(
  transaction: PendingTransaction(
    messageHash: messageHash,
    expireAt: createdAt.add(const Duration(minutes: 5)),
  ),
  destination: _address,
  amount: BigInt.one,
  createdAt: createdAt,
);

void main() {
  group('TonWalletStorageService', () {
    late TonWalletStorageService service;

    setUp(() {
      service = TonWalletStorageService();
    });

    test('addFoundTransactions deduplicates and sorts descending', () async {
      final older = _tx(DateTime(2024));
      final newer = _tx(DateTime(2025));

      await service.addFoundTransactions(
        networkId: 1,
        group: 'mainnet',
        address: _address,
        transaction: [older],
      );
      await service.addFoundTransactions(
        networkId: 1,
        group: 'mainnet',
        address: _address,
        transaction: [newer, older],
      );

      final result = await service
          .transactionsStream(networkId: 1, group: 'mainnet', address: _address)
          .first;

      expect(result, [newer, older]);
    });

    test('pending and expired transactions are sorted descending', () async {
      final older = _pending(messageHash: 'old', createdAt: DateTime(2024));
      final newer = _pending(messageHash: 'new', createdAt: DateTime(2025));

      await service.addPendingTransaction(
        networkId: 1,
        group: 'mainnet',
        address: _address,
        transaction: older,
      );
      await service.addPendingTransaction(
        networkId: 1,
        group: 'mainnet',
        address: _address,
        transaction: newer,
      );
      await service.addExpiredTransaction(
        networkId: 1,
        group: 'mainnet',
        address: _address,
        transaction: older,
      );
      await service.addExpiredTransaction(
        networkId: 1,
        group: 'mainnet',
        address: _address,
        transaction: newer,
      );

      expect(
        await service
            .pendingTransactionsStream(
              networkId: 1,
              group: 'mainnet',
              address: _address,
            )
            .first,
        [newer, older],
      );
      expect(
        await service
            .expiredTransactionsStream(
              networkId: 1,
              group: 'mainnet',
              address: _address,
            )
            .first,
        [newer, older],
      );
    });

    test('deletePendingTransaction removes matching pending item', () async {
      final older = _pending(messageHash: 'old', createdAt: DateTime(2024));
      final newer = _pending(messageHash: 'new', createdAt: DateTime(2025));

      await service.addPendingTransaction(
        networkId: 1,
        group: 'mainnet',
        address: _address,
        transaction: older,
      );
      await service.addPendingTransaction(
        networkId: 1,
        group: 'mainnet',
        address: _address,
        transaction: newer,
      );

      final removed = await service.deletePendingTransaction(
        networkId: 1,
        group: 'mainnet',
        address: _address,
        messageHash: 'old',
      );

      expect(removed, older);
      expect(
        await service
            .pendingTransactionsStream(
              networkId: 1,
              group: 'mainnet',
              address: _address,
            )
            .first,
        [newer],
      );
    });

    test(
      'deletePendingTransaction returns null for unknown message hash',
      () async {
        await service.addPendingTransaction(
          networkId: 1,
          group: 'mainnet',
          address: _address,
          transaction: _pending(
            messageHash: 'known',
            createdAt: DateTime(2025),
          ),
        );

        final removed = await service.deletePendingTransaction(
          networkId: 1,
          group: 'mainnet',
          address: _address,
          messageHash: 'missing',
        );

        expect(removed, isNull);
        expect(
          await service
              .pendingTransactionsStream(
                networkId: 1,
                group: 'mainnet',
                address: _address,
              )
              .first,
          hasLength(1),
        );
      },
    );

    test('transactions are isolated by wallet key', () async {
      final first = _tx(DateTime(2024));
      final second = _tx(DateTime(2025));

      await service.addFoundTransactions(
        networkId: 1,
        group: 'mainnet',
        address: _address,
        transaction: [first],
      );
      await service.addFoundTransactions(
        networkId: 1,
        group: 'mainnet',
        address: _otherAddress,
        transaction: [second],
      );

      expect(
        await service
            .transactionsStream(
              networkId: 1,
              group: 'mainnet',
              address: _address,
            )
            .first,
        [first],
      );
      expect(
        await service
            .transactionsStream(
              networkId: 1,
              group: 'mainnet',
              address: _otherAddress,
            )
            .first,
        [second],
      );
    });
  });
}
