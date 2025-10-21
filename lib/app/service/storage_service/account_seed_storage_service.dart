import 'package:app/app/service/service.dart';
import 'package:encrypted_storage/encrypted_storage.dart';
import 'package:injectable/injectable.dart';
import 'package:logging/logging.dart';
import 'package:nekoton_repository/nekoton_repository.dart';

/// This is a wrapper-class above [EncryptedStorage] that provides methods
/// to interact account/seed/public keys.
@singleton
class NekotonStorageService extends NekotonStorageRepository
    implements AbstractStorageService {
  NekotonStorageService({required EncryptedStorage storage})
    : _storage = storage,
      super(storage);

  final EncryptedStorage _storage;

  final _logger = Logger('NekotonStorageService');

  @override
  Future<void> init() async {
    try {
      return await super.init();
    } catch (e, s) {
      _logger.severe('Failed to init NekotonStorageRepository', e, s);

      if (_isEcnryptionError(e, s)) {
        // If the key is lost we could only clear the db
        await _storage.clearAll();
        return super.init();
      }

      Error.throwWithStackTrace(e, s);
    }
  }

  @override
  Future<void> clear() async {
    try {
      return await clearSensitiveData();
    } catch (_) {}
  }

  @override
  Future<String?> getStorageData(String key) {
    try {
      return super.getStorageData(key);
    } catch (e, s) {
      _logger.severe('Failed to get storage data for key: $key', e, s);
      rethrow;
    }
  }

  @override
  Future<void> setStorageData({required String key, required String value}) {
    try {
      return super.setStorageData(key: key, value: value);
    } catch (e, s) {
      _logger.severe('Failed to set storage data for key: $key', e, s);
      rethrow;
    }
  }

  @override
  Future<void> removeStorageData(String key) {
    try {
      return super.removeStorageData(key);
    } catch (e, s) {
      _logger.severe('Failed to remove storage data for key: $key', e, s);
      rethrow;
    }
  }

  @override
  Future<void> clearStorageData() {
    try {
      return super.clearStorageData();
    } catch (e, s) {
      _logger.severe('Failed to clear storage data', e, s);
      rethrow;
    }
  }

  bool _isEcnryptionError(Object e, StackTrace s) {
    final errorString = e.toString();
    final stackTraceString = s.toString();

    return errorString.contains('PaddingException') ||
        stackTraceString.contains('PKCS7Padding.padCount') ||
        stackTraceString.contains('AES.decrypt') ||
        stackTraceString.contains('Encrypter.decrypt');
  }
}
