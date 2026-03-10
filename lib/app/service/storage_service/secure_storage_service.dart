import 'dart:async';

import 'package:app/app/service/service.dart';
import 'package:app/feature/presets_config/data/preset_config_type.dart';
import 'package:encrypted_storage/encrypted_storage.dart';
import 'package:injectable/injectable.dart';
import 'package:nekoton_repository/nekoton_repository.dart';

const _passwordsKey = 'passwords_key';
const _passwordServiceStateKey = 'password_service_state_key';

/// This is a wrapper-class above [EncryptedStorage] that provides methods
/// to interact with general information that is not related to some specified
/// module.
@singleton
class SecureStorageService extends AbstractStorageService {
  SecureStorageService(this._storage);

  /// Storage that is used to store data
  final EncryptedStorage _storage;

  @override
  Future<void> init() => Future.value();

  @override
  Future<void> clear() async {
    await _storage.clearAll();
  }

  /// Get password of public key if it was cached with biometry
  Future<String?> getKeyPassword(PublicKey publicKey) =>
      _storage.get(publicKey.publicKey, domain: _passwordsKey);

  /// Set password of public key to cache it with biometry
  Future<void> setKeyPassword({
    required PublicKey publicKey,
    required String password,
  }) => _storage.set(publicKey.publicKey, password, domain: _passwordsKey);

  /// Remove password of public key from cache
  Future<void> removeKeyPassword(PublicKey publicKey) =>
      _storage.delete(publicKey.publicKey, domain: _passwordsKey);

  /// Clear all passwords of public keys from cache
  Future<void> clearKeyPasswords() => _storage.clearDomain(_passwordsKey);

  /// Generic methods for working with different config types

  /// Get config JSON string for the specified config type
  Future<String?> getConfigJson(PresetConfigType<dynamic> configType) {
    return _storage.get(configType.storageKey, domain: configType.name);
  }

  /// Set config JSON string for the specified config type
  Future<void> setConfigJson(
    PresetConfigType<dynamic> configType,
    String data,
  ) {
    return _storage.set(configType.storageKey, data, domain: configType.name);
  }

  /// Get config JSON hash for the specified config type
  Future<String?> getConfigJsonHash(PresetConfigType<dynamic> configType) {
    return _storage.get(
      '${configType.storageKey}_hash',
      domain: configType.name,
    );
  }

  /// Set config JSON hash for the specified config type
  Future<void> setConfigJsonHash(
    PresetConfigType<dynamic> configType,
    String hash,
  ) {
    return _storage.set(
      '${configType.storageKey}_hash',
      hash,
      domain: configType.name,
    );
  }

  Future<void> setPasswordServiceStateJson(String json) {
    return _storage.set(_passwordServiceStateKey, json);
  }

  Future<String?> getPasswordServiceStateJson() {
    return _storage.get(_passwordServiceStateKey);
  }
}
