import 'package:app/app/service/storage_service/abstract_storage_service.dart';
import 'package:app/utils/common_utils.dart';
import 'package:get_storage/get_storage.dart';
import 'package:injectable/injectable.dart';

@lazySingleton
class UpdateVersionStorageService extends AbstractStorageService {
  UpdateVersionStorageService(
    @Named(container) this._storage,
  );

  static const String container = 'update_version_storage_service';
  static const String _warningLastTimeKey = 'warningLastTime';
  static const String _warningCountKey = 'warningCount';

  final GetStorage _storage;

  @override
  Future<void> init() => GetStorage.init(container);

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

  void updateWarningCount(int newCount) {
    _storage.write(_warningCountKey, newCount);
  }

  void updateWarningLastTime() {
    _storage.write(_warningLastTimeKey, NtpTime.now().millisecondsSinceEpoch);
  }
}
