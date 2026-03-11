import 'package:app/app/service/service.dart';
import 'package:app/feature/presets_config/data/preset_config_type.dart';
import 'package:injectable/injectable.dart';

@singleton
class ConfigStorageService extends AbstractStorageService {
  ConfigStorageService(this._storageAdapter)
    : _storage = _storageAdapter.box(container);

  static const String container = 'config_storage_service';
  static const String _hashKeySuffix = '_hash';

  final StorageAdapter _storageAdapter;
  final StorageBox _storage;

  @override
  Future<void> init() => _storageAdapter.init(container);

  @override
  Future<void> clear() async {
    try {
      await _storage.erase();
    } catch (_) {}
  }

  Future<String?> getConfigJson(PresetConfigType<dynamic> configType) async {
    return _storage.read<String>(configType.storageKey);
  }

  Future<void> setConfigJson(
    PresetConfigType<dynamic> configType,
    String data,
  ) {
    return _storage.write(configType.storageKey, data);
  }

  Future<String?> getConfigJsonHash(
    PresetConfigType<dynamic> configType,
  ) async {
    return _storage.read<String>('${configType.storageKey}$_hashKeySuffix');
  }

  Future<void> setConfigJsonHash(
    PresetConfigType<dynamic> configType,
    String hash,
  ) {
    return _storage.write('${configType.storageKey}$_hashKeySuffix', hash);
  }
}
