// ignore_for_file: use_build_context_synchronously

import 'package:app/core/wm/custom_wm.dart';
import 'package:app/feature/wallet/new_account/add_account_confirm/add_account_confirm_model.dart';
import 'package:app/feature/wallet/new_account/add_account_confirm/add_account_confirm_widget.dart';
import 'package:app/generated/generated.dart';
import 'package:app/utils/utils.dart';
import 'package:elementary_helper/elementary_helper.dart';
import 'package:flutter/material.dart';
import 'package:injectable/injectable.dart';
import 'package:local_auth/local_auth.dart';
import 'package:nekoton_repository/nekoton_repository.dart';
import 'package:ui_components_lib/ui_components_lib.dart';

class AddAccountConfirmWmParams {
  const AddAccountConfirmWmParams({
    required this.publicKey,
    required this.seedName,
  });

  final PublicKey publicKey;
  final String seedName;
}

@injectable
class AddAccountConfirmWidgetModel
    extends
        CustomWidgetModelParametrized<
          AddAccountConfirmWidget,
          AddAccountConfirmModel,
          AddAccountConfirmWmParams
        > {
  AddAccountConfirmWidgetModel(super.model);

  late final _lockState = model.getLockState(wmParams.value.publicKey);

  late final controller = createTextEditingController();

  late final _availableBiometryState = createNotifier<List<BiometricType>>();

  late final _isPasswordLockedState = createNotifierFromStream(
    _lockState.isLockedStream,
  );

  ListenableState<List<BiometricType>> get availableBiometryState =>
      _availableBiometryState;

  ListenableState<bool> get isPasswordLockedState => _isPasswordLockedState;

  KeyAccount? get account => model.account;

  ThemeStyleV2 get theme => context.themeStyleV2;

  String get seedName => wmParams.value.seedName;

  @override
  void initWidgetModel() {
    super.initWidgetModel();
    _getAvailableBiometry();
  }

  Future<void> onPasswordSubmit() async {
    await _processPassword(controller.text);
  }

  Future<void> onUseBiometry() async {
    final password = await model.requestBiometry(wmParams.value.publicKey);

    if (password != null) {
      await _processPassword(password);
    }
  }

  Future<void> _getAvailableBiometry() async {
    final available = await model.getAvailableBiometry(
      wmParams.value.publicKey,
    );
    _availableBiometryState.accept(available);
  }

  Future<void> _processPassword(String password) async {
    final languageCode = context.locale.languageCode;

    if (_lockState.isLocked) {
      _lockState.getErrorMessage(languageCode)?.let(model.showError);
      return;
    }

    final isCorrect = await model.checkPassword(
      password: password,
      publicKey: wmParams.value.publicKey,
    );

    if (!isCorrect) {
      final errorMessage = _lockState.getErrorMessage(languageCode);
      if (errorMessage != null) {
        model.showError(errorMessage);
        return;
      }

      model.showWrongPassword();
      return;
    }

    Navigator.of(contextSafe!).pop((wmParams.value.publicKey, password));
  }
}
