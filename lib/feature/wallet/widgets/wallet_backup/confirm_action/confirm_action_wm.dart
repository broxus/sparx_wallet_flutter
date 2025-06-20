// ignore_for_file: use_build_context_synchronously
import 'dart:async';

import 'package:app/app/router/router.dart';
import 'package:app/core/wm/custom_wm.dart';
import 'package:injectable/injectable.dart';
import 'package:app/feature/wallet/widgets/wallet_backup/wallet_backup.dart';
import 'package:app/generated/generated.dart';
import 'package:elementary_helper/elementary_helper.dart';
import 'package:flutter/widgets.dart';
import 'package:local_auth/local_auth.dart';
import 'package:nekoton_repository/nekoton_repository.dart';
import 'package:ui_components_lib/v2/ui_components_lib_v2.dart';

class ConfirmActionWmParams {
  const ConfirmActionWmParams({
    required this.finishedBackupCallback,
    this.account,
  });

  final VoidCallback finishedBackupCallback;
  final KeyAccount? account;
}

@injectable
class ConfirmActionWidgetModel
    extends CustomWidgetModel<ContentConfirmAction, ConfirmActionModel> {
  ConfirmActionWidgetModel(
    super.model,
    @factoryParam this._wmParams,
  );

  final ConfirmActionWmParams _wmParams;

  ThemeStyleV2 get themeStyle => context.themeStyleV2;

  ListenableState<List<BiometricType>> get availableBiometry =>
      _availableBiometry;

  KeyAccount? get account => _wmParams.account;

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

        context.compassBack();
        await showManualBackupDialog(
          context,
          phrase,
          _wmParams.account?.address.address ?? '',
          _wmParams.finishedBackupCallback,
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
