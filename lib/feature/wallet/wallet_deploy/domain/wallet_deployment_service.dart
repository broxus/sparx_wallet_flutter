import 'package:app/app/service/service.dart';
import 'package:app/data/models/custom_currency.dart';
import 'package:app/feature/ledger/ledger.dart';
import 'package:app/feature/messenger/data/message.dart';
import 'package:app/feature/messenger/domain/service/messenger_service.dart';
import 'package:app/feature/wallet/wallet_deploy/data/wallet_deploy_type.dart';
import 'package:app/generated/generated.dart';
import 'package:app/utils/constants.dart';
import 'package:flutter_blue_plus/flutter_blue_plus.dart';
import 'package:injectable/injectable.dart';
import 'package:logging/logging.dart';
import 'package:nekoton_repository/nekoton_repository.dart' hide Message;

@singleton
class WalletDeploymentService {
  WalletDeploymentService(
    this._nekotonRepository,
    this._currenciesService,
    this._ledgerService,
    this._messengerService,
    this._permissionsService,
  );

  final _logger = Logger('WalletDeploymentService');
  final NekotonRepository _nekotonRepository;
  final CurrenciesService _currenciesService;
  final LedgerService _ledgerService;
  final MessengerService _messengerService;
  final AppPermissionsService _permissionsService;

  // Temporary sensitive data - automatically cleared after use
  SignInputAuth? _temporaryAuth;
  DateTime? _authStoredAt;

  TransportStrategy get currentTransport => _nekotonRepository.currentTransport;
  SeedList get seedList => _nekotonRepository.seedList;

  /// Temporarily stores SignInputAuth for deployment
  /// (auto-expires after 5 minutes)
  void storeTemporaryAuth(SignInputAuth auth) {
    _temporaryAuth = auth;
    _authStoredAt = DateTime.now();
  }

  /// Retrieves and immediately clears the temporary auth (one-time use)
  SignInputAuth? consumeTemporaryAuth() {
    final auth = _getValidTemporaryAuth();
    _clearTemporaryAuth();
    return auth;
  }

  Future<TonWalletState> getWallet(Address address) {
    return _nekotonRepository.getWallet(address);
  }

  /// Deploys a wallet with the provided deployment parameters
  Future<Transaction> deployWallet({
    required Address address,
    required PublicKey publicKey,
    required WalletDeployType deployType,
    required SignInputAuth signInputAuth,
    List<PublicKey>? custodians,
    int? requireConfirmations,
    int? hours,
  }) async {
    try {
      // Get wallet info
      final walletState = await _nekotonRepository.getWallet(address);
      final wallet = walletState.wallet;

      if (wallet == null) {
        throw Exception(
          walletState.error?.toString() ?? 'Wallet subscription error',
        );
      }

      // Create unsigned message based on deployment type
      final unsignedMessage = await _createUnsignedMessage(
        address: address,
        deployType: deployType,
        walletType: wallet.walletType,
        custodians: custodians,
        requireConfirmations: requireConfirmations,
        hours: hours,
      );

      // Check Bluetooth availability for Ledger
      if (signInputAuth.isLedger) {
        final isAvailable = await _checkBluetoothAvailability();
        if (!isAvailable) {
          throw Exception('Bluetooth not available');
        }
      }

      // Sign the transaction
      final transport = _nekotonRepository.currentTransport.transport;
      final signatureId = await transport.getSignatureId();
      final signature = await _ledgerService.runWithLedgerIfKeyIsLedger(
        interactionType: LedgerInteractionType.signTransaction,
        publicKey: publicKey,
        action: () async {
          await unsignedMessage.refreshTimeout();
          return _nekotonRepository.seedList.sign(
            message: unsignedMessage.message,
            publicKey: publicKey,
            signInputAuth: signInputAuth,
            signatureId: signatureId,
          );
        },
      );

      final signedMessage = await unsignedMessage.sign(signature: signature);

      // Estimate and send transaction
      final fee = await _estimateDeploymentFees(
        address: address,
        message: unsignedMessage,
      );

      final transaction = await _nekotonRepository.send(
        address: address,
        signedMessage: signedMessage,
        amount: fee,
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
      _logger.severe('deployWallet', e, t);
      _messengerService.show(
        Message.error(message: e.toString()),
      );
      rethrow;
    }
  }

  void clearDeploymentData() {
    _clearTemporaryAuth(); // Clear sensitive data
  }

  Future<CustomCurrency?> getOrFetchNativeCurrency() {
    return _currenciesService.getOrFetchNativeCurrency(currentTransport);
  }

  /// Calculates deployment fees for the given deployment parameters
  Future<BigInt> calculateDeploymentFees({
    required Address address,
    required WalletDeployType deployType,
    List<PublicKey>? custodians,
    int? requireConfirmations,
    int? hours,
  }) async {
    try {
      // Get wallet info to determine wallet type
      final walletState = await _nekotonRepository.getWallet(address);
      final wallet = walletState.wallet;

      if (wallet == null) {
        throw Exception(
          walletState.error?.toString() ?? 'Wallet subscription error',
        );
      }

      // Create unsigned message to estimate fees
      final unsignedMessage = await _createUnsignedMessage(
        address: address,
        deployType: deployType,
        walletType: wallet.walletType,
        custodians: custodians,
        requireConfirmations: requireConfirmations,
        hours: hours,
      );

      // Estimate fees
      return await _estimateDeploymentFees(
        address: address,
        message: unsignedMessage,
      );
    } catch (e, t) {
      _logger.severe('calculateDeploymentFees', e, t);
      rethrow;
    }
  }

  /// Gets the wallet balance for the given address
  Future<BigInt> getWalletBalance(Address address) async {
    final walletState = await _nekotonRepository.getWallet(address);
    final wallet = walletState.wallet;

    if (wallet == null) {
      throw Exception(
        walletState.error?.toString() ?? 'Wallet subscription error',
      );
    }

    return wallet.contractState.balance;
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

  // Private methods

  /// Gets the temporary auth if still valid (within 5 minutes)
  SignInputAuth? _getValidTemporaryAuth() {
    if (_temporaryAuth == null || _authStoredAt == null) {
      return null;
    }

    final now = DateTime.now();
    const maxAge = Duration(minutes: 5);

    if (now.difference(_authStoredAt!) > maxAge) {
      _clearTemporaryAuth();
      return null;
    }

    return _temporaryAuth;
  }

  /// Clears temporary authentication data
  void _clearTemporaryAuth() {
    _temporaryAuth = null;
    _authStoredAt = null;
  }

  Future<UnsignedMessage> _createUnsignedMessage({
    required Address address,
    required WalletDeployType deployType,
    required WalletType walletType,
    List<PublicKey>? custodians,
    int? requireConfirmations,
    int? hours,
  }) async {
    if (deployType == WalletDeployType.standard) {
      return _nekotonRepository.prepareDeploy(address, defaultSendTimeout);
    }

    if (custodians == null || requireConfirmations == null || hours == null) {
      throw Exception(
        'Multisig configuration required for multisig deployment',
      );
    }

    return _nekotonRepository.prepareDeployWithMultipleOwners(
      address: address,
      custodians: custodians,
      reqConfirms: requireConfirmations,
      expiration: defaultSendTimeout,
      expirationTime:
          walletType == const WalletType.multisig(MultisigType.multisig2_1)
              ? hours * 3600
              : null,
    );
  }

  Future<BigInt> _estimateDeploymentFees({
    required Address address,
    required UnsignedMessage message,
  }) async {
    try {
      return await _nekotonRepository.estimateDeploymentFees(
        address: address,
        message: message,
      );
    } on Exception catch (e, t) {
      _logger.severe('_estimateDeploymentFees', e, t);
      return BigInt.zero;
    }
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

  /// Gets the account by address
  KeyAccount? getAccountByAddress(Address address) {
    return _nekotonRepository.seedList.findAccountByAddress(address);
  }
}
