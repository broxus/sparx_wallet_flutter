import 'dart:io';

import 'package:app/app/service/storage_service/connections_storage/connections_storage_service.dart';
import 'package:app/app/service/storage_service/migrations/storage_migrations/v7.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:get_storage/get_storage.dart';
import 'package:path_provider_platform_interface/path_provider_platform_interface.dart';
import 'package:plugin_platform_interface/plugin_platform_interface.dart';

class MockPathProviderPlatform extends Fake
    with MockPlatformInterfaceMixin
    implements PathProviderPlatform {
  @override
  Future<String?> getApplicationDocumentsPath() async {
    final dir = await Directory.systemTemp.createTemp('get_storage_v7_test');
    return dir.path;
  }
}

void main() {
  TestWidgetsFlutterBinding.ensureInitialized();
  PathProviderPlatform.instance = MockPathProviderPlatform();

  group('StorageMigrationV7', () {
    late GetStorage storage;
    late StorageMigrationV7 migration;

    setUpAll(() async {
      await GetStorage.init(ConnectionsStorageService.container);
    });

    setUp(() {
      storage = GetStorage(ConnectionsStorageService.container)..erase();
      migration = StorageMigrationV7();
    });

    test('version should be 7', () {
      expect(StorageMigrationV7.version, 7);
    });

    test('should skip preset connections', () async {
      final oldData = [
        {
          'id': 'preset-1',
          'name': 'Preset Network',
          'networkType': 'ever',
          'group': 'mainnet',
          'runtimeType': 'jrpc',
          'endpoint': 'https://preset.com',
          'blockExplorerUrl': 'https://explorer.com',
          'manifestUrl': 'https://manifest.com',
          'nativeTokenDecimals': 9,
          'isPreset': true,
        },
      ];
      storage.write('connections', oldData);

      await migration.apply();

      final result = storage.read<dynamic>('connections');
      expect(result, isEmpty);
    });

    test('should migrate non-preset connection to new format', () async {
      final oldData = [
        {
          'id': 'custom-1',
          'name': 'Custom Network',
          'networkType': 'ever',
          'group': 'mainnet',
          'runtimeType': 'jrpc',
          'endpoint': 'https://custom.com',
          'blockExplorerUrl': 'https://explorer.com',
          'manifestUrl': 'https://manifest.com',
          'nativeTokenDecimals': 9,
          'isPreset': false,
        },
      ];
      storage.write('connections', oldData);

      await migration.apply();

      final result = storage.read<dynamic>('connections') as List;
      expect(result.length, 1);

      final newConnection = result[0] as Map<String, dynamic>;

      expect(newConnection['id'], 'custom-1');
      expect(newConnection['networkName'], 'Custom Network');
      expect(newConnection['defaultWorkchainId'], 0);
      expect(newConnection['isPreset'], false);
      expect(newConnection['canBeEdited'], true);

      final workchains = newConnection['workchains'] as List;
      expect(workchains.length, 1);

      final workchain = workchains[0] as Map<String, dynamic>;
      expect(workchain['id'], 0);
      expect(workchain['parentConnectionId'], 'custom-1');
      expect(workchain['networkName'], 'Custom Network');
      expect(workchain['networkGroup'], 'mainnet');
      expect(workchain['networkType'], 'ever');
      expect(workchain['transportType'], 'jrpc');
      expect(workchain['blockExplorerUrl'], 'https://explorer.com');
      expect(workchain['manifestUrl'], 'https://manifest.com');
      expect(workchain['nativeTokenDecimals'], 9);
      expect(workchain['isLocal'], true);
      expect(workchain['isPreset'], false);
      expect(workchain['canBeEdited'], true);
    });

    test('should handle multiple endpoints', () async {
      final oldData = [
        {
          'id': 'multi-endpoint',
          'name': 'Multi Endpoint Network',
          'networkType': 'venom',
          'group': 'testnet',
          'runtimeType': 'gql',
          'endpoint': 'https://primary.com',
          'endpoints': ['https://backup1.com', 'https://backup2.com'],
          'blockExplorerUrl': 'https://explorer.com',
          'manifestUrl': 'https://manifest.com',
          'nativeTokenDecimals': 18,
          'isPreset': false,
        },
      ];
      storage.write('connections', oldData);

      await migration.apply();

      final result = storage.read<dynamic>('connections') as List;
      final newConnection = result[0] as Map<String, dynamic>;
      final workchain =
          (newConnection['workchains'] as List)[0] as Map<String, dynamic>;

      expect(workchain['endpoints'], [
        'https://primary.com',
        'https://backup1.com',
        'https://backup2.com',
      ]);
      expect(workchain['networkType'], 'venom');
      expect(workchain['transportType'], 'gql');
      expect(workchain['nativeTokenDecimals'], 18);
    });

    test('should handle nativeTokenTicker', () async {
      final oldData = [
        {
          'id': 'ticker-test',
          'name': 'Ticker Network',
          'networkType': 'ton',
          'group': 'mainnet',
          'runtimeType': 'proto',
          'endpoint': 'https://ton.com',
          'blockExplorerUrl': 'https://explorer.com',
          'manifestUrl': 'https://manifest.com',
          'nativeTokenDecimals': 9,
          'nativeTokenTicker': 'TON',
          'isPreset': false,
        },
      ];
      storage.write('connections', oldData);

      await migration.apply();

      final result = storage.read<dynamic>('connections') as List;
      final newConnection = result[0] as Map<String, dynamic>;
      final workchain =
          (newConnection['workchains'] as List)[0] as Map<String, dynamic>;
      final ticker = workchain['nativeTokenTicker'] as Map<String, dynamic>;

      expect(ticker['name'], 'TON');
      expect(workchain['networkType'], 'ton');
      expect(workchain['transportType'], 'proto');
    });

    test('should handle missing nativeTokenTicker', () async {
      final oldData = [
        {
          'id': 'no-ticker',
          'name': 'No Ticker Network',
          'networkType': 'ever',
          'group': 'mainnet',
          'runtimeType': 'jrpc',
          'endpoint': 'https://test.com',
          'blockExplorerUrl': 'https://explorer.com',
          'manifestUrl': 'https://manifest.com',
          'nativeTokenDecimals': 9,
          'isPreset': false,
        },
      ];
      storage.write('connections', oldData);

      await migration.apply();

      final result = storage.read<dynamic>('connections') as List;
      final newConnection = result[0] as Map<String, dynamic>;
      final workchain =
          (newConnection['workchains'] as List)[0] as Map<String, dynamic>;
      final ticker = workchain['nativeTokenTicker'] as Map<String, dynamic>;

      expect(ticker['name'], '');
    });

    test('should handle optional fields', () async {
      final oldData = [
        {
          'id': 'optional-fields',
          'name': 'Optional Fields Network',
          'networkType': 'ever',
          'group': 'mainnet',
          'runtimeType': 'jrpc',
          'endpoint': 'https://test.com',
          'blockExplorerUrl': 'https://explorer.com',
          'manifestUrl': 'https://manifest.com',
          'nativeTokenDecimals': 9,
          'latencyDetectionInterval': 60000,
          'maxLatency': 1000,
          'endpointSelectionRetryCount': 3,
          'isPreset': false,
        },
      ];
      storage.write('connections', oldData);

      await migration.apply();

      final result = storage.read<dynamic>('connections') as List;
      final newConnection = result[0] as Map<String, dynamic>;
      final workchain =
          (newConnection['workchains'] as List)[0] as Map<String, dynamic>;

      expect(workchain['latencyDetectionInterval'], 60000);
      expect(workchain['maxLatency'], 1000);
      expect(workchain['endpointSelectionRetryCount'], 3);
    });

    test('should remove networks_ids key', () async {
      storage.write('networks_ids', ['id1', 'id2', 'id3']);

      await migration.apply();

      expect(storage.read<dynamic>('networks_ids'), isNull);
    });

    test('should handle empty connections list', () async {
      storage.write('connections', <Object>[]);

      await migration.apply();

      expect(storage.read<dynamic>('connections'), isEmpty);
    });

    test('should handle null connections', () async {
      await migration.apply();

      expect(storage.read<dynamic>('connections'), isNull);
    });

    test('should filter out preset and keep non-preset', () async {
      final oldData = [
        {
          'id': 'preset-1',
          'name': 'Preset 1',
          'networkType': 'ever',
          'group': 'mainnet',
          'runtimeType': 'jrpc',
          'endpoint': 'https://preset1.com',
          'blockExplorerUrl': 'https://explorer.com',
          'manifestUrl': 'https://manifest.com',
          'nativeTokenDecimals': 9,
          'isPreset': true,
        },
        {
          'id': 'custom-1',
          'name': 'Custom 1',
          'networkType': 'venom',
          'group': 'testnet',
          'runtimeType': 'gql',
          'endpoint': 'https://custom1.com',
          'blockExplorerUrl': 'https://explorer.com',
          'manifestUrl': 'https://manifest.com',
          'nativeTokenDecimals': 18,
          'isPreset': false,
        },
        {
          'id': 'preset-2',
          'name': 'Preset 2',
          'networkType': 'ton',
          'group': 'mainnet',
          'runtimeType': 'proto',
          'endpoint': 'https://preset2.com',
          'blockExplorerUrl': 'https://explorer.com',
          'manifestUrl': 'https://manifest.com',
          'nativeTokenDecimals': 9,
          'isPreset': true,
        },
      ];
      storage.write('connections', oldData);

      await migration.apply();

      final result = storage.read<dynamic>('connections') as List;
      expect(result.length, 1);

      final newConnection = result[0] as Map<String, dynamic>;
      expect(newConnection['id'], 'custom-1');
      expect(newConnection['networkName'], 'Custom 1');
    });

    test('should handle endpoint without endpoints array', () async {
      final oldData = [
        {
          'id': 'single-endpoint',
          'name': 'Single Endpoint',
          'networkType': 'ever',
          'group': 'mainnet',
          'runtimeType': 'jrpc',
          'endpoint': 'https://single.com',
          'blockExplorerUrl': 'https://explorer.com',
          'manifestUrl': 'https://manifest.com',
          'nativeTokenDecimals': 9,
          'isPreset': false,
        },
      ];
      storage.write('connections', oldData);

      await migration.apply();

      final result = storage.read<dynamic>('connections') as List;
      final newConnection = result[0] as Map<String, dynamic>;
      final workchain =
          (newConnection['workchains'] as List)[0] as Map<String, dynamic>;

      expect(workchain['endpoints'], ['https://single.com']);
    });

    test('should set correct wallet types and account names', () async {
      final oldData = [
        {
          'id': 'wallet-test',
          'name': 'Wallet Test',
          'networkType': 'ever',
          'group': 'mainnet',
          'runtimeType': 'jrpc',
          'endpoint': 'https://test.com',
          'blockExplorerUrl': 'https://explorer.com',
          'manifestUrl': 'https://manifest.com',
          'nativeTokenDecimals': 9,
          'isPreset': false,
        },
      ];
      storage.write('connections', oldData);

      await migration.apply();

      final result = storage.read<dynamic>('connections') as List;
      final newConnection = result[0] as Map<String, dynamic>;
      final workchain =
          (newConnection['workchains'] as List)[0] as Map<String, dynamic>;

      final walletTypes = workchain['availableWalletTypes'] as List;
      expect(walletTypes.length, 2);

      expect(workchain['seedPhraseWordsCount'], [12, 24]);

      final accountNames =
          workchain['walletDefaultAccountNames'] as Map<String, dynamic>;
      expect(accountNames['multisig'], isNotNull);
    });
  });
}
