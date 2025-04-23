import 'package:app/app/service/messenger/message.dart';
import 'package:app/app/service/messenger/service/messenger_service.dart';
import 'package:elementary/elementary.dart';
import 'package:encrypted_storage/encrypted_storage.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';

class QaModel extends ElementaryModel {
  QaModel({
    required EncryptedStorage storage,
    required MessengerService messengerService,
  })  : _storage = storage,
        _messengerService = messengerService;

  static const String _keyKey = 'cipher_storage_key';
  static const String _ivKey = 'cipher_storage_iv';

  final EncryptedStorage _storage;
  final MessengerService _messengerService;

  final _fss = const FlutterSecureStorage(
    aOptions: AndroidOptions(encryptedSharedPreferences: true),
  );

  Future<void> clearEncryptedDb() async {
    await _storage.clearAll();
  }

  Future<void> clearEncryptedKeys() async {
    final key = await readKey();
    if (key != null) {
      await _fss.delete(key: _keyKey);
    }

    final iv = await readIv();
    if (iv != null) {
      await _fss.delete(key: _ivKey);
    }
  }

  void showSuccessMessage(String message) {
    _messengerService.show(
      Message.successful(message: message),
    );
  }

  Future<String?> readIv() => _fss.read(key: _ivKey);

  Future<String?> readKey() => _fss.read(key: _keyKey);
}
