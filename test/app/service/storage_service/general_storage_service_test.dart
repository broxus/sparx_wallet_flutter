import 'dart:io';

import 'package:app/app/service/storage_service/general_storage_service.dart';
import 'package:app/data/models/custom_currency.dart';
import 'package:app/data/models/token_contract/token_contract_asset.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:nekoton_repository/nekoton_repository.dart';
import 'package:path_provider_platform_interface/path_provider_platform_interface.dart';

import '../../../helpers/helpers.dart';
import '../../../test_helpers/fake_path_provider_platform.dart';

class _MockCustomCurrency extends Mock implements CustomCurrency {}

class _MockTokenContractAsset extends Mock implements TokenContractAsset {}

final _rawAddress = '0:${'c' * 64}';

void main() {
  TestWidgetsFlutterBinding.ensureInitialized();

  group('GeneralStorageService', () {
    late Directory tempDir;
    late InMemoryStorageAdapter storageAdapter;
    late GeneralStorageService service;

    setUp(() async {
      tempDir = await Directory.systemTemp.createTemp('general_storage_test');
      PathProviderPlatform.instance = FakePathProviderPlatform(tempDir);

      storageAdapter = InMemoryStorageAdapter();
      service = GeneralStorageService(storageAdapter);
    });

    test('init reads cached values and populates subjects', () async {
      final pref = storageAdapter.box(GeneralStorageService.prefContainer);
      final currencies = storageAdapter.box(
        GeneralStorageService.currenciesContainer,
      );
      final customAssets = storageAdapter.box(
        GeneralStorageService.customContractAssetsContainer,
      );
      final systemAssets = storageAdapter.box(
        GeneralStorageService.systemContractAssetsContainer,
      );

      await pref.write('current_public_key', 'pub-key');
      await pref.write('current_address', _rawAddress);
      await pref.write('last_selected_seeds_key', ['pub-key', 'pub-key-2']);
      await pref.write('biometry_status_key', true);

      await currencies.write('mainnet', [
        {
          'address': _rawAddress,
          'price': '1.23',
          'networkType': 'ever',
          'networkGroup': 'mainnet',
        },
      ]);
      await customAssets.write('mainnet', [
        {
          'name': 'Custom Token',
          'symbol': 'CSTM',
          'decimals': 9,
          'address': _rawAddress,
          'networkType': 'ever',
          'networkGroup': 'mainnet',
        },
      ]);
      await systemAssets.write('mainnet', [
        {
          'name': 'System Token',
          'symbol': 'SYST',
          'decimals': 9,
          'address': _rawAddress,
          'networkType': 'ever',
          'networkGroup': 'mainnet',
        },
      ]);

      await service.init();

      expect(service.applicationDocumentsDirectory, tempDir.path);
      expect(service.currentKey?.publicKey, 'pub-key');
      expect(service.currentAddress?.address, _rawAddress);
      expect(service.lastViewedSeeds.map((e) => e.publicKey), [
        'pub-key',
        'pub-key-2',
      ]);
      expect(service.isBiometryEnabled, isTrue);
      expect(service.getCurrencies('mainnet').single.price, '1.23');
      expect(
        service.getCustomTokenContractAssets('mainnet').single.isCustom,
        isTrue,
      );
      expect(
        service.getSystemTokenContractAssets('mainnet').single.isCustom,
        isFalse,
      );
    });

    test(
      'saveOrUpdateCurrency replaces existing currency with same address',
      () async {
        final existing = _MockCustomCurrency();
        final updated = _MockCustomCurrency();
        final address = Address(address: _rawAddress);

        when(() => existing.address).thenReturn(address);
        when(() => existing.networkGroup).thenReturn('mainnet');
        when(() => existing.toJson()).thenReturn({
          'address': _rawAddress,
          'price': '1.00',
          'networkType': 'ever',
          'networkGroup': 'mainnet',
        });

        when(() => updated.address).thenReturn(address);
        when(() => updated.networkGroup).thenReturn('mainnet');
        when(() => updated.toJson()).thenReturn({
          'address': _rawAddress,
          'price': '2.00',
          'networkType': 'ever',
          'networkGroup': 'mainnet',
        });

        await service.init();
        service.saveOrUpdateCurrency(currency: existing);
        service.saveOrUpdateCurrency(currency: updated);

        expect(service.getCurrencies('mainnet'), hasLength(1));
        expect(service.getCurrencies('mainnet').single.price, '2.00');
        expect(
          storageAdapter
              .box(GeneralStorageService.currenciesContainer)
              .read<List<dynamic>>('mainnet'),
          [
            {
              'address': _rawAddress,
              'price': '2.00',
              'networkType': 'ever',
              'networkGroup': 'mainnet',
            },
          ],
        );
      },
    );

    test('custom assets are deduplicated by address and removable', () async {
      final asset = _MockTokenContractAsset();
      final address = Address(address: _rawAddress);

      when(() => asset.address).thenReturn(address);
      when(() => asset.networkGroup).thenReturn('mainnet');
      when(() => asset.toJson()).thenReturn({
        'name': 'Custom Token',
        'symbol': 'CSTM',
        'decimals': 9,
        'address': _rawAddress,
        'networkType': 'ever',
        'networkGroup': 'mainnet',
        'isCustom': true,
      });

      await service.init();
      service.addCustomTokenContractAsset(asset);
      service.addCustomTokenContractAsset(asset);

      expect(service.getCustomTokenContractAssets('mainnet'), hasLength(1));
      expect(
        storageAdapter
            .box(GeneralStorageService.customContractAssetsContainer)
            .read<List<dynamic>>('mainnet'),
        hasLength(1),
      );

      service.removeCustomTokenContractAsset(asset);

      expect(service.getCustomTokenContractAssets('mainnet'), isEmpty);
      expect(
        storageAdapter
            .box(GeneralStorageService.customContractAssetsContainer)
            .read<List<dynamic>>('mainnet'),
        isEmpty,
      );
    });

    test('clear resets cached state', () async {
      await storageAdapter
          .box(GeneralStorageService.prefContainer)
          .write('current_public_key', 'pub-key');
      await storageAdapter.box(GeneralStorageService.prefContainer).write(
        'last_selected_seeds_key',
        ['pub-key'],
      );
      await service.init();

      await service.clear();

      expect(service.currentKey, isNull);
      expect(service.currentAddress, isNull);
      expect(service.lastViewedSeeds, isEmpty);
      expect(service.getCurrencies('mainnet'), isEmpty);
      expect(service.getCustomTokenContractAssets('mainnet'), isEmpty);
    });

    test('saveOrUpdateCurrencies replaces duplicates by address', () async {
      final first = _MockCustomCurrency();
      final second = _MockCustomCurrency();
      final address = Address(address: _rawAddress);
      await service.init();

      when(() => first.address).thenReturn(address);
      when(() => first.toJson()).thenReturn({
        'address': _rawAddress,
        'price': '1.00',
        'networkType': 'ever',
        'networkGroup': 'mainnet',
      });
      when(() => second.address).thenReturn(address);
      when(() => second.toJson()).thenReturn({
        'address': _rawAddress,
        'price': '2.00',
        'networkType': 'ever',
        'networkGroup': 'mainnet',
      });

      service.saveOrUpdateCurrencies(group: 'mainnet', currencies: [first]);
      service.saveOrUpdateCurrencies(group: 'mainnet', currencies: [second]);

      expect(service.getCurrencies('mainnet'), hasLength(1));
      expect(service.getCurrencies('mainnet').single.price, '2.00');
    });

    test(
      'updateSystemTokenContractAssets groups assets by network group',
      () async {
        await service.init();
        final first = _MockTokenContractAsset();
        final second = _MockTokenContractAsset();

        when(() => first.networkGroup).thenReturn('mainnet');
        when(() => first.toJson()).thenReturn({
          'name': 'A',
          'symbol': 'A',
          'decimals': 9,
          'address': '0:${'d' * 64}',
          'networkType': 'ever',
          'networkGroup': 'mainnet',
          'isCustom': false,
        });

        when(() => second.networkGroup).thenReturn('ton-mainnet');
        when(() => second.toJson()).thenReturn({
          'name': 'B',
          'symbol': 'B',
          'decimals': 9,
          'address': '0:${'e' * 64}',
          'networkType': 'ton',
          'networkGroup': 'ton-mainnet',
          'isCustom': false,
        });

        await service.updateSystemTokenContractAssets([first, second]);

        expect(
          service.getSystemTokenContractAssets('mainnet').single.symbol,
          'A',
        );
        expect(
          service.getSystemTokenContractAssets('ton-mainnet').single.symbol,
          'B',
        );
      },
    );

    test(
      'clearSystemTokenContractAssets removes one network group only',
      () async {
        await storageAdapter
            .box(GeneralStorageService.systemContractAssetsContainer)
            .write('mainnet', [
              {
                'name': 'A',
                'symbol': 'A',
                'decimals': 9,
                'address': _rawAddress,
                'networkType': 'ever',
                'networkGroup': 'mainnet',
                'isCustom': false,
              },
            ]);
        await storageAdapter
            .box(GeneralStorageService.systemContractAssetsContainer)
            .write('ton-mainnet', [
              {
                'name': 'B',
                'symbol': 'B',
                'decimals': 9,
                'address': '0:${'f' * 64}',
                'networkType': 'ton',
                'networkGroup': 'ton-mainnet',
                'isCustom': false,
              },
            ]);
        await service.init();

        await service.clearSystemTokenContractAssets('mainnet');

        expect(service.getSystemTokenContractAssets('mainnet'), isEmpty);
        expect(
          service.getSystemTokenContractAssets('ton-mainnet'),
          hasLength(1),
        );
      },
    );

    test(
      'updateDefaultActiveAssets stores unique addresses per account',
      () async {
        await service.init();

        service.updateDefaultActiveAssets('account-1', ['a', 'b']);
        service.updateDefaultActiveAssets('account-1', ['b', 'c']);

        expect(service.getDefaultActiveAssets('account-1').toSet(), {
          'a',
          'b',
          'c',
        });
      },
    );

    test('completeStorageMigration sets migrated flag', () async {
      await service.init();

      expect(service.isStorageMigrated, isFalse);

      service.completeStorageMigration();

      expect(service.isStorageMigrated, isTrue);
    });

    test(
      'clearAllCustomTokens and clearCurrencies reset cached maps',
      () async {
        await storageAdapter
            .box(GeneralStorageService.customContractAssetsContainer)
            .write('mainnet', [
              {
                'name': 'A',
                'symbol': 'A',
                'decimals': 9,
                'address': _rawAddress,
                'networkType': 'ever',
                'networkGroup': 'mainnet',
                'isCustom': true,
              },
            ]);
        await storageAdapter
            .box(GeneralStorageService.currenciesContainer)
            .write('mainnet', [
              {
                'address': _rawAddress,
                'price': '1.23',
                'networkType': 'ever',
                'networkGroup': 'mainnet',
              },
            ]);
        await service.init();

        await service.clearAllCustomTokens();
        await service.clearCurrencies();

        expect(service.getCustomTokenContractAssets('mainnet'), isEmpty);
        expect(service.getCurrencies('mainnet'), isEmpty);
      },
    );
  });
}
