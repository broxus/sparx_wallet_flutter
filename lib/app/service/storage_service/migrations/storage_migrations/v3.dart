import 'package:app/app/service/storage_service/storage_service.dart';
import 'package:app/utils/common_utils.dart';

class StorageMigrationV3 implements StorageMigration {
  StorageMigrationV3(this._storageAdapter);

  static const int version = 3;

  final StorageAdapter _storageAdapter;

  @override
  Future<void> apply() async {
    final containers = [
      GeneralStorageService.currenciesContainer,
      GeneralStorageService.systemContractAssetsContainer,
      GeneralStorageService.customContractAssetsContainer,
    ];

    for (final container in containers) {
      await _storageAdapter.init(container);

      final storage = _storageAdapter.box(container);
      final encoded = storage.getEntries();

      for (final entry in encoded.entries) {
        try {
          final key = _NetworkType.from(entry.key);
          final value = entry.value;

          // TODO(knightforce): Why not delete old key?
          await storage.write(key.toString(), value);
        } catch (_) {
          await storage.remove(entry.key);
        }
      }
    }
  }

  @override
  Future<void> complete() async {}
}

enum _NetworkType {
  ever,
  venom,
  tycho,
  ton,
  custom;

  factory _NetworkType.from(String value) =>
      int.tryParse(value)?.let(
        (index) => index < _NetworkType.values.length
            ? _NetworkType.values[index]
            : null,
      ) ??
      _NetworkType.values.firstWhere(
        (e) => e.toString().split('.').last == value,
        orElse: () => _NetworkType.custom,
      );
}
