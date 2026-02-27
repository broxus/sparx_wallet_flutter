import 'package:app/app/service/service.dart';
import 'package:injectable/injectable.dart';

@lazySingleton
class UpdateVersionStorageService extends AbstractStorageService {
  UpdateVersionStorageService(this._storageAdapter, this._ntpService)
    : _storage = _storageAdapter.box(container);

  static const String container = 'update_version_storage_service';
  static const String _warningLastTimeKey = 'warningLastTime';
  static const String _warningCountKey = 'warningCount';
  static const String _versionForUpdateKey = 'versionForUpdate';

  final StorageAdapter _storageAdapter;
  final StorageBox _storage;
  final NtpService _ntpService;

  @override
  Future<void> init() => _storageAdapter.init(container);

  @override
  Future<void> clear() async {
    try {
      await _storage.erase();
    } catch (_) {}
  }

  int? warningCount() {
    return _storage.read(_warningCountKey);
  }

  int? warningLastTime() {
    return _storage.read(_warningLastTimeKey);
  }

  String? versionForUpdate() {
    return _storage.read(_versionForUpdateKey);
  }

  void updateWarningCount(int newCount) {
    _storage.write(_warningCountKey, newCount);
  }

  void clearWarningLastTime() {
    _storage.write(_warningLastTimeKey, null);
  }

  void updateWarningLastTime() {
    _storage.write(
      _warningLastTimeKey,
      _ntpService.now().millisecondsSinceEpoch,
    );
  }

  void updateVersionForUpdate(String? versionForUpdate) {
    _storage.write(_versionForUpdateKey, versionForUpdate);
  }
}
