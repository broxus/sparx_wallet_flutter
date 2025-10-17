import 'package:app/core/wm/custom_wm.dart';
import 'package:app/feature/bootstrap_failed/view/bootstrap_failed_rerun_wm.dart';
import 'package:app/generated/generated.dart';
import 'package:elementary_helper/elementary_helper.dart';
import 'package:flutter/material.dart';
import 'package:ui_components_lib/ui_components_lib.dart';

/// Simple view (not created design), that allows just rerun bootstrap process
class BootstrapFailedRerunView
    extends InjectedElementaryWidget<BootstrapFailedRerunWidgetModel> {
  const BootstrapFailedRerunView({super.key});

  @override
  Widget build(BootstrapFailedRerunWidgetModel wm) {
    // Obtain colors via inherited theme using a Builder to have BuildContext
    return Builder(
      builder: (context) {
        final colors = context.themeStyle.colors;
        return Padding(
          padding: const EdgeInsets.all(DimensSize.d16),
          child: Center(
            child: SeparatedColumn(
              spacing: DimensSize.d32,
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text(
                  LocaleKeys.initializationFailedDescription.tr(),
                  style: StyleRes.addRegular.copyWith(
                    color: colors.textPrimary,
                  ),
                  textAlign: TextAlign.center,
                ),
                Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    StateNotifierBuilder(
                      listenableState: wm.loadingState,
                      builder: (_, isLoading) => CommonButton.primary(
                        fillWidth: true,
                        text: LocaleKeys.tryAgain.tr(),
                        isLoading: isLoading ?? false,
                        onPressed: wm.onPressedTryAgain,
                      ),
                    ),
                    const SizedBox(height: DimensSize.d16),
                    CommonButton.primary(
                      fillWidth: true,
                      text: LocaleKeys.contactSupport.tr(),
                      onPressed: wm.onPressedContactSupport,
                    ),
                  ],
                ),
              ],
            ),
          ),
        );
      },
    );
  }
}
