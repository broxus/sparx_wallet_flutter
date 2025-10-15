import 'package:app/app/service/service.dart';
import 'package:app/data/models/custom_currency.dart';
import 'package:app/feature/ledger/ledger.dart';
import 'package:app/feature/wallet/wallet_deploy/data/wallet_deploy_type.dart';
import 'package:app/feature/wallet/wallet_deploy/domain/wallet_deployment_service.dart';
import 'package:app/utils/utils.dart';
import 'package:elementary/elementary.dart';
import 'package:injectable/injectable.dart';
import 'package:nekoton_repository/nekoton_repository.dart';

@injectable
class WalletDeployConfirmModel extends ElementaryModel
    with BleAvailabilityModelMixin {
  WalletDeployConfirmModel(
    ErrorHandler errorHandler,
    this._walletDeploymentService,
    this._nekotonRepository,
    this._currenciesService,
    this._ledgerService,
    this._delegate,
  ) : super(errorHandler: errorHandler);

  final WalletDeploymentService _walletDeploymentService;
  final NekotonRepository _nekotonRepository;
  final CurrenciesService _currenciesService;
  final LedgerService _ledgerService;
  final BleAvailabilityModelDelegate _delegate;

  @override
  BleAvailabilityModelDelegate get delegate => _delegate;

  TransportStrategy get currentTransport => _nekotonRepository.currentTransport;

  @override
  void dispose() {
    _ledgerService.closeLedgerConnection();
    super.dispose();
  }

  Future<CustomCurrency?> getOrFetchNativeCurrency() {
    return _currenciesService.getOrFetchNativeCurrency(currentTransport);
  }

  Future<TonWalletState> getWallet(Address address) {
    return _nekotonRepository.getWallet(address);
  }

  KeyAccount? getAccountByAddress(Address address) {
    return _nekotonRepository.seedList.findAccountByAddress(address);
  }

  Future<BigInt> estimateFees({
    required Address address,
    required UnsignedMessage message,
  }) =>
      _nekotonRepository.estimateDeploymentFees(
        address: address,
        message: message,
      );

  SignInputAuthLedger getLedgerAuthInput(TonWallet wallet) {
    final transport = _nekotonRepository.currentTransport;

    return SignInputAuthLedger(
      wallet: wallet.walletType,
      context: _ledgerService.prepareSignatureContext(
        PrepareSignatureContext.deploy(
          wallet: wallet,
          asset: transport.nativeTokenTicker,
          decimals: transport.defaultNativeCurrencyDecimal,
        ),
      ),
    );
  }

  Future<UnsignedMessage> createUnsignedMessage({
    required WalletDeployType deployType,
    required Address address,
    required WalletType walletType,
    List<PublicKey>? custodians,
    int? reqConfirms,
    int? hours,
  }) async {
    return switch (deployType) {
      WalletDeployType.standard =>
        _nekotonRepository.prepareDeploy(address, defaultSendTimeout),
      WalletDeployType.multisig
          when custodians != null && reqConfirms != null && hours != null =>
        _nekotonRepository.prepareDeployWithMultipleOwners(
          address: address,
          custodians: custodians,
          reqConfirms: reqConfirms,
          expiration: defaultSendTimeout,
          expirationTime:
              walletType == const WalletType.multisig(MultisigType.multisig2_1)
                  ? hours * 3600
                  : null,
        ),
      _ => throw Exception(
          'Multisig configuration required for multisig deployment',
        ),
    };
  }

  Future<SignedMessage> signMessage({
    required PublicKey publicKey,
    required UnsignedMessage unsigned,
    required SignInputAuth signInputAuth,
  }) async {
    final transport = _nekotonRepository.currentTransport.transport;
    final signatureId = await transport.getSignatureId();
    final signature = await _ledgerService.runWithLedgerIfKeyIsLedger(
      interactionType: LedgerInteractionType.signTransaction,
      publicKey: publicKey,
      action: () async {
        await unsigned.refreshTimeout();
        return _nekotonRepository.seedList.sign(
          message: unsigned.message,
          publicKey: publicKey,
          signInputAuth: signInputAuth,
          signatureId: signatureId,
        );
      },
    );

    return unsigned.sign(signature: signature);
  }

  void storeSignedMessage(SignedMessage message) =>
      _walletDeploymentService.storeSignedMessage(message);
}
