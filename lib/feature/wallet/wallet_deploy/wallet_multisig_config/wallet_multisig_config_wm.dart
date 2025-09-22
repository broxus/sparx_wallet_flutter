import 'package:app/app/router/router.dart';
import 'package:app/core/wm/custom_wm.dart';
import 'package:app/feature/wallet/wallet_deploy/constants.dart';
import 'package:app/feature/wallet/wallet_deploy/data/wallet_deploy_type.dart';
import 'package:app/feature/wallet/wallet_deploy/wallet_deploy_confirm/route.dart';
import 'package:app/feature/wallet/wallet_deploy/wallet_multisig_config/wallet_multisig_config_model.dart';
import 'package:app/feature/wallet/wallet_deploy/wallet_multisig_config/wallet_multisig_config_screen.dart';
import 'package:app/generated/generated.dart';
import 'package:flutter/foundation.dart';
import 'package:injectable/injectable.dart';
import 'package:nekoton_repository/nekoton_repository.dart';
import 'package:ui_components_lib/v2/ui_components_lib_v2.dart';

@injectable
class WalletMultisigConfigWidgetModel extends CustomWidgetModelParametrized<
    WalletMultisigConfigScreen,
    WalletMultisigConfigModel,
    WalletMultisigConfigWmParams> {
  WalletMultisigConfigWidgetModel(super.model);

  late final ValueNotifier<List<PublicKey>> _custodiansState =
      createValueNotifier(
    wmParams.value.initialCustodians ?? [],
  );
  ValueListenable<List<PublicKey>> get custodiansState => _custodiansState;

  late final ValueNotifier<int> _requireConfirmationsState =
      createValueNotifier(
    _calculateInitialRequireConfirmations(),
  );
  ValueListenable<int> get requireConfirmationsState =>
      _requireConfirmationsState;

  late final ValueNotifier<int> _hoursState = createValueNotifier(
    wmParams.value.initialHours ?? defaultHoursConfirmations,
  );
  ValueListenable<int> get hoursState => _hoursState;

  late final ValueNotifier<bool> _isValidState = createValueNotifier(false);
  ValueListenable<bool> get isValidState => _isValidState;

  late final ValueNotifier<String?> _errorMessageState =
      createValueNotifier(null);
  ValueListenable<String?> get errorMessageState => _errorMessageState;

  ColorsPaletteV2 get colors => _theme.colors;
  TextStylesV2 get textStyles => _theme.textStyles;
  ThemeStyleV2 get _theme => context.themeStyleV2;

  Address get _address => wmParams.value.address;
  PublicKey get _publicKey => wmParams.value.publicKey;
  List<PublicKey> get custodians => _custodiansState.value;
  int get requireConfirmations => _requireConfirmationsState.value;
  int get hours => _hoursState.value;

  bool get isWaitingTimeSelectionEnabled {
    return model.walletType(_address) ==
        const WalletType.multisig(MultisigType.multisig2_1);
  }

  @override
  void initWidgetModel() {
    super.initWidgetModel();
    _validateConfig();
  }

  int _calculateInitialRequireConfirmations() {
    final initial = wmParams.value.initialRequireConfirmations ??
        defaultRequireConfirmations;
    final custodiansCount = wmParams.value.initialCustodians?.length ?? 3;

    return initial > custodiansCount ? custodiansCount : initial;
  }

  void _validateConfig() {
    final isValid = model.validateConfig(
      custodians: _custodiansState.value,
      requireConfirmations: _requireConfirmationsState.value,
      hours: _hoursState.value,
    );

    _isValidState.value = isValid;
    _errorMessageState.value = null;

    if (!isValid) {
      if (!model.validateRequireConfirmations(
        _requireConfirmationsState.value,
        _custodiansState.value.length,
      )) {
        _errorMessageState.value = LocaleKeys.invalidValue.tr();
      } else if (!model.validateHours(_hoursState.value)) {
        _errorMessageState.value = LocaleKeys.invalidValue.tr();
      }
    }
  }

  void onNext({
    required List<PublicKey> custodians,
    required int requireConfirmations,
    required int hours,
  }) {
    // Update state with provided parameters
    _custodiansState.value = custodians;
    _requireConfirmationsState.value = requireConfirmations;
    _hoursState.value = hours;

    // Validate the configuration
    _validateConfig();

    if (!_isValidState.value) return;

    context.compassContinue(
      WalletDeployConfirmRouteData(
        address: _address,
        publicKey: _publicKey,
        deployType: WalletDeployType.multisig,
        custodians: custodians,
        requireConfirmations: requireConfirmations,
        hours: hours,
      ),
    );
  }
}

class WalletMultisigConfigWmParams {
  const WalletMultisigConfigWmParams({
    required this.address,
    required this.publicKey,
    this.initialCustodians,
    this.initialRequireConfirmations,
    this.initialHours,
  });

  final Address address;
  final PublicKey publicKey;
  final List<PublicKey>? initialCustodians;
  final int? initialRequireConfirmations;
  final int? initialHours;
}
