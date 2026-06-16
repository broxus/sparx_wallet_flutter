import 'package:app/core/wm/custom_wm.dart';
import 'package:app/feature/wallet/widgets/storage_backup/storage_backup_sheet_wm.dart';
import 'package:app/generated/generated.dart';
import 'package:flutter/material.dart';
import 'package:ui_components_lib/ui_components_lib.dart';

/// Shows the bottom sheet that lets the user create an encrypted backup of
/// seeds and accounts protected by a separate password.
Future<void> showStorageBackupSheet(
  BuildContext context, {
  bool dismissible = true,
}) {
  return showPrimaryBottomSheet<void>(
    context: context,
    dismissible: dismissible,
    title: LocaleKeys.storageBackupSheetTitle.tr(),
    content: const StorageBackupSheet(),
  );
}

class StorageBackupSheet
    extends InjectedElementaryWidget<StorageBackupSheetWidgetModel> {
  const StorageBackupSheet({super.key});

  @override
  Widget build(StorageBackupSheetWidgetModel wm) {
    final theme = wm.themeStyle;

    return Form(
      key: wm.formKey,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        mainAxisSize: MainAxisSize.min,
        children: [
          Text(
            LocaleKeys.storageBackupSheetDescription.tr(),
            style: theme.textStyles.paragraphMedium.copyWith(
              color: theme.colors.content1,
            ),
          ),
          const SizedBox(height: DimensSize.d24),
          SecureTextField(
            textEditingController: wm.passwordController,
            hintText: LocaleKeys.storageBackupPasswordHint.tr(),
            validator: wm.validatePassword,
            textInputAction: TextInputAction.next,
            onSubmit: (_) => wm.onSubmitPassword(),
          ),
          const SizedBox(height: DimensSize.d12),
          SecureTextField(
            textEditingController: wm.confirmController,
            focusNode: wm.confirmFocus,
            hintText: LocaleKeys.storageBackupConfirmPasswordHint.tr(),
            validator: wm.validateConfirm,
            onSubmit: (_) => wm.onConfirm(),
          ),
          const SizedBox(height: DimensSize.d24),
          ValueListenableBuilder(
            valueListenable: wm.isLoadingState,
            builder: (_, isLoading, __) => AccentButton(
              buttonShape: ButtonShape.pill,
              title: LocaleKeys.storageBackupConfirmButton.tr(),
              isLoading: isLoading,
              onPressed: wm.onConfirm,
            ),
          ),
        ],
      ),
    );
  }
}
