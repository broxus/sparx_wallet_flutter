import 'package:app/app/service/storage_service/storage_service.dart';

class StorageMigrationV2 implements StorageMigration {
  StorageMigrationV2(this._storageAdapter);

  static const int version = 2;

  final StorageAdapter _storageAdapter;

  @override
  Future<void> apply() async {
    for (final container in BalanceStorageService.containers) {
      await _storageAdapter.init(container);
      await _storageAdapter.box(container).erase();
    }
  }

  @override
  Future<void> complete() async {}
}
