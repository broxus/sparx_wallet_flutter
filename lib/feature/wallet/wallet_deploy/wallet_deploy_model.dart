import 'package:app/app/service/service.dart';
import 'package:app/data/models/custom_currency.dart';
import 'package:app/feature/ledger/ledger.dart';
import 'package:app/feature/messenger/data/message.dart';
import 'package:app/feature/messenger/domain/service/messenger_service.dart';
import 'package:app/generated/generated.dart';
import 'package:app/utils/constants.dart';
import 'package:elementary/elementary.dart';
import 'package:flutter_blue_plus/flutter_blue_plus.dart';
import 'package:injectable/injectable.dart';
import 'package:logging/logging.dart';
import 'package:nekoton_repository/nekoton_repository.dart' hide Message;

enum WalletDeployType { standard, multisig }

const defaultRequireConfirmations = 3;
const defaultHoursConfirmations = 24;

@injectable
class WalletDeployModel extends ElementaryModel {
  WalletDeployModel(
    ErrorHandler errorHandler,
    this._nekotonRepository,
    this._currenciesService,
    this._ledgerService,
    this._messengerService,
    this._permissionsService,
  ) : super(errorHandler: errorHandler);

  final _logger = Logger('WalletDeployModel');
  final NekotonRepository _nekotonRepository;
  final CurrenciesService _currenciesService;
  final LedgerService _ledgerService;
  final MessengerService _messengerService;
  final AppPermissionsService _permissionsService;

  TransportStrategy get currentTransport => _nekotonRepository.currentTransport;
  SeedList get seedList => _nekotonRepository.seedList;

  Future<CustomCurrency?> getOrFetchNativeCurrency() {
    return _currenciesService.getOrFetchNativeCurrency(currentTransport);
  }

  Future<TonWalletState> getWallet(Address address) {
    return _nekotonRepository.getWallet(address);
  }

  Future<Transaction> sendTransaction(
    UnsignedMessage unsigned,
    BigInt fees,
    Address address,
    PublicKey publicKey,
    SignInputAuth signInputAuth,
  ) async {
    final walletState = await _nekotonRepository.getWallet(address);
    final wallet = walletState.wallet;

    if (wallet == null) {
      throw Exception(
        walletState.error?.toString() ?? 'Wallet subscription error',
      );
    }

    try {
      if (signInputAuth.isLedger) {
        final isAvailable = await _checkBluetoothAvailability();
        if (!isAvailable) {
          throw Exception('Bluetooth not available');
        }
      }

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

      final transaction = await _nekotonRepository.send(
        address: address,
        signedMessage: signedMessage,
        amount: fees,
        destination: address,
      );

      _messengerService.show(
        Message.successful(
          message: LocaleKeys.walletDeployedSuccessfully.tr(),
        ),
      );

      return transaction;
    } on OperationCanceledException catch (_) {
      rethrow;
    } on Exception catch (e, t) {
      if (e is AnyhowException && e.isCancelled) rethrow;
      _logger.severe('sendTransaction', e, t);
      _messengerService.show(
        Message.error(message: e.toString()),
      );
      rethrow;
    }
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

  Future<BigInt> estimateFees(UnsignedMessage message, Address address) async {
    try {
      return await _nekotonRepository.estimateDeploymentFees(
        address: address,
        message: message,
      );
    } on Exception catch (e, t) {
      _logger.severe('estimateFees', e, t);
      return BigInt.zero;
    }
  }

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

  Future<bool> _checkBluetoothAvailability() async {
    final hasPermissions = await _checkBluetoothPermissions();
    if (!hasPermissions) return false;

    final isBluetoothEnabled = await _checkBluetoothAdapter();
    if (!isBluetoothEnabled) return false;

    return true;
  }

  Future<bool> _checkBluetoothPermissions() async {
    final hasPermissions = await _ledgerService.checkPermissions();
    if (!hasPermissions) {
      _messengerService.show(
        Message.error(
          message: LocaleKeys.ledgerPermissionsError.tr(),
          actionText: LocaleKeys.giveWord.tr(),
          onAction: _permissionsService.openSettings,
        ),
      );
      return false;
    }

    return true;
  }

  Future<bool> _checkBluetoothAdapter() async {
    final state = await _ledgerService.adapterState.firstWhere(
      (e) => e != BluetoothAdapterState.unknown,
    );
    if (state != BluetoothAdapterState.on &&
        state != BluetoothAdapterState.turningOn) {
      _messengerService.show(
        Message.error(
          message: LocaleKeys.bluetoothIsOff.tr(),
        ),
      );
      return false;
    }

    return true;
  }

  void showMessage(Message message) {
    return _messengerService.show(message);
  }
}
