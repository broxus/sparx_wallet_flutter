import 'package:app/app/router/router.dart';
import 'package:app/core/wm/custom_wm.dart';
import 'package:app/data/models/custom_currency.dart';
import 'package:app/feature/wallet/wallet_deploy/data/wallet_deploy_type.dart';
import 'package:app/feature/wallet/wallet_deploy/data/wallet_deployment_fees.dart';
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
class WalletDeployConfirmWidgetModel extends CustomWidgetModelParametrized<
    WalletDeployConfirmScreen,
    WalletDeployConfirmModel,
    WalletDeployConfirmRouteData> {
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

  late final ValueNotifier<String?> _errorMessageState =
      createValueNotifier(null);
  ValueNotifier<String?> get errorMessageState => _errorMessageState;

  late final StateNotifier<CustomCurrency> _currencyState =
      createNotifier<CustomCurrency>();
  StateNotifier<CustomCurrency> get currencyState => _currencyState;

  late final StateNotifier<TonWallet> _walletState = createNotifier();
  StateNotifier<TonWallet> get walletState => _walletState;

  // Store fees temporarily for UI state management
  WalletDeploymentFees? _deploymentFees;

  ColorsPaletteV2 get colors => _theme.colors;
  TextStylesV2 get textStyles => _theme.textStyles;
  ThemeStyleV2 get _theme => context.themeStyleV2;

  late final ValueListenable<WalletDeployType> deployTypeState =
      createWmParamsNotifier((params) => params.deployType);
  late final ValueListenable<List<PublicKey>?> custodiansState =
      createWmParamsNotifier((params) => params.custodians);
  late final ValueListenable<int?> requireConfirmationsState =
      createWmParamsNotifier((params) => params.requireConfirmations);
  late final ValueListenable<PublicKey> publicKeyState =
      createWmParamsNotifier((params) => params.publicKey);

  Address get _address => wmParams.value.address;
  int? get _hours => wmParams.value.hours;

  String get ticker => model.currentTransport.nativeTokenTicker;
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

      final currency = await model.getOrFetchNativeCurrency().then(
        (currency) {
          if (currency == null) throw Exception('Failed to load currency');
          return currency;
        },
      );

      _currencyState.accept(currency);

      // Load wallet info
      final wallet = await model.getWallet(_address);
      _walletState.accept(wallet.wallet);

      // Load account info
      final account = model.getAccountByAddress(_address);
      _accountState.accept(account);

      // Load fees and balance
      await _loadFees();
    } catch (e) {
      _errorMessageState.value = e.toString();
    } finally {
      _isLoadingState.value = false;
    }
  }

  Future<void> _loadFees() async {
    try {
      final fees = await model.loadFees(
        address: _address,
        deployType: deployTypeState.value,
        custodians: custodiansState.value,
        requireConfirmations: requireConfirmationsState.value,
        hours: _hours,
      );

      _deploymentFees = fees;

      _feeState.accept(fees.fee);
      _balanceState.accept(fees.balance);

      // Check if balance is sufficient
      if (!fees.hasSufficientBalance) {
        _errorMessageState.value = LocaleKeys.insufficientFunds.tr();
      }
    } on Exception catch (e, s) {
      _errorMessageState.value = e.toString();
      _logger.severe('Failed to load fees', e, s);
    }
  }

  bool get _canConfirmDeploy {
    return !_isLoadingState.value &&
        _feeState.value != null &&
        _balanceState.value != null &&
        (_deploymentFees?.hasSufficientBalance ?? false) &&
        _errorMessageState.value == null;
  }

  Future<void> onConfirmDeploy(SignInputAuth signInputAuth) async {
    if (!_canConfirmDeploy) return;

    try {
      // Temporarily store the signInputAuth (auto-expires for security)
      model.storeTemporaryAuth(signInputAuth);

      // Navigate to status screen with deployment data
      context.compassContinue(
        WalletDeployStatusRouteData(
          address: _address.address,
          publicKey: publicKeyState.value.publicKey,
          deployType: deployTypeState.value,
          custodians: custodiansState.value?.map((e) => e.publicKey).join(','),
          requireConfirmations: requireConfirmationsState.value,
          hours: _hours,
        ),
      );
    } catch (e) {
      _errorMessageState.value = e.toString();
    }
  }

  Future<void> onRetry() async {
    await _loadInitialData();
  }

  BigInt get availableBalanceAfterDeploy =>
      _deploymentFees?.availableBalanceAfterDeploy ?? BigInt.zero;

  SignInputAuthLedger? get ledgerAuthInput {
    final wallet = _walletState.value;
    return wallet != null ? model.getLedgerAuthInput(wallet) : null;
  }
}
