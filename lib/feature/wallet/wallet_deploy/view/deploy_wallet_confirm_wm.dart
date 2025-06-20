// ignore_for_file: use_build_context_synchronously
// ignore_for_file: inference_failure_on_function_return_type
import 'dart:async';

import 'package:app/app/router/router.dart';
import 'package:app/core/wm/custom_wm.dart';
import 'package:injectable/injectable.dart';
import 'package:app/feature/wallet/wallet_deploy/view/deploy_wallet_confirm_modal.dart';
import 'package:app/feature/wallet/wallet_deploy/view/deploy_wallet_confirm_model.dart';
import 'package:app/generated/generated.dart';
import 'package:elementary_helper/elementary_helper.dart';
import 'package:local_auth/local_auth.dart';
import 'package:nekoton_repository/nekoton_repository.dart';
import 'package:ui_components_lib/v2/ui_components_lib_v2.dart';

typedef PasswordChangeCallback = Function(String);

@injectable
class DeployWalletConfirmWidgetModel extends CustomWidgetModel<
    DeployWalletConfirmModal, DeployWalletConfirmModel> {
  DeployWalletConfirmWidgetModel(
    super.model,
    @factoryParam this._passwordCallback,
  );

  final PasswordChangeCallback _passwordCallback;

  ThemeStyleV2 get themeStyle => context.themeStyleV2;

  ListenableState<List<BiometricType>> get availableBiometry =>
      _availableBiometry;

  late final _availableBiometry = createNotifier<List<BiometricType>>();

  late final passwordState = createEntityNotifier<String>();

  late final passwordController = createTextEditingController();

  @override
  void initWidgetModel() {
    _getAvailableBiometry();
    super.initWidgetModel();
  }

  void onClickConfirm() {
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

  Future<void> _export(PublicKey publicKey, String password) async {
    final seed = model.findSeed(publicKey);
    if (seed != null) {
      try {
        await seed.export(password);
        context.compassBack();
        _passwordCallback(password);
      } catch (_) {
        model.showValidateError(LocaleKeys.passwordIsWrong.tr());
      }
    } else {
      model.showValidateError(LocaleKeys.seedIsMissing.tr());
    }
  }
}
