import 'package:app/app/service/storage_service/balance_storage_service.dart';
import 'package:app/data/models/account_balance.dart';
import 'package:app/utils/common_utils.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:money2/money2.dart';
import 'package:nekoton_repository/nekoton_repository.dart';

import '../../../helpers/helpers.dart';

class _MockAccountBalanceModel extends Mock implements AccountBalanceModel {}

final _currency = Currency.create('USD', 2, symbol: r'$', pattern: 'S0.00');

final _accountAddress = Address(address: '0:${'a' * 64}');
final _rootTokenContract = Address(address: '0:${'b' * 64}');

Map<String, dynamic> _moneyJson(int units) =>
    MoneyFixer(Money.fromIntWithCurrency(units, _currency)).toJsonImproved();

void main() {
  group('BalanceStorageService', () {
    late InMemoryStorageAdapter storageAdapter;
    late BalanceStorageService service;

    setUp(() {
      storageAdapter = InMemoryStorageAdapter();
      service = BalanceStorageService(storageAdapter);
    });

    test(
      'init reads overall balances and token balances from storage',
      () async {
        await storageAdapter
            .box(BalanceStorageService.overallBalancesContainer)
            .write(
              'mainnet::${_accountAddress.address}',
              Fixed.parse('123.45').toJsonImproved(),
            );
        await storageAdapter.box(BalanceStorageService.balancesContainer).write(
          'mainnet::${_accountAddress.address}',
          [
            {
              'rootTokenContract': _rootTokenContract.address,
              'fiatBalance': _moneyJson(1500),
              'tokenBalance': _moneyJson(300),
              'isNative': false,
            },
          ],
        );

        await service.init();

        expect(
          service.getOverallBalance('mainnet')[_accountAddress],
          Fixed.parse('123.45'),
        );
        expect(service.getBalances('mainnet')[_accountAddress], hasLength(1));
        expect(
          service.getBalances('mainnet')[_accountAddress]?.first.isNative,
          isFalse,
        );
      },
    );

    test('setOverallBalance stores value and updates stream cache', () async {
      await service.init();

      final expectation = expectLater(
        service.getOverallBalancesStream('mainnet').take(2),
        emitsInOrder([
          <Address, Fixed>{},
          {_accountAddress: Fixed.parse('77.00')},
        ]),
      );

      service.setOverallBalance(
        group: 'mainnet',
        accountAddress: _accountAddress,
        balance: Fixed.parse('77.00'),
      );

      await expectation;
      expect(
        storageAdapter
            .box(BalanceStorageService.overallBalancesContainer)
            .read<Map<String, dynamic>>('mainnet::${_accountAddress.address}'),
        isNotNull,
      );
    });

    test(
      'setBalances replaces token balance with same token and native flag',
      () async {
        final oldBalance = _MockAccountBalanceModel();
        final newBalance = _MockAccountBalanceModel();

        when(() => oldBalance.rootTokenContract).thenReturn(_rootTokenContract);
        when(() => oldBalance.isNative).thenReturn(false);
        when(() => oldBalance.toJson()).thenReturn({
          'rootTokenContract': _rootTokenContract.address,
          'fiatBalance': _moneyJson(1000),
          'tokenBalance': _moneyJson(100),
          'isNative': false,
        });

        when(() => newBalance.rootTokenContract).thenReturn(_rootTokenContract);
        when(() => newBalance.isNative).thenReturn(false);
        when(() => newBalance.toJson()).thenReturn({
          'rootTokenContract': _rootTokenContract.address,
          'fiatBalance': _moneyJson(2500),
          'tokenBalance': _moneyJson(250),
          'isNative': false,
        });

        await service.init();
        service.setBalances(
          group: 'mainnet',
          accountAddress: _accountAddress,
          balance: oldBalance,
        );
        service.setBalances(
          group: 'mainnet',
          accountAddress: _accountAddress,
          balance: newBalance,
        );

        final balances = service.getBalances('mainnet')[_accountAddress];

        expect(balances, hasLength(1));
        expect(balances?.first.fiatBalance.minorUnits.toInt(), 2500);
      },
    );

    test('readBalances skips invalid entries', () async {
      await storageAdapter.box(BalanceStorageService.balancesContainer).write(
        'mainnet::${_accountAddress.address}',
        [
          {
            'rootTokenContract': _rootTokenContract.address,
            'fiatBalance': _moneyJson(1000),
            'tokenBalance': _moneyJson(100),
            'isNative': false,
          },
          'broken-entry',
        ],
      );
      await storageAdapter
          .box(BalanceStorageService.balancesContainer)
          .write('broken-key', 'broken-value');

      final balances = service.readBalances();

      expect(balances['mainnet']?[_accountAddress], hasLength(1));
    });

    test('clear erases both balance containers', () async {
      await service.init();
      service.setOverallBalance(
        group: 'mainnet',
        accountAddress: _accountAddress,
        balance: Fixed.parse('5.00'),
      );
      service.setBalances(
        group: 'mainnet',
        accountAddress: _accountAddress,
        balance: AccountBalanceModel(
          rootTokenContract: _rootTokenContract,
          fiatBalance: Money.fromIntWithCurrency(100, _currency),
          tokenBalance: Money.fromIntWithCurrency(50, _currency),
          isNative: false,
        ),
      );

      await service.clear();

      expect(
        storageAdapter
            .box(BalanceStorageService.overallBalancesContainer)
            .getEntries(),
        isEmpty,
      );
      expect(
        storageAdapter
            .box(BalanceStorageService.balancesContainer)
            .getEntries(),
        isEmpty,
      );
    });

    test('balance streams emit seeded data after init', () async {
      await storageAdapter
          .box(BalanceStorageService.overallBalancesContainer)
          .write(
            'mainnet::${_accountAddress.address}',
            Fixed.parse('10.00').toJsonImproved(),
          );
      await storageAdapter.box(BalanceStorageService.balancesContainer).write(
        'mainnet::${_accountAddress.address}',
        [
          {
            'rootTokenContract': _rootTokenContract.address,
            'fiatBalance': _moneyJson(1000),
            'tokenBalance': _moneyJson(100),
            'isNative': false,
          },
        ],
      );

      await service.init();

      expect(await service.getOverallBalancesStream('mainnet').first, {
        _accountAddress: Fixed.parse('10.00'),
      });
      expect(await service.getBalancesStream('mainnet').first, hasLength(1));
    });
  });
}
