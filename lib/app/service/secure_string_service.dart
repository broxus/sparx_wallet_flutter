import 'package:app/utils/utils.dart';
import 'package:encrypt/encrypt.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:injectable/injectable.dart';
import 'package:logging/logging.dart';
import 'package:mutex/mutex.dart';

/// AES-256 requires a 32-byte (256-bit) key for encryption.
const _keyLength = 32;

/// AES-GCM mode requires a 16-byte (128-bit) initialization vector (IV).
const _ivLength = 16;

@singleton
class SecureStringService {
  static const String _keyKey = 'secure_string_key';
  static final _logger = Logger('SecureStringService');

  final _mutex = Mutex();
  final _fss = const FlutterSecureStorage(
    aOptions: AndroidOptions(encryptedSharedPreferences: true),
  );

  Future<SecureString> encrypt(String plaintext) async {
    final key = await _getOrCreateKey();
    final iv = IV.fromSecureRandom(_ivLength);
    final encrypter = Encrypter(AES(key, mode: AESMode.gcm));
    final encrypted = encrypter.encrypt(plaintext, iv: iv);

    return SecureString(iv: iv, value: encrypted.base64);
  }

  Future<String> decrypt(SecureString secureString) async {
    final key = await _getOrCreateKey();
    final encrypter = Encrypter(AES(key, mode: AESMode.gcm));
    final encrypted = Encrypted.fromBase64(secureString.value);

    return encrypter.decrypt(encrypted, iv: secureString.iv);
  }

  Future<Key> _getOrCreateKey() async {
    await _mutex.acquire();

    try {
      final stored = await _fss.read(key: _keyKey);
      if (stored != null) {
        return Key.fromBase64(stored);
      }

      final key = Key.fromSecureRandom(_keyLength);
      await _fss.write(key: _keyKey, value: key.base64);

      return key;
    } catch (e, st) {
      _logger.severe('Error getting or creating encryption key', e, st);
      throw const UiException('Encryption error');
    } finally {
      _mutex.release();
    }
  }
}

final class SecureString {
  const SecureString({required this.iv, required this.value});

  factory SecureString.fromJson(Map<String, dynamic> json) {
    return SecureString(
      iv: IV.fromBase64(json['iv'] as String),
      value: json['value'] as String,
    );
  }

  final IV iv;
  final String value;

  Map<String, dynamic> toJson() => {'iv': iv.base64, 'value': value};
}
