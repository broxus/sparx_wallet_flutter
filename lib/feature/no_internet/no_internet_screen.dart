import 'package:app/core/wm/custom_wm.dart';
import 'package:app/feature/no_internet/no_internet_screen_wm.dart';
import 'package:app/generated/generated.dart';
import 'package:flutter/material.dart';
import 'package:ui_components_lib/ui_components_lib.dart';

class NoInternetScreen
    extends InjectedElementaryWidget<NoInternetScreenWidgetModel> {
  const NoInternetScreen({super.key});

  @override
  Widget build(NoInternetScreenWidgetModel wm) {
    return Scaffold(
      backgroundColor: wm.colors.background0,
      body: SafeArea(
        child: Stack(
          children: [
            Assets.images.bgInternet.image(width: double.infinity),
            Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text(
                  LocaleKeys.oopsNoInternet.tr(),
                  style: wm.textStyles.headingLarge,
                  textAlign: TextAlign.center,
                ),
                const SizedBox(height: DimensSize.d8),
                Text(
                  LocaleKeys.offlineCheckConnection.tr(),
                  style: wm.textStyles.paragraphMedium,
                  textAlign: TextAlign.center,
                ),
              ],
            ),
            Positioned(
              bottom: DimensSize.d34,
              left: DimensSize.d16,
              right: DimensSize.d16,
              child: PrimaryButton(
                buttonShape: ButtonShape.pill,
                title: LocaleKeys.tryAgain.tr(),
                onPressed: wm.onPressedTryAgain,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
