import 'package:app/di/di.dart';
import 'package:encrypted_storage/encrypted_storage.dart';
import 'package:injectable/injectable.dart';
import 'package:logging/logging.dart';

@injectable
class EncryptedStorageConfigurator {
  EncryptedStorageConfigurator(
    this._encryptedStorage,
  );

  final EncryptedStorage _encryptedStorage;
  final _log = Logger('bootstrap');

  Future<void> configure() async {
    _log.finest('EncryptedStorage initializating...');

    await _encryptedStorage.init();

    _log.finest('EncryptedStorage initialized');
  }
}
