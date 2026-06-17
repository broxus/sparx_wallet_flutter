import 'dart:convert';
import 'dart:io';
import 'dart:typed_data';

import 'package:crypto/crypto.dart';
import 'package:encrypt/encrypt.dart';
import 'package:encrypted_storage/encrypted_storage.dart';
import 'package:injectable/injectable.dart';
import 'package:logging/logging.dart';
import 'package:path_provider/path_provider.dart';

const _domains = [
  'default',
  'passwords_key',
  'hidden_accounts_key',
  'seeds_meta_key',
  'nekoton_bridge_key',
  'external_accounts_key',
  'account_seed_preferences_key',
];

/// AES-256 requires a 32-byte (256-bit) key for encryption.
const _keyLength = 32;

/// AES-GCM mode requires a 16-byte (128-bit) initialization vector (IV).
const _ivLength = 16;

const _fileName = 'storage_backup.json';

@singleton
class StorageBackupService {
  StorageBackupService(this._encryptedStorage);

  final EncryptedStorage _encryptedStorage;
  final _logger = Logger('StorageBackupService');

  Future<bool> isBackupAvailable() async {
    try {
      final directory = await _getBackupDirectory();
      final file = File('${directory.path}/$_fileName');
      return file.existsSync();
    } catch (e, st) {
      _logger.warning('Failed to check backup availability', e, st);
      return false;
    }
  }

  Future<void> backup(String password) async {
    try {
      final key = _createKeyFromPassword(password);
      final iv = IV.fromSecureRandom(_ivLength);

      final data = await _getBackupDataFromSecureStorage();

      final encrypter = Encrypter(AES(key, mode: AESMode.gcm));
      final encrypted = encrypter.encrypt(jsonEncode(data), iv: iv);

      final backup = jsonEncode({'iv': iv.base64, 'data': encrypted.base64});

      await _writeBackupDataToFile(backup);
    } catch (e, st) {
      _logger.severe('Error during backup', e, st);
      rethrow;
    }
  }

  Future<void> restore(String password) async {
    try {
      final key = _createKeyFromPassword(password);

      // Load the encrypted backup from secure storage or a file
      final backup = await _readBackupDataFromFile();

      final backupData = jsonDecode(backup) as Map<String, dynamic>;
      final iv = IV.fromBase64(backupData['iv'] as String);
      final encryptedData = Encrypted.fromBase64(backupData['data'] as String);

      final encrypter = Encrypter(AES(key, mode: AESMode.gcm));
      final decryptedData = encrypter.decrypt(encryptedData, iv: iv);

      await _writeBackupDataToSecureStorage(decryptedData);
    } catch (e, st) {
      _logger.severe('Error during restore', e, st);
      rethrow;
    }
  }

  Future<void> deleteBackupFile() async {
    try {
      final directory = await _getBackupDirectory();
      final file = File('${directory.path}/$_fileName');

      if (file.existsSync()) {
        await file.delete();
      }
    } catch (e, st) {
      _logger.warning('Failed to delete backup file', e, st);
    }
  }

  Future<Map<String, String>> _getBackupDataFromSecureStorage() async {
    final data = <String, String>{};

    for (final domain in _domains) {
      final domainData = await _encryptedStorage.getDomain(domain: domain);
      data[domain] = jsonEncode(domainData);
    }

    return data;
  }

  Future<void> _writeBackupDataToSecureStorage(String backup) async {
    final data = jsonDecode(backup) as Map<String, dynamic>;

    for (final domain in _domains) {
      final rawDomainData = data[domain] as String?;

      if (rawDomainData != null) {
        final domainData = jsonDecode(rawDomainData) as Map<String, dynamic>;

        await _encryptedStorage.setDomain(
          Map<String, String>.from(domainData),
          domain: domain,
        );
      }
    }
  }

  Future<void> _writeBackupDataToFile(String backup) async {
    final directory = await _getBackupDirectory();
    final file = File('${directory.path}/$_fileName');

    if (!directory.existsSync()) {
      await directory.create(recursive: true);
    }

    if (file.existsSync()) {
      await file.delete();
    }

    await file.writeAsString(backup);
  }

  Future<String> _readBackupDataFromFile() async {
    final directory = await _getBackupDirectory();
    final file = File('${directory.path}/$_fileName');

    if (!file.existsSync()) {
      throw Exception('Backup file not found');
    }

    return file.readAsString();
  }

  Future<Directory> _getBackupDirectory() async {
    try {
      return await getApplicationDocumentsDirectory();
    } catch (e, st) {
      _logger.warning('Failed to get application documents directory', e, st);
    }

    try {
      return await getApplicationSupportDirectory();
    } catch (e, st) {
      _logger.warning('Failed to get application support directory', e, st);
    }

    throw Exception('Failed to get a valid directory for backup');
  }

  Key _createKeyFromPassword(String password) {
    final passwordBytes = utf8.encode(password);
    final keyBytes = sha256.convert(passwordBytes).bytes;

    return Key(Uint8List.fromList(keyBytes.take(_keyLength).toList()));
  }
}
