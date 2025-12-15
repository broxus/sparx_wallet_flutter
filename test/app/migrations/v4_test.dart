import 'dart:io';

import 'package:app/app/service/presets_connection/presets_connection_service.dart';
import 'package:app/app/service/storage_service/balance_storage_service.dart';
import 'package:app/app/service/storage_service/general_storage_service.dart';
import 'package:app/app/service/storage_service/migrations/storage_migrations/v4.dart';
import 'package:app/utils/common_utils.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:get_storage/get_storage.dart';
import 'package:mocktail/mocktail.dart';
import 'package:path_provider_platform_interface/path_provider_platform_interface.dart';

class _MockPathProviderPlatform extends PathProviderPlatform {
  @override
  Future<String?> getApplicationDocumentsPath() async {
    final dir = await Directory.systemTemp.createTemp('get_storage_v4_test');
    return dir.path;
  }
}

class _MockPresetsConnectionService extends Mock
    implements PresetsConnectionService {}

void main() {
  TestWidgetsFlutterBinding.ensureInitialized();

  PathProviderPlatform.instance = _MockPathProviderPlatform();

  late _MockPresetsConnectionService presetsConnectionService;
  late StorageMigrationV4 migration;

  late List<String> currencyContainers;
  late List<String> balanceContainers;

  setUpAll(() {
    currencyContainers = [
      GeneralStorageService.currenciesContainer,
      GeneralStorageService.systemContractAssetsContainer,
      GeneralStorageService.customContractAssetsContainer,
    ];

    balanceContainers = [...BalanceStorageService.containers];
  });

  setUp(() async {
    presetsConnectionService = _MockPresetsConnectionService();
    migration = StorageMigrationV4(presetsConnectionService);

    when(() => presetsConnectionService.networks).thenReturn([]);

    for (final c in currencyContainers) {
      await GetStorage.init(c);
      await GetStorage(c).erase();
    }
    for (final c in balanceContainers) {
      await GetStorage.init(c);
      await GetStorage(c).erase();
    }
  });

  tearDown(() async {
    for (final c in currencyContainers) {
      await GetStorage.init(c);
      await GetStorage(c).erase();
    }
    for (final c in balanceContainers) {
      await GetStorage.init(c);
      await GetStorage(c).erase();
    }
  });

  test('Move keys from networkType::id to group::id', () async {
    // given
    for (final container in balanceContainers) {
      final storage = GetStorage(container);

      await storage.write('ever::123', 'val-ever');
      await storage.write('venom::456', 'val-venom');
      await storage.write('invalidKey', 'val-invalid');

      expect(storage.read<String>('ever::123'), 'val-ever');
      expect(storage.read<String>('venom::456'), 'val-venom');
      expect(storage.read<String>('invalidKey'), 'val-invalid');
    }

    await migration.apply();

    for (final container in balanceContainers) {
      final storage = GetStorage(container);

      final everGroup = getNetworkGroupByNetworkType('ever');
      final venomGroup = getNetworkGroupByNetworkType('venom');

      expect(storage.read<String>('ever::123'), isNull);
      expect(storage.read<String>('venom::456'), isNull);

      expect(
        storage.read<String>('$everGroup::123'),
        'val-ever',
        reason: 'ever::123 must move to $everGroup::123',
      );
      expect(
        storage.read<String>('$venomGroup::456'),
        'val-venom',
        reason: 'venom::456 must move to $venomGroup::456',
      );

      expect(storage.read<String>('invalidKey'), 'val-invalid');
    }
  });
  test('Update networkGroup', () async {
    when(() => presetsConnectionService.networks).thenReturn([]);

    for (final container in currencyContainers) {
      final storage = GetStorage(container);

      final value = [
        {'networkType': 'ever'},
        {'networkType': 'venom', 'networkGroup': 'keep-me'},
      ];

      await storage.write('custom', value);

      expect(storage.read<List<dynamic>>('custom'), isNotNull);
    }

    await migration.apply();

    for (final container in currencyContainers) {
      final storage = GetStorage(container);

      expect(
        storage.read<List<dynamic>>('custom'),
        isNull,
        reason: 'custom-keys is removed',
      );
    }
  });
}
