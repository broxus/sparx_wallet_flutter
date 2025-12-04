import 'package:app/core/wm/custom_wm.dart';
import 'package:app/feature/bootstrap_failed/view/bootstrap_failed_rerun_wm.dart';
import 'package:app/generated/generated.dart';
import 'package:elementary_helper/elementary_helper.dart';
import 'package:flutter/material.dart';
import 'package:ui_components_lib/ui_components_lib.dart';
import 'package:ui_components_lib/v2/ui_components_lib_v2.dart';

/// Simple view (not created design), that allows just rerun bootstrap process
class BootstrapFailedRerunView
    extends InjectedElementaryWidget<BootstrapFailedRerunWidgetModel> {
  const BootstrapFailedRerunView({super.key});

  @override
  Widget build(BootstrapFailedRerunWidgetModel wm) {
    return Scaffold(
      appBar: DefaultAppBar(backgroundColor: wm.theme.colors.background0),
      body: Container(
        color: wm.theme.colors.background0,
        padding: const EdgeInsets.all(DimensSize.d16),
        child: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text(
                LocaleKeys.initializationFailedDescription.tr(),
                style: wm.theme.textStyles.labelSmall,
                textAlign: TextAlign.center,
              ),
              const SizedBox(height: DimensSize.d24),
              Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  StateNotifierBuilder(
                    listenableState: wm.loadingState,
                    builder: (_, isLoading) => PrimaryButton(
                      buttonShape: ButtonShape.pill,
                      title: LocaleKeys.tryAgain.tr(),
                      isLoading: isLoading ?? false,
                      onPressed: wm.onPressedTryAgain,
                    ),
                  ),
                  const SizedBox(height: DimensSize.d16),
                  PrimaryButton(
                    buttonShape: ButtonShape.pill,
                    title: LocaleKeys.contactSupport.tr(),
                    onPressed: wm.onPressedContactSupport,
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
