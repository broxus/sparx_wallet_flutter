import 'package:app/app/service/storage_service/connections_storage/connections_storage_service.dart';
import 'package:app/app/service/storage_service/general_storage_service.dart';
import 'package:app/app/service/storage_service/migrations/storage_migrations/storage_migration.dart';

class StorageMigrationV5 implements StorageMigration {
  StorageMigrationV5(
    this._generalStorageService,
    this._connectionsStorageService,
  );

  static const int version = 5;

  final GeneralStorageService _generalStorageService;
  final ConnectionsStorageService _connectionsStorageService;

  @override
  Future<void> apply() async {
    await _migrateNetworkGroup();
  }

  @override
  Future<void> complete() async {}

  Future<void> _migrateNetworkGroup() async {
    var lastNetworkGroupNumber = 10000;

    final connections = [..._connectionsStorageService.connections];

    final customAssets = _generalStorageService.readRawCustomAssets('custom');

    final systemAssets = _generalStorageService.readRawSystemAssets('custom');

    await _generalStorageService.removeRawCustomAssets('custom');
    await _generalStorageService.removeRawSystemAssets('custom');

    for (final connection in connections) {
      if (connection.defaultWorkchain.networkGroup != 'custom') {
        continue;
      }

      final groupName = '${connection.defaultWorkchain.networkGroup}'
          '-'
          '${lastNetworkGroupNumber++}';

      _connectionsStorageService.updateConnection(
        connection.copyWith(
          workchains: [
            connection.defaultWorkchain.copyWith(
              networkGroup: groupName,
            ),
          ],
        ),
      );

      await _generalStorageService.writeRawCustomAssets(
        groupName,
        customAssets,
      );

      await _generalStorageService.writeRawSystemAssets(
        groupName,
        systemAssets,
      );
    }
  }
}
