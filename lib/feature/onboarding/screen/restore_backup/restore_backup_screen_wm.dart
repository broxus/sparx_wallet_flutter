// ignore_for_file: use_build_context_synchronously
import 'package:app/app/router/router.dart';
import 'package:app/core/wm/custom_wm.dart';
import 'package:app/feature/onboarding/screen/restore_backup/restore_backup_screen.dart';
import 'package:app/feature/onboarding/screen/restore_backup/restore_backup_screen_model.dart';
import 'package:app/feature/wallet/route.dart';
import 'package:app/generated/generated.dart';
import 'package:elementary/elementary.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:injectable/injectable.dart';
import 'package:ui_components_lib/ui_components_lib.dart';

/// [WidgetModel] for [RestoreBackupScreen]
@injectable
class RestoreBackupScreenWidgetModel
    extends CustomWidgetModel<RestoreBackupScreen, RestoreBackupScreenModel> {
  RestoreBackupScreenWidgetModel(super.model);

  final formKey = GlobalKey<FormState>();

  late final passwordController = createTextEditingController();

  late final _isLoadingState = createValueNotifier(false);

  ThemeStyle get themeStyle => context.themeStyle;

  ValueListenable<bool> get isLoadingState => _isLoadingState;

  String? validatePassword(String? value) {
    if (value == null || value.isEmpty) {
      return LocaleKeys.storageBackupPasswordRequired.tr();
    }

    return null;
  }

  Future<void> onConfirm() async {
    if (!(formKey.currentState?.validate() ?? false)) return;

    FocusManager.instance.primaryFocus?.unfocus();
    _isLoadingState.value = true;

    try {
      await model.restore(passwordController.text);

      model.showSuccess();
      contextSafe?.compassPointNamed(const WalletRouteData());
    } catch (_) {
      _isLoadingState.value = false;
      model.showError();
    }
  }
}
