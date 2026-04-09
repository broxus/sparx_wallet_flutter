import 'package:app/app/service/storage_service/balance_storage_service.dart';
import 'package:app/app/service/storage_service/migrations/storage_migrations/v2.dart';
import 'package:flutter_test/flutter_test.dart';

import '../../helpers/helpers.dart';

void main() {
  group('StorageMigrationV2', () {
    late InMemoryStorageAdapter storageAdapter;
    late StorageMigrationV2 migration;

    setUp(() {
      storageAdapter = InMemoryStorageAdapter();
      migration = StorageMigrationV2(storageAdapter);
    });

    test('erases all balance containers', () async {
      for (final container in BalanceStorageService.containers) {
        final storage = storageAdapter.box(container);
        await storage.write('key-1', 'value-1');
        await storage.write('key-2', 'value-2');
      }

      await migration.apply();

      for (final container in BalanceStorageService.containers) {
        expect(storageAdapter.box(container).getEntries(), isEmpty);
      }
    });
  });
}
