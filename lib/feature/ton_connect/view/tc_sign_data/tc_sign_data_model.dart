import 'dart:async';
import 'dart:convert';
import 'dart:typed_data';

import 'package:app/app/service/service.dart';
import 'package:app/app/service/ton_connect/ton_connect.dart';
import 'package:app/utils/utils.dart';
import 'package:crypto/crypto.dart';
import 'package:elementary/elementary.dart';
import 'package:nekoton_repository/nekoton_repository.dart' hide Message;

class TCSignDataModel extends ElementaryModel {
  TCSignDataModel(
    ErrorHandler errorHandler,
    this._nekotonRepository,
    this._messengerService,
    this._tonConnectService,
  ) : super(errorHandler: errorHandler);

  final NekotonRepository _nekotonRepository;
  final MessengerService _messengerService;
  final TonConnectService _tonConnectService;

  TransportStrategy get transport => _nekotonRepository.currentTransport;

  Future<DappManifest> getManifest(String manifestUrl) =>
      _tonConnectService.getManifest(manifestUrl);

  KeyAccount? getAccount(Address address) =>
      _nekotonRepository.seedList.findAccountByAddress(address);

  Future<SignDataResult> signData({
    required int schema,
    required String cell,
    required PublicKey publicKey,
    required String password,
  }) async {
    final timestamp = NtpTime.now().millisecondsSinceEpoch ~/ 1000;
    final data = <int>[
      ..._uint32BE(schema),
      ..._uint64BE(timestamp),
      ...sha256.convert(utf8.encode(cell)).bytes,
    ];

    final signedData = await _nekotonRepository.seedList.signData(
      data: base64Encode(data),
      publicKey: publicKey,
      password: password,
      signatureId: null, // signatureId is not used in this context
    );

    return SignDataResult(
      signature: signedData.signature,
      timestamp: timestamp.toString(),
    );
  }

  void showMessage(Message message) {
    _messengerService.show(message);
  }

  /// Converts an integer to a list of bytes in big-endian (32-bit) format.
  List<int> _uint32BE(int value) {
    final byteData = ByteData(4)..setUint32(0, value);
    return byteData.buffer.asUint8List();
  }

  /// Converts an integer to a list of bytes in big-endian (64-bit) format.
  List<int> _uint64BE(int value) {
    final byteData = ByteData(8)..setUint64(0, value);
    return byteData.buffer.asUint8List();
  }
}
