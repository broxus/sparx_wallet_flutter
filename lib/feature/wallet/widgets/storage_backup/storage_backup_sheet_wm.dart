// ignore_for_file: use_build_context_synchronously
import 'package:app/core/wm/custom_wm.dart';
import 'package:app/feature/wallet/widgets/storage_backup/storage_backup_sheet.dart';
import 'package:app/feature/wallet/widgets/storage_backup/storage_backup_sheet_model.dart';
import 'package:app/generated/generated.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:injectable/injectable.dart';
import 'package:ui_components_lib/ui_components_lib.dart';

@injectable
class StorageBackupSheetWidgetModel
    extends CustomWidgetModel<StorageBackupSheet, StorageBackupSheetModel> {
  StorageBackupSheetWidgetModel(super.model);

  final formKey = GlobalKey<FormState>();

  late final passwordController = createTextEditingController();
  late final confirmController = createTextEditingController();
  late final confirmFocus = createFocusNode();

  late final _isLoadingState = createValueNotifier(false);

  ThemeStyle get themeStyle => context.themeStyle;

  ValueListenable<bool> get isLoadingState => _isLoadingState;

  String? validatePassword(String? value) {
    if (value == null || value.isEmpty) {
      return LocaleKeys.storageBackupPasswordRequired.tr();
    }

    return null;
  }

  String? validateConfirm(String? value) {
    if (value == null || value.isEmpty) {
      return LocaleKeys.storageBackupPasswordRequired.tr();
    }

    if (value != passwordController.text) {
      return LocaleKeys.storageBackupPasswordsDoNotMatch.tr();
    }

    return null;
  }

  void onSubmitPassword() => confirmFocus.requestFocus();

  Future<void> onConfirm() async {
    if (!(formKey.currentState?.validate() ?? false)) return;

    FocusManager.instance.primaryFocus?.unfocus();
    _isLoadingState.value = true;

    try {
      await model.backup(passwordController.text);

      model.showSuccess();

      if (context.mounted) {
        Navigator.of(context).pop();
      }
    } catch (_) {
      _isLoadingState.value = false;
      model.showError();
    }
  }
}
