import 'package:app/core/error_handler_factory.dart';
import 'package:app/core/wm/custom_wm.dart';
import 'package:app/di/di.dart';
import 'package:app/feature/profile/widgets/enter_password/data/data.dart';
import 'package:app/feature/profile/widgets/enter_password/enter_password.dart';
import 'package:app/feature/profile/widgets/enter_password/enter_password_model.dart';
import 'package:app/generated/generated.dart';
import 'package:elementary_helper/elementary_helper.dart';
import 'package:flutter/material.dart';
import 'package:nekoton_repository/nekoton_repository.dart';
import 'package:ui_components_lib/v2/ui_components_lib_v2.dart';

EnterPasswordWidgetModel defaultEnterPasswordWidgetModelFactory(
  BuildContext context,
) =>
    EnterPasswordWidgetModel(
      EnterPasswordModel(
        createPrimaryErrorHandler(context),
        inject(),
        inject(),
        inject(),
      ),
    );

class EnterPasswordWidgetModel
    extends CustomWidgetModel<EnterPasswordWidget, EnterPasswordModel> {
  EnterPasswordWidgetModel(super.model);

  late final _state = createNotifier<EnterPasswordState>();
  late final _publicKeyProp = createWidgetProperty((w) => w.publicKey);
  late final _onConfirmedProp = createWidgetProperty((w) => w.onConfirmed);
  late final _onPasswordEnteredProp = createWidgetProperty(
    (w) => w.onPasswordEntered,
  );
  late final _providerProp = createWidgetProperty(
    (w) => w.getLedgerAuthInput,
  );

  late final passwordController = createTextEditingController();
  late final props = createWidgetProperty(
    (w) => EnterPasswordProps(
      title: w.title,
      isLoading: w.isLoading,
      isDisabled: w.isDisabled,
      isAutofocus: w.isAutofocus,
    ),
  );

  ListenableState<EnterPasswordState> get state => _state;

  ThemeStyleV2 get theme => context.themeStyleV2;

  @override
  void initWidgetModel() {
    super.initWidgetModel();
    _init();
  }

  // ignore: avoid_positional_boolean_parameters
  Future<void> onBiometry(bool isFace) async {
    final publicKey = _publicKeyProp.value;
    final onConfirmed = _onConfirmedProp.value;
    final onPasswordEntered = _onPasswordEnteredProp.value;

    if (publicKey == null) return;

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
      _state.accept(const EnterPasswordState.password());
    }
  }

  /// User entered password, validate it and emit do next action.
  /// If biometry is enabled, save password to storage.
  Future<void> onPassword(String password) async {
    final publicKey = _publicKeyProp.value;
    final onConfirmed = _onConfirmedProp.value;
    final onPasswordEntered = _onPasswordEnteredProp.value;

    if (publicKey == null) return;

    if (password.isEmpty) {
      _showWrongPassword();
      return;
    }

    final correct =
        await model.checkKeyPassword(publicKey: publicKey, password: password);

    if (!correct) {
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
    final onConfirmed = _onConfirmedProp.value;
    final provider = _providerProp.value;

    if (onConfirmed == null || provider == null) return;

    onConfirmed(await provider());
  }

  Future<void> _init() async {
    final seed = model.findSeedByAnyPublicKey(widget.publicKey);
    if (seed != null &&
        seed.masterKey.isLedger &&
        widget.getLedgerAuthInput != null) {
      _state.accept(const EnterPasswordState.ledger());
      return;
    }

    final hasKeyPassword = await model.hasKeyPassword(widget.publicKey);
    if (model.isBiometryEnabled && hasKeyPassword) {
      final isFace = await model.isFaceBiometry();
      _state.accept(EnterPasswordState.biometry(isFace: isFace));
    } else {
      _state.accept(const EnterPasswordState.password());
    }
  }

  void _showWrongPassword() => model.showError(LocaleKeys.passwordIsWrong.tr());
}
