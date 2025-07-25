import 'dart:convert';

import 'package:hex/hex.dart';
import 'package:pinenacl/api.dart';
import 'package:pinenacl/x25519.dart'
    show Box, EncryptedMessage, PrivateKey, PublicKey;

class SessionCrypto {
  SessionCrypto({String? pk}) {
    privateKey = pk != null ? PrivateKey.decode(pk) : PrivateKey.generate();
    sessionId = HEX.encode(privateKey.publicKey);
  }

  factory SessionCrypto.fromJson(String json) => SessionCrypto(pk: json);

  late final PrivateKey privateKey;
  late final String sessionId;

  String encrypt(String message, String stringReceiverPubKey) {
    final hexReceiverPubKey = HEX.decode(stringReceiverPubKey);
    final uintReceiverPubKey = Uint8List.fromList(hexReceiverPubKey);
    final receiverPk = PublicKey(uintReceiverPubKey);

    final box = Box(myPrivateKey: privateKey, theirPublicKey: receiverPk);
    final encrypted = box.encrypt(Uint8List.fromList(utf8.encode(message)));

    return base64Encode(encrypted);
  }

  String decrypt(String message, String stringSenderPubKey) {
    final msg = base64.decode(message);

    final hexSenderPubKey = HEX.decode(stringSenderPubKey);
    final uintSenderPubKey = Uint8List.fromList(hexSenderPubKey);
    final senderPk = PublicKey(uintSenderPubKey);

    final box = Box(myPrivateKey: privateKey, theirPublicKey: senderPk);
    final decrypted = box.decrypt(EncryptedMessage.fromList(msg));

    return utf8.decode(decrypted);
  }

  String toJson() => privateKey.encode();
}
