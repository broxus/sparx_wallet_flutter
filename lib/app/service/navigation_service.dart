import 'dart:async';
import 'package:encrypted_storage/encrypted_storage.dart';
import 'package:injectable/injectable.dart';

@singleton
class NavigationService {
  NavigationService(this._encryptedStorage);

  static const _domain = 'NavigationService';
  static const _stateKey = 'statev2';

  final EncryptedStorage _encryptedStorage;

  Future<String?> getSavedState() {
    return _encryptedStorage.get(
      _stateKey,
      domain: _domain,
    );
  }

  Future<void> saveLastLocation(String location) async {
    // If it is supposed to be saved, save it to storage
    await _encryptedStorage.set(
      _stateKey,
      location,
      domain: _domain,
    );
  }
}
