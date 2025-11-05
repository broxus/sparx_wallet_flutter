// ignore_for_file: use_build_context_synchronously
import 'dart:async';

import 'package:app/app/router/router.dart';
import 'package:app/core/wm/custom_wm.dart';
import 'package:app/feature/wallet/widgets/wallet_backup/wallet_backup.dart';
import 'package:app/generated/generated.dart';
import 'package:app/utils/utils.dart';
import 'package:elementary_helper/elementary_helper.dart';
import 'package:flutter/foundation.dart';
import 'package:injectable/injectable.dart';
import 'package:local_auth/local_auth.dart';
import 'package:nekoton_repository/nekoton_repository.dart';
import 'package:ui_components_lib/v2/ui_components_lib_v2.dart';

class ConfirmActionWmParams {
  const ConfirmActionWmParams({
    required this.finishedBackupCallback,
    this.account,
  });

  final ValueChanged<bool> finishedBackupCallback;
  final KeyAccount? account;
}

@injectable
class ConfirmActionWidgetModel
    extends
        CustomWidgetModelParametrized<
          ContentConfirmAction,
          ConfirmActionModel,
          ConfirmActionWmParams
        > {
  ConfirmActionWidgetModel(super.model);

  late final _isPasswordLockedState = createNotifierFromStream(
    model.isPasswordLockedStream,
  );

  late final _availableBiometryState = createNotifier<List<BiometricType>>();

  late final ValueListenable<KeyAccount?> accountState = createWmParamsNotifier(
    (it) => it.account,
  );

  late final screenState = createEntityNotifier<ConfirmActionData>()
    ..loading(ConfirmActionData());

  late final passwordController = createTextEditingController();

  ThemeStyleV2 get themeStyle => context.themeStyleV2;

  ListenableState<List<BiometricType>> get availableBiometryState =>
      _availableBiometryState;

  ListenableState<bool> get isPasswordLockedState => _isPasswordLockedState;

  @override
  void initWidgetModel() {
    super.initWidgetModel();
    passwordController.addListener(_resetError);
    _getAvailableBiometry();
  }

  Future<void> onClickConfirm() async {
    screenState.content(ConfirmActionData(isLoading: true));

    final publicKey = model.currentSeed?.publicKey;
    final password = passwordController.text;
    final languageCode = context.locale.languageCode;

    if (publicKey != null) {
      final correct = await model.checkKeyPassword(
        publicKey: publicKey,
        password: password,
      );

      if (!correct) {
        final lockUntil = model.lockUntil;
        if (model.isPasswordLocked && lockUntil != null) {
          final flu = DateTimeUtils.formatLockUntil(lockUntil, languageCode);
          model.showError(LocaleKeys.passwordLockedUntil.tr(args: [flu]));
          return;
        }
      }

      await _export(publicKey, password);
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
      _availableBiometryState.accept(available);
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

        context.compassBack();
        final params = wmParams.value;
        await showManualBackupDialog(
          context,
          phrase,
          params.account?.address.address ?? '',
          params.finishedBackupCallback,
        );
      } catch (_) {
        screenState.content(
          ConfirmActionData(error: LocaleKeys.passwordIsWrong.tr()),
        );
      }
    } else {
      model.showValidateError(LocaleKeys.seedIsMissing.tr());
    }
  }
}
