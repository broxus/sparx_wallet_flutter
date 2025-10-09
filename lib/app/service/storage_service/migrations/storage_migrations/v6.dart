import 'package:app/app/service/storage_service/connections_storage/connections_ids_data.dart';
import 'package:app/app/service/storage_service/connections_storage/connections_storage_service.dart';
import 'package:app/app/service/storage_service/general_storage_service.dart';
import 'package:app/app/service/storage_service/migrations/storage_migrations/storage_migration.dart';
import 'package:app/utils/json/json.dart';
import 'package:app/utils/parse_utils.dart';
import 'package:get_storage/get_storage.dart';

class StorageMigrationV6 implements StorageMigration {
  StorageMigrationV6();

  static const int version = 6;

  @override
  Future<void> apply() async {
    await _migrateIdsGroup();
  }

  @override
  Future<void> complete() async {}

  Future<void> _migrateIdsGroup() async {
    await GetStorage.init(ConnectionsStorageService.container);

    final storage = GetStorage(ConnectionsStorageService.container);

    await storage.remove('networks_ids');
  }
}
