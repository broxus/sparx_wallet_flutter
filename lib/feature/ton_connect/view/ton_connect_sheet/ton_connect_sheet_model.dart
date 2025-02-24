import 'dart:convert';
import 'dart:typed_data';

import 'package:app/app/service/service.dart';
import 'package:app/app/service/ton_connect/models/models.dart';
import 'package:app/utils/utils.dart';
import 'package:convert/convert.dart';
import 'package:crypto/crypto.dart';
import 'package:elementary/elementary.dart';
import 'package:http/http.dart' as http;
import 'package:nekoton_repository/nekoton_repository.dart';

class TonConnectModel extends ElementaryModel {
  TonConnectModel(
    ErrorHandler errorHandler,
    this._nekotonRepository,
    this._currentAccountsService,
  ) : super(errorHandler: errorHandler);

  final NekotonRepository _nekotonRepository;
  final CurrentAccountsService _currentAccountsService;

  String get symbol => currentTransport.nativeTokenTicker;

  KeyAccount? get currentAccount =>
      _currentAccountsService.currentActiveAccount;

  List<KeyAccount> get accounts => _nekotonRepository.seedList.seeds
      .expand(
        (seed) => seed.allKeys.expand(
          (key) => key.accountList.allAccounts,
        ),
      )
      .where((account) => !account.isHidden)
      .toList();

  TransportStrategy get currentTransport => _nekotonRepository.currentTransport;

  Future<DappManifest> getManifest(String manifestUrl) async {
    final uri = Uri.parse(manifestUrl);
    final response = await http.get(uri);

    if (response.statusCode == 200) {
      return DappManifest.fromJson(
        jsonDecode(response.body) as Map<String, dynamic>,
      );
    }

    throw Exception('Failed to load DappManifest');
  }

  Future<Money?> getBalance(KeyAccount account) async {
    final wallet = _nekotonRepository.walletsMap[account.address]?.wallet ??
        await _getWallet(account);

    return Money.fromBigIntWithCurrency(
      wallet.contractState.balance,
      Currencies()[currentTransport.nativeTokenTicker]!,
    );
  }

  Future<TonWallet> _getWallet(KeyAccount account) async {
    TonWallet? wallet;
    try {
      wallet = await TonWallet.subscribe(
        transport: currentTransport.transport,
        workchainId: account.workchain,
        publicKey: account.publicKey,
        walletType: account.account.tonWallet.contract,
      );
    } finally {
      wallet?.dispose();
    }
    return wallet;
  }

  Future<List<ConnectItemReply>> createReplyItems({
    required String password,
    required ConnectRequest request,
    required KeyAccount account,
    required DappManifest manifest,
    bool isTestnet = false,
  }) async {
    final replyItems = <ConnectItemReply>[];

    for (final item in request.items) {
      final replyItem = switch (item) {
        TonAddressItem() => ConnectItemReply.tonAddress(
            network: isTestnet ? TonNetwork.testnet : TonNetwork.mainnet,
            address: account.address,
            publicKey: account.publicKey,
            walletStateInit: '', // TODO: wallet state init
          ),
        TonProofItem(:final payload) => ConnectItemReply.tonProofSuccess(
            proof: await _createProof(
              password: password,
              payload: payload,
              account: account,
              manifest: manifest,
            ),
          ),
      };

      replyItems.add(replyItem);
    }

    return replyItems;
  }

  Future<TonProof> _createProof({
    required String password,
    required String payload,
    required KeyAccount account,
    required DappManifest manifest,
  }) async {
    final timestamp = NtpTime.now().millisecondsSinceEpoch ~/ 1000;
    final timestampBytes = ByteData(8)..setInt64(0, timestamp, Endian.little);

    final domain = Uri.parse(manifest.url).host;
    final domainBytes = utf8.encode(domain);
    final domainLength = ByteData(4)
      ..setInt32(
        0,
        domainBytes.length,
        Endian.little,
      );

    final addressParts = account.address.toRaw().split(':');
    final workchain = int.parse(addressParts[0]);
    final addrHash = addressParts[1];

    final addressWorkchain = ByteData(4)..setInt32(0, workchain);
    final addressBuffer = <int>[
      ...addressWorkchain.buffer.asUint8List(),
      ...hex.decode(addrHash),
    ];

    final messageBuffer = <int>[
      ...utf8.encode('ton-proof-item-v2/'),
      ...addressBuffer,
      ...domainLength.buffer.asUint8List(),
      ...domainBytes,
      ...timestampBytes.buffer.asUint8List(),
      ...utf8.encode(payload),
    ];

    final messageHash = sha256.convert(messageBuffer).bytes;

    final bufferToSign = <int>[
      ...hex.decode('ffff'),
      ...utf8.encode('ton-connect'),
      ...messageHash,
    ];

    final signedData = await _nekotonRepository.seedList.signRawData(
      data: base64Encode(bufferToSign),
      publicKey: account.publicKey,
      password: password,
      signatureId: null,
    );

    return TonProof(
      payload: payload,
      timestamp: timestamp.toString(),
      signature: signedData.signature,
      domain: TonProofDomain(
        lengthBytes: domainBytes.lengthInBytes,
        value: domain,
      ),
    );
  }
}
