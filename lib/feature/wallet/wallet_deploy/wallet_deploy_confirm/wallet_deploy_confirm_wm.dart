import 'package:app/app/router/router.dart';
import 'package:app/core/wm/custom_wm.dart';
import 'package:app/data/models/custom_currency.dart';
import 'package:app/feature/ledger/ledger.dart';
import 'package:app/feature/wallet/wallet_deploy/data/wallet_deploy_type.dart';
import 'package:app/feature/wallet/wallet_deploy/wallet_deploy_confirm/route.dart';
import 'package:app/feature/wallet/wallet_deploy/wallet_deploy_confirm/wallet_deploy_confirm_model.dart';
import 'package:app/feature/wallet/wallet_deploy/wallet_deploy_confirm/wallet_deploy_confirm_screen.dart';
import 'package:app/feature/wallet/wallet_deploy/wallet_deploy_status/route.dart';
import 'package:app/generated/generated.dart';
import 'package:elementary_helper/elementary_helper.dart';
import 'package:flutter/foundation.dart';
import 'package:injectable/injectable.dart';
import 'package:logging/logging.dart';
import 'package:nekoton_repository/nekoton_repository.dart';
import 'package:ui_components_lib/v2/ui_components_lib_v2.dart';

@injectable
class WalletDeployConfirmWidgetModel
    extends
        CustomWidgetModelParametrized<
          WalletDeployConfirmScreen,
          WalletDeployConfirmModel,
          WalletDeployConfirmRouteData
        >
    with BleAvailabilityWmMixin {
  WalletDeployConfirmWidgetModel(super.model);

  final _logger = Logger('WalletDeployConfirmWidgetModel');

  late final StateNotifier<BigInt> _feeState = createNotifier<BigInt>();
  StateNotifier<BigInt> get feeState => _feeState;

  late final StateNotifier<BigInt> _balanceState = createNotifier<BigInt>();
  StateNotifier<BigInt> get balanceState => _balanceState;

  late final StateNotifier<KeyAccount> _accountState =
      createNotifier<KeyAccount>();
  StateNotifier<KeyAccount> get accountState => _accountState;

  late final ValueNotifier<bool> _isLoadingState = createValueNotifier(true);
  ValueListenable<bool> get isLoadingState => _isLoadingState;

  late final ValueNotifier<String?> _errorMessageState = createValueNotifier(
    null,
  );
  ValueNotifier<String?> get errorMessageState => _errorMessageState;

  late final ValueNotifier<bool> _hasSufficientBalanceState =
      createValueNotifier(false);
  ValueNotifier<bool> get hasSufficientBalanceState =>
      _hasSufficientBalanceState;

  late final StateNotifier<CustomCurrency> _currencyState =
      createNotifier<CustomCurrency>();
  StateNotifier<CustomCurrency> get currencyState => _currencyState;

  late final StateNotifier<TonWallet> _walletState = createNotifier();
  StateNotifier<TonWallet> get walletState => _walletState;

  UnsignedMessage? _unsignedMessage;

  ColorsPaletteV2 get colors => _theme.colors;
  TextStylesV2 get textStyles => _theme.textStyles;
  ThemeStyleV2 get _theme => context.themeStyleV2;

  late final ValueListenable<WalletDeployType> deployTypeState =
      createWmParamsNotifier((params) => params.deployType);
  late final ValueListenable<List<PublicKey>?> custodiansState =
      createWmParamsNotifier((params) => params.custodians);
  late final ValueListenable<int?> requireConfirmationsState =
      createWmParamsNotifier((params) => params.requireConfirmations);
  late final ValueListenable<PublicKey> publicKeyState = createWmParamsNotifier(
    (params) => params.publicKey,
  );

  Address get _address => wmParams.value.address;
  Address get address => _address;
  int? get _hours => wmParams.value.hours;

  String get ticker => model.currentTransport.nativeTokenTicker;
  int get decimal => model.currentTransport.defaultNativeCurrencyDecimal;
  String? get tonIconPath => model.currentTransport.nativeTokenIcon;

  @override
  void initWidgetModel() {
    super.initWidgetModel();
    _loadInitialData();
  }

  Future<void> onBack() async {
    contextSafe?.compassBack();
  }

  Future<void> _loadInitialData() async {
    try {
      _isLoadingState.value = true;
      _errorMessageState.value = null;

      final currency = await model.getOrFetchNativeCurrency();

      _currencyState.accept(currency);

      // Load wallet info
      final walletState = await model.getWallet(_address);
      final wallet = walletState.wallet;
      if (wallet == null) {
        throw Exception(
          walletState.error?.toString() ?? 'Wallet subscription error',
        );
      }

      _walletState.accept(wallet);

      // Load account info
      final account = model.getAccountByAddress(_address);
      _accountState.accept(account);

      final unsignedMessage = await model.createUnsignedMessage(
        deployType: deployTypeState.value,
        address: _address,
        custodians: custodiansState.value,
        reqConfirms: requireConfirmationsState.value,
        walletType: wallet.walletType,
        hours: _hours,
      );
      final fees = await model.estimateFees(
        address: _address,
        message: unsignedMessage,
      );

      _unsignedMessage = unsignedMessage;
      _feeState.accept(fees);
      _balanceState.accept(wallet.contractState.balance);

      _hasSufficientBalanceState.value = wallet.contractState.balance > fees;

      // Check if balance is sufficient
      if (!_hasSufficientBalanceState.value) {
        _errorMessageState.value = LocaleKeys.deployWalletModalSubtitle.tr(
          args: [(fees / BigInt.from(10 * decimal)).toString(), ticker],
        );
      }
    } catch (e, s) {
      _errorMessageState.value = e.toString();
      _logger.severe('_loadInitialData', e, s);
    } finally {
      _isLoadingState.value = false;
    }
  }

  bool get _canConfirmDeploy {
    return !_isLoadingState.value &&
        _unsignedMessage != null &&
        _feeState.value != null &&
        _balanceState.value != null &&
        _hasSufficientBalanceState.value &&
        _errorMessageState.value == null;
  }

  Future<void> onConfirmDeploy(SignInputAuth signInputAuth) async {
    if (!_canConfirmDeploy) return;

    if (signInputAuth.isLedger) {
      final isAvailable = await checkBluetoothAvailability();
      if (!isAvailable) return;
    }

    try {
      _isLoadingState.value = true;

      await _unsignedMessage?.refreshTimeout();

      final message = await model.signMessage(
        publicKey: publicKeyState.value,
        unsigned: _unsignedMessage!,
        signInputAuth: signInputAuth,
      );

      model.storeSignedMessage(message);

      contextSafe?.compassContinue(
        WalletDeployStatusRouteData(
          messageHash: message.hash,
          address: _address,
          amount: _feeState.value!,
        ),
      );
    } catch (e) {
      _errorMessageState.value = e.toString();
    } finally {
      _isLoadingState.value = false;
    }
  }

  Future<void> onRetry() async {
    await _loadInitialData();
  }

  SignInputAuthLedger getLedgerAuthInput() {
    final wallet = _walletState.value;

    if (wallet == null) {
      throw StateError('Wallet is not initialized');
    }

    return model.getLedgerAuthInput(wallet);
  }
}
