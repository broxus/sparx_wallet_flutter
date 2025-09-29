import 'dart:async';

import 'package:app/app/router/router.dart';
import 'package:app/core/wm/custom_wm.dart';
import 'package:app/data/models/custom_currency.dart';
import 'package:app/feature/messenger/data/message.dart' show Message;
import 'package:app/feature/wallet/route.dart';
import 'package:app/feature/wallet/wallet_deploy/wallet_deploy_model.dart';
import 'package:app/feature/wallet/wallet_deploy/wallet_deploy_screen.dart';
import 'package:app/feature/wallet/wallet_deploy/wallet_deploy_state.dart';
import 'package:app/generated/locale_keys.g.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:elementary_helper/elementary_helper.dart';
import 'package:injectable/injectable.dart';
import 'package:logging/logging.dart';
import 'package:nekoton_repository/nekoton_repository.dart'
    show
        Address,
        MultisigType,
        OperationCanceledException,
        PublicKey,
        SignInputAuth,
        Transaction,
        UnsignedMessage,
        WalletType;

class WalletDeployParams {
  const WalletDeployParams({
    required this.address,
    required this.publicKey,
  });

  final Address address;
  final PublicKey publicKey;
}

@injectable
class WalletDeployWidgetModel extends CustomWidgetModelParametrized<
    WalletDeployScreen, WalletDeployModel, WalletDeployParams> {
  WalletDeployWidgetModel(super.model);

  static final _logger = Logger('WalletDeployWidgetModel');

  // Single state notifier following the original BLoC pattern
  late final _walletDeployState = createNotifier<WalletDeployState>(
    const WalletDeployState.standard(),
  );

  // State getter
  StateNotifier<WalletDeployState> get walletDeployState => _walletDeployState;

  Address get addressState => wmParams.value.address;
  PublicKey get publicKeyState => wmParams.value.publicKey;

  /// Fee for transaction after calculating it
  BigInt? _fees;
  BigInt? _balance;
  String? _tonIconPath;
  String? _ticker;
  CustomCurrency? _tokenCustomCurrency;
  WalletType? _walletType;
  UnsignedMessage? _unsignedMessage;

  /// Last selected type of deploying.
  WalletDeployType _deployType = WalletDeployType.standard;

  /// Cached values for multisig
  List<PublicKey> _cachedCustodians = [];
  int _cachedRequireConfirmations = defaultRequireConfirmations;
  int _cachedHoursConfirmation = defaultHoursConfirmations;

  @override
  void initWidgetModel() {
    super.initWidgetModel();

    unawaited(
      Future(
        () async {
          _tonIconPath = model.currentTransport.nativeTokenIcon;
          _ticker = model.currentTransport.nativeTokenTicker;
          _tokenCustomCurrency = await model.getOrFetchNativeCurrency();
          _walletType = model.seedList
              .findAccountByAddress(addressState)
              ?.account
              .tonWallet
              .contract;
        },
      ),
    );
  }

  @override
  void dispose() {
    super.dispose();
    _unsignedMessage?.dispose();
  }

  Future<void> goPrevStep() async {
    // Reset fees when going back
    _fees = null;

    final currentState = _walletDeployState.value;

    // Navigate to appropriate step based on current type
    switch (currentState!) {
      case WalletDeployStateStandard():
      case WalletDeployStateMultisig():
        // Already on selection page, do nothing
        break;
      case WalletDeployStateCalculatingError():
      case WalletDeployStateReadyToDeploy():
      case WalletDeployStateDeployed():
        // Go back to selection based on cached deploy type
        if (_deployType == WalletDeployType.standard) {
          _walletDeployState.accept(const WalletDeployState.standard());
        } else {
          _walletDeployState.accept(
            WalletDeployState.multisig(
              _cachedCustodians,
              _cachedRequireConfirmations,
              _cachedHoursConfirmation,
              _walletType ??
                  const WalletType.multisig(MultisigType.multisig2_1),
            ),
          );
        }
      case WalletDeployStateDeploying():
      case WalletDeployStateSubscribeError():
        // Cannot go back during these states
        break;
    }
  }

  void changeDeployType(WalletDeployType type) {
    if (type == _deployType) return;

    _deployType = type;

    // Navigate to appropriate state
    switch (type) {
      case WalletDeployType.standard:
        _walletDeployState.accept(const WalletDeployState.standard());
      case WalletDeployType.multisig:
        _walletDeployState.accept(
          WalletDeployState.multisig(
            _cachedCustodians,
            _cachedRequireConfirmations,
            _cachedHoursConfirmation,
            _walletType ?? const WalletType.multisig(MultisigType.multisig2_1),
          ),
        );
    }
  }

  void updateMultisigData(
    List<PublicKey> custodians,
    int requireConfirmations,
    int? hours,
  ) {
    _cachedCustodians = custodians;
    _cachedRequireConfirmations = requireConfirmations;
    _cachedHoursConfirmation = hours ?? defaultHoursConfirmations;
  }

  Future<void> handlePrepareStandard() async {
    _cachedCustodians = [];
    _cachedRequireConfirmations = defaultRequireConfirmations;

    try {
      await _handlePrepareDeploy();
    } on Exception catch (e, t) {
      _logger.severe('_handlePrepareStandard', e, t);
      model.showMessage(Message.error(message: e.toString()));
    }
  }

  Future<void> handlePrepareMultisig(
    List<PublicKey> custodians,
    int requireConfirmations,
    int? hours,
  ) async {
    _cachedCustodians = custodians;
    _cachedRequireConfirmations = requireConfirmations;
    _cachedHoursConfirmation = hours ?? defaultHoursConfirmations;

    try {
      await _handlePrepareDeploy(custodians, requireConfirmations);
    } on Exception catch (e, t) {
      _logger.severe('_handlePrepareMultisig', e, t);
      model.showMessage(Message.error(message: e.toString()));
    }
  }

  // ignore: long-method
  Future<void> _handlePrepareDeploy([
    List<PublicKey>? custodians,
    int? requireConfirmations,
  ]) async {
    try {
      final account = model.seedList.findAccountByAddress(addressState);
      final walletState = await model.getWallet(addressState);
      final wallet = walletState.wallet;

      if (wallet == null) {
        _walletDeployState.accept(
          WalletDeployState.subscribeError(walletState.error!),
        );
        return;
      }

      _balance = wallet.contractState.balance;
      _unsignedMessage = await model.createUnsignedMessage(
        address: addressState,
        custodians: _cachedCustodians,
        reqConfirms: _cachedRequireConfirmations,
        walletType: wallet.walletType,
        hoursConfirmation: _cachedHoursConfirmation,
      );
      _fees = await model.estimateFees(_unsignedMessage!, addressState);

      final isPossibleToSendMessage = _balance! > _fees!;

      if (!isPossibleToSendMessage) {
        _walletDeployState.accept(
          WalletDeployState.calculatingError(
            error: LocaleKeys.insufficientFunds.tr(),
            fee: _fees,
            balance: _balance,
            requireConfirmations: requireConfirmations,
            custodians: custodians,
            tonIconPath: _tonIconPath,
            ticker: _ticker,
            currency: _tokenCustomCurrency,
          ),
        );

        return;
      }

      _walletDeployState.accept(
        WalletDeployState.readyToDeploy(
          fee: _fees!,
          balance: _balance!,
          requireConfirmations: requireConfirmations,
          custodians: custodians,
          tonIconPath: _tonIconPath,
          ticker: _ticker,
          currency: _tokenCustomCurrency,
          account: account,
          hours: _cachedHoursConfirmation,
          ledgerAuthInput: model.getLedgerAuthInput(wallet),
        ),
      );
    } on Exception catch (e, t) {
      _logger.severe('_handlePrepareDeploy', e, t);
      _walletDeployState.accept(
        WalletDeployState.calculatingError(
          error: e.toString(),
          fee: _fees,
          balance: _balance,
          requireConfirmations: requireConfirmations,
          custodians: custodians,
          tonIconPath: _tonIconPath,
          ticker: _ticker,
          currency: _tokenCustomCurrency,
        ),
      );
    }
  }

  Future<void> confirmDeploy(SignInputAuth signInputAuth) async {
    try {
      _walletDeployState
          .accept(const WalletDeployState.deploying(canClose: false));

      final transaction = await model.sendTransaction(
        _unsignedMessage!,
        _fees!,
        addressState,
        publicKeyState,
        signInputAuth,
      );

      _walletDeployState.accept(
        WalletDeployState.deployed(
          fee: _fees!,
          balance: _balance!,
          transaction: transaction,
          custodians: _deployType == WalletDeployType.multisig
              ? _cachedCustodians
              : null,
          requireConfirmations: _deployType == WalletDeployType.multisig
              ? _cachedRequireConfirmations
              : null,
          tonIconPath: _tonIconPath,
        ),
      );

      // Navigate to wallet page after successful deployment
      contextSafe?.compassPointNamed(const WalletRouteData());
    } on OperationCanceledException {
      // User cancelled, go back to ready state
      _goBackToReady();
    } on Exception {
      // Error handled in model, go back to ready state
      _goBackToReady();
    }
  }

  void allowCloseDeploy() {
    _walletDeployState
        .accept(const WalletDeployState.deploying(canClose: true));
  }

  void completeDeploy(Transaction transaction) {
    _walletDeployState.accept(
      WalletDeployState.deployed(
        fee: _fees!,
        balance: _balance!,
        transaction: transaction,
        custodians:
            _deployType == WalletDeployType.multisig ? _cachedCustodians : null,
        requireConfirmations: _deployType == WalletDeployType.multisig
            ? _cachedRequireConfirmations
            : null,
        tonIconPath: _tonIconPath,
      ),
    );
  }

  void _goBackToReady() {
    model.getWallet(addressState).then(
      (state) {
        final wallet = state.wallet;
        if (wallet != null) {
          _walletDeployState.accept(
            WalletDeployState.readyToDeploy(
              fee: _fees!,
              balance: _balance!,
              ledgerAuthInput: model.getLedgerAuthInput(wallet),
              custodians: _deployType == WalletDeployType.multisig
                  ? _cachedCustodians
                  : null,
              requireConfirmations: _deployType == WalletDeployType.multisig
                  ? _cachedRequireConfirmations
                  : null,
              tonIconPath: _tonIconPath,
              ticker: _ticker,
              currency: _tokenCustomCurrency,
              hours: _cachedHoursConfirmation,
            ),
          );
        }
      },
    );
  }
}
