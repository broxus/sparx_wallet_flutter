import 'package:app/core/wm/custom_wm.dart';
import 'package:app/feature/profile/widgets/enter_password/data/data.dart';
import 'package:app/feature/profile/widgets/enter_password/enter_password.dart';
import 'package:app/feature/profile/widgets/enter_password/enter_password_model.dart';
import 'package:app/generated/generated.dart';
import 'package:app/utils/utils.dart';
import 'package:elementary_helper/elementary_helper.dart';
import 'package:flutter/foundation.dart';
import 'package:injectable/injectable.dart';
import 'package:nekoton_repository/nekoton_repository.dart';
import 'package:ui_components_lib/v2/ui_components_lib_v2.dart';

class EnterPasswordWmParams {
  const EnterPasswordWmParams({
    required this.publicKey,
    required this.title,
    required this.isLoading,
    required this.isDisabled,
    required this.isAutofocus,
    required this.getLedgerAuthInput,
    required this.onConfirmed,
    required this.onPasswordEntered,
  });

  /// Key for which password must be entered.
  final PublicKey publicKey;
  final String? title;
  final bool isLoading;
  final bool isDisabled;
  final bool isAutofocus;
  final GetLedgerAuthInput? getLedgerAuthInput;

  /// Callback that will be called when user confirmed action via password
  /// or Ledger.
  final ValueChanged<SignInputAuth>? onConfirmed;
  final ValueChanged<String>? onPasswordEntered;
}

@injectable
class EnterPasswordWidgetModel
    extends
        CustomWidgetModelParametrized<
          EnterPasswordWidget,
          EnterPasswordModel,
          EnterPasswordWmParams
        > {
  EnterPasswordWidgetModel(super.model);

  late final _lockState = model.getLockState(wmParams.value.publicKey);
  late final _enterPasswordState = createValueNotifier<EnterPasswordState?>(
    null,
  );
  late final _isPasswordLockedState = createNotifierFromStream(
    _lockState.isLockedStream,
  );

  late final passwordController = createTextEditingController();
  late final props = createWmParamsNotifier(
    (w) => EnterPasswordProps(
      title: w.title,
      isLoading: w.isLoading,
      isDisabled: w.isDisabled,
      isAutofocus: w.isAutofocus,
    ),
  );

  ListenableState<bool> get isPasswordLockedState => _isPasswordLockedState;

  ValueListenable<EnterPasswordState?> get enterPasswordState =>
      _enterPasswordState;

  ThemeStyleV2 get theme => context.themeStyleV2;

  @override
  void initWidgetModel() {
    super.initWidgetModel();
    _init();
  }

  // ignore: avoid_positional_boolean_parameters
  Future<void> onBiometry(bool isFace) async {
    final publicKey = wmParams.value.publicKey;
    final onConfirmed = wmParams.value.onConfirmed;
    final onPasswordEntered = wmParams.value.onPasswordEntered;

    try {
      // If we get password from biometry, we suppose it is always valid.
      final password = await model.getKeyPassword(
        publicKey: publicKey,
        localizedReason: LocaleKeys.biometryAuthReason.tr(),
      );

      if (onPasswordEntered != null) {
        onPasswordEntered(password);
      }
      if (onConfirmed != null) {
        onConfirmed(SignInputAuth.password(password));
      }
    } catch (_) {
      _enterPasswordState.value = const EnterPasswordState.password();
    }
  }

  /// User entered password, validate it and emit do next action.
  /// If biometry is enabled, save password to storage.
  Future<void> onPassword(String password) async {
    final publicKey = wmParams.value.publicKey;
    final onConfirmed = wmParams.value.onConfirmed;
    final onPasswordEntered = wmParams.value.onPasswordEntered;
    final languageCode = context.locale.languageCode;

    if (password.isEmpty) {
      _showWrongPassword();
      return;
    }

    if (_lockState.isLocked) {
      _lockState.getErrorMessage(languageCode)?.let(model.showError);
      return;
    }

    final correct = await model.checkKeyPassword(
      publicKey: publicKey,
      password: password,
    );

    if (!correct) {
      final errorMessage = _lockState.getErrorMessage(languageCode);
      if (errorMessage != null) {
        model.showError(errorMessage);
        return;
      }

      _showWrongPassword();
      return;
    }

    if (model.isBiometryEnabled) {
      await model.setKeyPassword(publicKey: publicKey, password: password);
    }

    if (onPasswordEntered != null) {
      onPasswordEntered(password);
    }
    if (onConfirmed != null) {
      onConfirmed(SignInputAuth.password(password));
    }
  }

  Future<void> onLedger() async {
    final onConfirmed = wmParams.value.onConfirmed;
    final getLedgerAuth = wmParams.value.getLedgerAuthInput;

    if (onConfirmed == null) return;
    if (getLedgerAuth == null) {
      model.showError(LocaleKeys.operationNotSupported.tr());
      return;
    }

    onConfirmed(await getLedgerAuth());
  }

  Future<void> _init() async {
    final seed = model.findSeedByAnyPublicKey(wmParams.value.publicKey);
    if (seed != null &&
        seed.masterKey.isLedger &&
        wmParams.value.getLedgerAuthInput != null) {
      _enterPasswordState.value = const EnterPasswordState.ledger();
      return;
    }

    final hasKeyPassword = await model.hasKeyPassword(wmParams.value.publicKey);
    if (model.isBiometryEnabled && hasKeyPassword) {
      final isFace = await model.isFaceBiometry();
      _enterPasswordState.value = EnterPasswordState.biometry(isFace: isFace);
    } else {
      _enterPasswordState.value = const EnterPasswordState.password();
    }
  }

  void _showWrongPassword() => model.showError(LocaleKeys.passwordIsWrong.tr());
}
