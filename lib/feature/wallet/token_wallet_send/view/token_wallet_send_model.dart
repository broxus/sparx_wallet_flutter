import 'package:app/data/models/models.dart';
import 'package:app/feature/ledger/ledger.dart';
import 'package:app/feature/wallet/wallet.dart';
import 'package:elementary/elementary.dart';
import 'package:injectable/injectable.dart';
import 'package:nekoton_repository/nekoton_repository.dart' hide Message;
import 'package:rxdart/rxdart.dart';

@injectable
class TokenWalletSendModel extends ElementaryModel
    with BleAvailabilityModelMixin {
  TokenWalletSendModel(
    ErrorHandler errorHandler,
    this._nekotonRepository,
    this._ledgerService,
    this._bleDelegate,
    this._tokenTransferDelegateProvider,
  ) : super(errorHandler: errorHandler);

  final NekotonRepository _nekotonRepository;
  final LedgerService _ledgerService;
  final BleAvailabilityModelDelegate _bleDelegate;
  final TokenTransferDelegateProvider _tokenTransferDelegateProvider;

  TokenTransferDelegate? _tokenTransferDelegate;

  @override
  BleAvailabilityModelDelegate get delegate => _bleDelegate;

  TransportStrategy get transport => _nekotonRepository.currentTransport;

  Currency get currency => Currencies()[transport.nativeTokenTicker]!;

  Future<void> initTransfer({
    required Address owner,
    required Address rootTokenContract,
  }) async {
    final keyAccount = getAccount(owner);
    if (keyAccount == null) return;

    _tokenTransferDelegate = await _tokenTransferDelegateProvider.provide(
      keyAccount: keyAccount,
      rootTokenContract: rootTokenContract,
    );
  }

  KeyAccount? getAccount(Address address) =>
      _nekotonRepository.seedList.findAccountByAddress(address);

  Future<TonWalletState> getWalletState(Address address) =>
      _nekotonRepository.walletsMapStream
          .mapNotNull((wallets) => wallets[address])
          .first;

  Future<TokenWalletState> getTokenWalletState({
    required Address owner,
    required Address rootTokenContract,
  }) =>
      _nekotonRepository.tokenWalletsStream.expand((e) => e).firstWhere(
            (wallet) =>
                wallet.owner == owner &&
                wallet.rootTokenContract == rootTokenContract,
          );

  Future<PreparedTokenTransfer> prepareTransfer({
    required Address owner,
    required Address rootTokenContract,
    required PublicKey publicKey,
    required Address destination,
    required BigInt amount,
    BigInt? attachedAmount,
    String? comment,
    bool? notifyReceiver,
  }) async {
    if (_tokenTransferDelegate == null) {
      throw StateError('TokenTransferDelegate is not initialized');
    }

    return _tokenTransferDelegate!.prepareTransfer(
      owner: owner,
      rootTokenContract: rootTokenContract,
      publicKey: publicKey,
      destination: destination,
      amount: amount,
      attachedAmount: attachedAmount,
      comment: comment,
      notifyReceiver: notifyReceiver,
    );
  }

  Future<TokenTransactionCompleter> sendMessage({
    required PreparedTokenTransfer transfer,
    required PublicKey publicKey,
    required SignInputAuth signInputAuth,
  }) async {
    if (_tokenTransferDelegate == null) {
      throw StateError('TokenTransferDelegate is not initialized');
    }

    final completer = await _tokenTransferDelegate!.sendMessage(
      transfer: transfer,
      signer: _Signer(
        ledgerService: _ledgerService,
        nekotonRepository: _nekotonRepository,
        publicKey: publicKey,
        signInputAuth: signInputAuth,
      ),
    );

    return completer;
  }

  Future<Fee> estimateFees(PreparedTokenTransfer transfer) {
    if (_tokenTransferDelegate == null) {
      throw StateError('TokenTransferDelegate is not initialized');
    }

    return _tokenTransferDelegate!.estimateFees(transfer);
  }

  Future<List<TxTreeSimulationErrorItem>> simulateTransactionTree(
    PreparedTokenTransfer transfer,
  ) {
    if (_tokenTransferDelegate == null) {
      throw StateError('TokenTransferDelegate is not initialized');
    }

    return _tokenTransferDelegate!.simulateTransactionTree(transfer);
  }

  SignInputAuthLedger getLedgerAuthInput({
    required TonWallet wallet,
    required GenericTokenWallet tokenWallet,
    required PublicKey custodian,
  }) {
    return SignInputAuthLedger(
      wallet: wallet.walletType,
      context: _ledgerService.prepareSignatureContext(
        PrepareSignatureContext.transfer(
          wallet: wallet,
          asset: tokenWallet.currency.symbol,
          decimals: tokenWallet.currency.decimalDigits,
          custodian: custodian,
        ),
      ),
    );
  }
}

class _Signer extends TokenTransferSigner {
  _Signer({
    required this.ledgerService,
    required this.nekotonRepository,
    required this.publicKey,
    required this.signInputAuth,
  });

  final LedgerService ledgerService;
  final NekotonRepository nekotonRepository;
  final PublicKey publicKey;
  final SignInputAuth signInputAuth;

  Transport get transport => nekotonRepository.currentTransport.transport;

  @override
  Future<SignedMessage> signMessage(UnsignedMessage unsignedMessage) async {
    final signatureId = await transport.getSignatureId();
    final signature = await ledgerService.runWithLedgerIfKeyIsLedger(
      interactionType: LedgerInteractionType.signTransaction,
      publicKey: publicKey,
      action: () async {
        await unsignedMessage.refreshTimeout();
        return nekotonRepository.seedList.sign(
          message: unsignedMessage.message,
          publicKey: publicKey,
          signInputAuth: signInputAuth,
          signatureId: signatureId,
        );
      },
    );

    return unsignedMessage.sign(signature: signature);
  }

  @override
  Future<String> signDataRaw(String data) async {
    final signatureId = await transport.getSignatureId();
    final output = await nekotonRepository.seedList.signDataRaw(
      data: data,
      publicKey: publicKey,
      signInputAuth: signInputAuth,
      signatureId: signatureId,
    );

    return output.signature;
  }
}
