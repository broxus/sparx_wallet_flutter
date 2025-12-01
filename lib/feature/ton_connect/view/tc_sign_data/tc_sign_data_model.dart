import 'dart:async';
import 'dart:convert';
import 'dart:typed_data';

import 'package:app/app/service/ntp_service.dart';
import 'package:app/app/service/service.dart';
import 'package:app/feature/messenger/data/message.dart';
import 'package:app/feature/messenger/domain/service/messenger_service.dart';
import 'package:app/feature/ton_connect/ton_connect.dart';
import 'package:app/utils/utils.dart';
import 'package:convert/convert.dart';
import 'package:elementary/elementary.dart';
import 'package:injectable/injectable.dart';
import 'package:nekoton_repository/nekoton_repository.dart' hide Message;

@injectable
class TCSignDataModel extends ElementaryModel {
  TCSignDataModel(
    ErrorHandler errorHandler,
    this._nekotonRepository,
    this._messengerService,
    this._ntpService,
  ) : super(errorHandler: errorHandler);

  final NekotonRepository _nekotonRepository;
  final MessengerService _messengerService;
  final NtpService _ntpService;

  TransportStrategy get transport => _nekotonRepository.currentTransport;

  KeyAccount? getAccount(Address address) =>
      _nekotonRepository.seedList.findAccountByAddress(address);

  Future<SignDataResult> signData({
    required SignDataPayload payload,
    required KeyAccount account,
    required DappManifest manifest,
    required SignInputAuth signInputAuth,
  }) async {
    final timestamp = _ntpService.now().secondsSinceEpoch;
    final timestampBytes = ByteData(8)..setInt64(0, timestamp);

    final domain = manifest.url.host;
    final domainBytes = utf8.encode(domain);
    final domainLength = ByteData(4)..setInt32(0, domainBytes.length);

    final addressParts = account.address.toRaw().split(':');
    final workchain = int.parse(addressParts[0]);
    final addrHash = addressParts[1];

    final addressWorkchain = ByteData(4)..setInt32(0, workchain);
    final addressBuffer = <int>[
      ...addressWorkchain.buffer.asUint8List(),
      ...hex.decode(addrHash),
    ];

    final messageBuffer = <int>[
      ...hex.decode('ffff'),
      ...utf8.encode('ton-connect/sign-data/'),
      ...addressBuffer,
      ...domainLength.buffer.asUint8List(),
      ...domainBytes,
      ...timestampBytes.buffer.asUint8List(),
      ..._makePayload(payload),
    ];

    final signedData = await _nekotonRepository.seedList.signData(
      data: base64Encode(messageBuffer),
      publicKey: account.publicKey,
      signInputAuth: signInputAuth,
      signatureId: null,
    );

    return SignDataResult(
      signature: signedData.signature,
      timestamp: timestamp,
      address: account.address,
      domain: domain,
      payload: payload,
    );
  }

  void showMessage(Message message) {
    _messengerService.show(message);
  }

  List<int> _makePayload(SignDataPayload payload) => switch (payload) {
    SignDataPayloadText(:final text) => utf8.encode(text).let((text) {
      final textLength = ByteData(4)..setInt32(0, text.length);
      return <int>[
        ...utf8.encode('txt'),
        ...textLength.buffer.asUint8List(),
        ...text,
      ];
    }),
    SignDataPayloadBinary(:final bytes) => base64Decode(bytes).let((bytes) {
      final bytesLength = ByteData(4)..setInt32(0, bytes.length);
      return <int>[
        ...utf8.encode('bin'),
        ...bytesLength.buffer.asUint8List(),
        ...bytes,
      ];
    }),
    // TODO(komarov): implement cell payload in Nekoton
    SignDataPayloadCell() => throw UnimplementedError(),
  };
}
