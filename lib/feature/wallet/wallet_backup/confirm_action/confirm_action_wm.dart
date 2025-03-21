// ignore_for_file: use_build_context_synchronously
import 'dart:async';

import 'package:app/app/router/app_route.dart';
import 'package:app/core/error_handler_factory.dart';
import 'package:app/core/wm/custom_wm.dart';
import 'package:app/di/di.dart';
import 'package:app/feature/wallet/wallet_backup/confirm_action/confirm_action_data.dart';
import 'package:app/feature/wallet/wallet_backup/confirm_action/confirm_action_dialog.dart';
import 'package:app/feature/wallet/wallet_backup/confirm_action/confirm_action_model.dart';
import 'package:app/feature/wallet/wallet_backup/manual_backup/manual_back_up_dialog.dart';
import 'package:app/generated/generated.dart';
import 'package:elementary_helper/elementary_helper.dart';
import 'package:flutter/widgets.dart';
import 'package:local_auth/local_auth.dart';
import 'package:nekoton_repository/nekoton_repository.dart';
import 'package:ui_components_lib/v2/ui_components_lib_v2.dart';

ConfirmActionWidgetModel defaultConfirmActionWidgetModelFactory(
  BuildContext context,
) {
  return ConfirmActionWidgetModel(
    ConfirmActionModel(
      createPrimaryErrorHandler(context),
      inject(),
      inject(),
      inject(),
      inject(),
    ),
  );
}

class ConfirmActionWidgetModel
    extends CustomWidgetModel<ContentConfirmAction, ConfirmActionModel> {
  ConfirmActionWidgetModel(super.model);

  ThemeStyleV2 get themeStyle => context.themeStyleV2;

  ListenableState<List<BiometricType>> get availableBiometry =>
      _availableBiometry;

  late final _availableBiometry = createNotifier<List<BiometricType>>();

  late final screenState = createEntityNotifier<ConfirmActionData>()
    ..loading(ConfirmActionData());

  late final passwordController = createTextEditingController();

  @override
  void initWidgetModel() {
    passwordController.addListener(_resetError);
    _getAvailableBiometry();
    super.initWidgetModel();
  }

  void onClickConfirm() {
    screenState.content(ConfirmActionData(isLoading: true));
    final publicKey = model.currentSeed?.publicKey;
    if (publicKey != null) {
      _export(publicKey, passwordController.text);
    }
  }

  Future<void> onUseBiometry() async {
    final publicKey = model.currentSeed?.publicKey;
    if (publicKey != null) {
      final password = await model.requestBiometry(publicKey);

      if (password != null) {
        await _export(publicKey, password);
      }
    }
  }

  Future<void> _getAvailableBiometry() async {
    final publicKey = model.currentSeed?.publicKey;
    if (publicKey != null) {
      final available = await model.getAvailableBiometry(publicKey);
      _availableBiometry.accept(available);
    }
  }

  void _resetError() {
    screenState.content(ConfirmActionData());
  }

  Future<void> _export(PublicKey publicKey, String password) async {
    final seed = model.findSeed(publicKey);
    if (seed != null) {
      try {
        final phrase = await seed.export(password);

        context.maybePop();
        await showManualBackupDialog(
          context,
          phrase,
          widget.account?.address.address ?? '',
          widget.finishedBackupCallback,
        );
      } catch (_) {
        screenState
            .content(ConfirmActionData(error: LocaleKeys.passwordIsWrong.tr()));
      }
    } else {
      model.showValidateError(LocaleKeys.seedIsMissing.tr());
    }
  }
}
