import 'dart:convert';
import 'dart:typed_data';

import 'package:app/app/service/service.dart';
import 'package:app/feature/messenger/messenger.dart';
import 'package:app/feature/ton_connect/ton_connect.dart';
import 'package:app/utils/utils.dart';
import 'package:collection/collection.dart';
import 'package:convert/convert.dart';
import 'package:crypto/crypto.dart';
import 'package:elementary/elementary.dart';
import 'package:injectable/injectable.dart';
import 'package:money2/money2.dart';
import 'package:nekoton_repository/nekoton_repository.dart' hide Message;

@injectable
class TCConnectModel extends ElementaryModel {
  TCConnectModel(
    ErrorHandler errorHandler,
    this._nekotonRepository,
    this._currentAccountsService,
    this._ntpService,
    this._messengerService,
  ) : super(errorHandler: errorHandler);

  final NekotonRepository _nekotonRepository;
  final CurrentAccountsService _currentAccountsService;
  final NtpService _ntpService;
  final MessengerService _messengerService;

  String get symbol => currentTransport.nativeTokenTicker;

  KeyAccount? get currentAccount =>
      _currentAccountsService.currentActiveAccount;

  List<KeyAccount> get accounts => _nekotonRepository.seedList.seeds
      .expand(
        (seed) => seed.allKeys.expand((key) => key.accountList.allAccounts),
      )
      .where((account) => !account.isHidden)
      .toList();

  TransportStrategy get currentTransport => _nekotonRepository.currentTransport;

  TonNetwork get _currentTonNetwork =>
      TonNetwork.values.firstWhereOrNull(
        (e) => e.toInt() == currentTransport.transport.networkId,
      ) ??
      TonNetwork.mainnet;

  Future<Money?> getBalance(KeyAccount account) async {
    final wallet = await _getWallet(account);
    if (wallet == null) return null;

    return Money.fromBigIntWithCurrency(
      wallet.contractState.balance,
      Currencies()[currentTransport.nativeTokenTicker]!,
    );
  }

  Future<List<ConnectItemReply>> createReplyItems({
    required SignInputAuth signInputAuth,
    required ConnectRequest request,
    required KeyAccount account,
    required DappManifest manifest,
  }) async {
    final replyItems = <ConnectItemReply>[];
    final wallet = await _getWallet(account);

    for (final item in request.items) {
      final replyItem = switch (item) {
        TonAddressItem() => ConnectItemReply.tonAddress(
          network: _currentTonNetwork,
          address: account.address,
          publicKey: account.publicKey,
          walletStateInit: await wallet?.makeStateInit() ?? '',
        ),
        TonProofItem(:final payload) => ConnectItemReply.tonProofSuccess(
          proof: await _createProof(
            signInputAuth: signInputAuth,
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

  Future<SignInputAuthLedger> getLedgerAuthInput(KeyAccount account) async {
    final wallet = await _getWallet(account);
    if (wallet == null) {
      throw StateError('Wallet not found for ledger auth input');
    }

    return SignInputAuthLedger(wallet: wallet.walletType);
  }

  void showMessage(Message message) => _messengerService.show(message);

  Future<TonWallet?> _getWallet(KeyAccount keyAccount) async =>
      _nekotonRepository.walletsMap[keyAccount.address]?.wallet ??
      (await _nekotonRepository.subscribe(keyAccount.account.tonWallet)).wallet;

  Future<TonProof> _createProof({
    required SignInputAuth signInputAuth,
    required String payload,
    required KeyAccount account,
    required DappManifest manifest,
  }) async {
    final timestamp = _ntpService.now().secondsSinceEpoch;
    final timestampBytes = ByteData(8)..setInt64(0, timestamp, Endian.little);

    final domain = manifest.url.host;
    final domainBytes = utf8.encode(domain);
    final domainLength = ByteData(4)
      ..setInt32(0, domainBytes.length, Endian.little);

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

    final signedData = await _nekotonRepository.seedList.signData(
      data: base64Encode(bufferToSign),
      publicKey: account.publicKey,
      signInputAuth: signInputAuth,
      signatureContext: const SignatureContext(
        signatureType: SignatureType.empty,
      ),
    );

    return TonProof(
      payload: payload,
      timestamp: timestamp,
      signature: signedData.signature,
      domain: TonProofDomain(
        lengthBytes: domainBytes.lengthInBytes,
        value: domain,
      ),
    );
  }
}
