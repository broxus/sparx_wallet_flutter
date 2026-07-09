import 'package:app/core/wm/custom_wm.dart';
import 'package:app/feature/onboarding/screen/restore_backup/restore_backup_screen_wm.dart';
import 'package:app/generated/generated.dart';
import 'package:app/utils/focus_utils.dart';
import 'package:flutter/material.dart';
import 'package:ui_components_lib/ui_components_lib.dart';

/// Onboarding screen that restores seeds and accounts from an encrypted backup.
class RestoreBackupScreen
    extends InjectedElementaryWidget<RestoreBackupScreenWidgetModel> {
  const RestoreBackupScreen({super.key});

  @override
  Widget build(RestoreBackupScreenWidgetModel wm) {
    final themeStyle = wm.themeStyle;

    return GestureDetector(
      onTap: resetFocus,
      child: Scaffold(
        backgroundColor: themeStyle.colors.background0,
        resizeToAvoidBottomInset: false,
        appBar: const DefaultAppBar(),
        body: SafeArea(
          minimum: const EdgeInsets.symmetric(horizontal: DimensSize.d16),
          child: Form(
            key: wm.formKey,
            child: AdaptiveFooterSingleChildScrollView(
              footer: Padding(
                padding: const EdgeInsets.only(bottom: DimensSize.d16),
                child: ValueListenableBuilder(
                  valueListenable: wm.isLoadingState,
                  builder: (_, isLoading, __) => AccentButton(
                    buttonShape: ButtonShape.pill,
                    title: LocaleKeys.restoreBackupConfirmButton.tr(),
                    isLoading: isLoading,
                    onPressed: wm.onConfirm,
                  ),
                ),
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  Text(
                    LocaleKeys.restoreBackupTitle.tr(),
                    style: themeStyle.textStyles.headingLarge,
                  ),
                  const SizedBox(height: DimensSize.d12),
                  Text(
                    LocaleKeys.restoreBackupDescription.tr(),
                    style: themeStyle.textStyles.paragraphMedium.copyWith(
                      color: themeStyle.colors.content1,
                    ),
                  ),
                  const SizedBox(height: DimensSize.d24),
                  SecureTextField(
                    textEditingController: wm.passwordController,
                    hintText: LocaleKeys.storageBackupPasswordHint.tr(),
                    validator: wm.validatePassword,
                    isAutofocus: true,
                    onSubmit: (_) => wm.onConfirm(),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
