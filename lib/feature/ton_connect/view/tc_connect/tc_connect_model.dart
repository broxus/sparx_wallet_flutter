import 'dart:convert';
import 'dart:typed_data';

import 'package:app/app/service/service.dart';
import 'package:app/utils/utils.dart';
import 'package:convert/convert.dart';
import 'package:crypto/crypto.dart';
import 'package:elementary/elementary.dart';
import 'package:injectable/injectable.dart';
import 'package:nekoton_repository/nekoton_repository.dart';

@injectable
class TCConnectModel extends ElementaryModel {
  TCConnectModel(
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

  Future<Money?> getBalance(KeyAccount account) async {
    final wallet = await _getWallet(account);
    if (wallet == null) return null;

    return Money.fromBigIntWithCurrency(
      wallet.contractState.balance,
      Currencies()[currentTransport.nativeTokenTicker]!,
    );
  }

  Future<TonWallet?> _getWallet(KeyAccount keyAccount) async =>
      _nekotonRepository.walletsMap[keyAccount.address]?.wallet ??
      (await _nekotonRepository.subscribe(keyAccount.account.tonWallet)).wallet;

  Future<List<ConnectItemReply>> createReplyItems({
    required String password,
    required ConnectRequest request,
    required KeyAccount account,
    required DappManifest manifest,
    bool isTestnet = false,
  }) async {
    final replyItems = <ConnectItemReply>[];
    final wallet = await _getWallet(account);

    for (final item in request.items) {
      final replyItem = switch (item) {
        TonAddressItem() => ConnectItemReply.tonAddress(
            network: isTestnet ? TonNetwork.testnet : TonNetwork.mainnet,
            address: account.address,
            publicKey: account.publicKey,
            walletStateInit: await wallet?.makeStateInit() ?? '',
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
