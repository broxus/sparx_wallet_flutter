// ignore_for_file: use_build_context_synchronously

import 'package:app/core/wm/custom_wm.dart';
import 'package:injectable/injectable.dart';
import 'package:app/feature/wallet/new_account/add_account_confirm/add_account_confirm_model.dart';
import 'package:app/feature/wallet/new_account/add_account_confirm/add_account_confirm_widget.dart';
import 'package:elementary_helper/elementary_helper.dart';
import 'package:flutter/material.dart';
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
    extends CustomWidgetModel<AddAccountConfirmWidget, AddAccountConfirmModel> {
  AddAccountConfirmWidgetModel(
    super.model,
    @factoryParam this._wmParams,
  );

  final AddAccountConfirmWmParams _wmParams;

  late final controller = createTextEditingController();

  late final _availableBiometry = createNotifier<List<BiometricType>>();

  ListenableState<List<BiometricType>> get availableBiometry =>
      _availableBiometry;

  KeyAccount? get account => model.account;

  ThemeStyleV2 get theme => context.themeStyleV2;

  String get seedName => _wmParams.seedName;

  @override
  void initWidgetModel() {
    _getAvailableBiometry();
    super.initWidgetModel();
  }

  Future<void> onPasswordSubmit() async {
    await _processPassword(controller.text);
  }

  Future<void> onUseBiometry() async {
    final password = await model.requestBiometry(_wmParams.publicKey);

    if (password != null) {
      await _processPassword(password);
    }
  }

  Future<void> _getAvailableBiometry() async {
    final available = await model.getAvailableBiometry(_wmParams.publicKey);
    _availableBiometry.accept(available);
  }

  Future<void> _processPassword(String password) async {
    final isCorrect = await model.checkPassword(
      password: password,
      publicKey: _wmParams.publicKey,
    );

    if (!isCorrect) {
      model.showWrongPassword();
    } else if (contextSafe != null) {
      Navigator.of(contextSafe!).pop(
        (_wmParams.publicKey, password),
      );
    }
  }
}
