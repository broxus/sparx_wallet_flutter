import 'dart:io';

import 'package:app/app/service/storage_service/general_storage_service.dart';
import 'package:app/app/service/storage_service/migrations/storage_migrations/v3.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:get_storage/get_storage.dart';
import 'package:path_provider_platform_interface/path_provider_platform_interface.dart';

class _MockPathProviderPlatform extends PathProviderPlatform {
  @override
  Future<String?> getApplicationDocumentsPath() async {
    final dir = await Directory.systemTemp.createTemp('get_storage_v3_test');
    return dir.path;
  }
}

void main() {
  TestWidgetsFlutterBinding.ensureInitialized();

  PathProviderPlatform.instance = _MockPathProviderPlatform();

  late StorageMigrationV3 migration;
  late List<String> containers;

  setUpAll(() {
    containers = [
      GeneralStorageService.currenciesContainer,
      GeneralStorageService.systemContractAssetsContainer,
      GeneralStorageService.customContractAssetsContainer,
    ];
  });

  setUp(() async {
    migration = StorageMigrationV3();

    for (final c in containers) {
      await GetStorage.init(c);
      await GetStorage(c).erase();
    }
  });

  tearDown(() async {
    for (final c in containers) {
      await GetStorage.init(c);
      await GetStorage(c).erase();
    }
  });

  group('StorageMigrationV3.apply', () {
    test('Replace keys on enum-base names', () async {
      for (final c in containers) {
        final storage = GetStorage(c);

        await storage.write('0', 'v0');
        await storage.write('1', 'v1');
        await storage.write('tycho', 'vTycho');
        await storage.write('unknown', 'vCustom');

        expect(storage.read<String>('0'), 'v0');
        expect(storage.read<String>('1'), 'v1');
        expect(storage.read<String>('tycho'), 'vTycho');
        expect(storage.read<String>('unknown'), 'vCustom');
      }

      await migration.apply();

      for (final c in containers) {
        final storage = GetStorage(c);

        // Not delete old key
        expect(storage.read<String>('0'), 'v0');
        expect(storage.read<String>('1'), 'v1');
        expect(storage.read<String>('tycho'), 'vTycho');
        expect(storage.read<String>('unknown'), 'vCustom');

        expect(storage.read<String>('_NetworkType.ever'), 'v0');
        expect(storage.read<String>('_NetworkType.venom'), 'v1');
        expect(storage.read<String>('_NetworkType.tycho'), 'vTycho');
        expect(storage.read<String>('_NetworkType.custom'), 'vCustom');
      }
    });

    test('Other num index to _NetworkType.custom', () async {
      for (final c in containers) {
        final storage = GetStorage(c);

        await storage.write('99', 'vOutOfRange');

        expect(storage.read<String>('99'), 'vOutOfRange');
      }

      await migration.apply();

      for (final c in containers) {
        final storage = GetStorage(c);

        // Old key
        expect(storage.read<String>('99'), 'vOutOfRange');

        expect(storage.read<String>('_NetworkType.custom'), 'vOutOfRange');
      }
    });
  });
}
