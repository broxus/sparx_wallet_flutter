import 'package:app/core/wm/custom_wm.dart';
import 'package:app/feature/biometry/view/biometry_screen_wm.dart';
import 'package:app/feature/biometry/view/biometry_view.dart';
import 'package:elementary_helper/elementary_helper.dart';
import 'package:flutter/material.dart';
import 'package:ui_components_lib/ui_components_lib.dart';

/// This is a helper page that allows enable biometry after adding seed from
/// onboarding page.
///
/// Displaying this page means, that biometry is available on device and NOT
/// ENABLED.
///
/// This is a fake enabling biometry for seed, because it's difficult to provide
/// it here, so password should be stored after creating, here we just enable it
class BiometryScreen
    extends InjectedElementaryWidget<BiometryScreenWidgetModel> {
  const BiometryScreen({super.key});

  @override
  Widget build(BiometryScreenWidgetModel wm) {
    final theme = wm.theme;

    return StateNotifierBuilder(
      listenableState: wm.isFaceBiometryState,
      builder: (_, isFace) {
        if (isFace == null) return const SizedBox.shrink();

        return PopCapture(
          onPop: wm.onSystemPop,
          child: Scaffold(
            backgroundColor: theme.colors.background0,
            body: Padding(
              padding: const EdgeInsets.symmetric(horizontal: DimensSize.d16),
              child: BiometryView(
                isFace: isFace,
                onEnable: wm.onEnableBiometry,
                onSkip: wm.onSkip,
              ),
            ),
          ),
        );
      },
    );
  }
}
