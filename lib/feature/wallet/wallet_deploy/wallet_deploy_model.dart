import 'package:app/app/service/service.dart';
import 'package:app/data/models/custom_currency.dart';
import 'package:app/feature/ledger/ledger.dart';
import 'package:app/utils/constants.dart';
import 'package:elementary/elementary.dart';
import 'package:injectable/injectable.dart';
import 'package:nekoton_repository/nekoton_repository.dart' hide Message;

enum WalletDeployType { standard, multisig }

const defaultRequireConfirmations = 3;
const defaultHoursConfirmations = 24;

@injectable
class WalletDeployModel extends ElementaryModel with BleAvailabilityModelMixin {
  WalletDeployModel(
    ErrorHandler errorHandler,
    this._nekotonRepository,
    this._currenciesService,
    this._ledgerService,
    this._delegate,
  ) : super(errorHandler: errorHandler);

  final NekotonRepository _nekotonRepository;
  final CurrenciesService _currenciesService;
  final LedgerService _ledgerService;
  final BleAvailabilityModelDelegate _delegate;

  @override
  BleAvailabilityModelDelegate get delegate => _delegate;

  TransportStrategy get currentTransport => _nekotonRepository.currentTransport;

  SeedList get seedList => _nekotonRepository.seedList;

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

  Future<Future<Transaction>> sendTransaction({
    required Address address,
    required PublicKey publicKey,
    required UnsignedMessage unsigned,
    required BigInt fees,
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

    final signedMessage = await unsigned.sign(signature: signature);

    return _nekotonRepository.send(
      address: address,
      signedMessage: signedMessage,
      amount: fees,
      destination: address,
    );
  }

  Future<UnsignedMessage> createUnsignedMessage({
    required Address address,
    required List<PublicKey> custodians,
    required int reqConfirms,
    required WalletType walletType,
    required int hoursConfirmation,
  }) async {
    return custodians.isEmpty
        ? _nekotonRepository.prepareDeploy(address, defaultSendTimeout)
        : _nekotonRepository.prepareDeployWithMultipleOwners(
            address: address,
            custodians: custodians,
            reqConfirms: reqConfirms,
            expiration: defaultSendTimeout,
            expirationTime: walletType ==
                    const WalletType.multisig(MultisigType.multisig2_1)
                ? hoursConfirmation * 3600
                : null,
          );
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
}
