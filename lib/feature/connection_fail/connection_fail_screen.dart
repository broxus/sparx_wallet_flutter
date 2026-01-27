import 'package:app/core/wm/custom_wm.dart';
import 'package:app/feature/connection_fail/connection_fail_screen_wm.dart';
import 'package:app/generated/generated.dart';
import 'package:flutter/material.dart';
import 'package:ui_components_lib/ui_components_lib.dart';

class ConnectionFailScreen
    extends InjectedElementaryWidget<ConnectionFailWidgetModel> {
  const ConnectionFailScreen({super.key});

  @override
  Widget build(ConnectionFailWidgetModel wm) {
    return Scaffold(
      appBar: const DefaultAppBar(),
      body: SystemPadding(
        child: Stack(
          children: [
            Assets.images.bgConnection.image(width: double.infinity),
            SizedBox(
              width: double.infinity,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                    LocaleKeys.noRpcConnection.tr(),
                    style: wm.textStyles.headingLarge,
                    textAlign: TextAlign.center,
                  ),
                  const SizedBox(height: DimensSize.d8),
                  Text(
                    LocaleKeys.tryAgainOrContact.tr(),
                    style: wm.textStyles.paragraphMedium,
                    textAlign: TextAlign.center,
                  ),
                ],
              ),
            ),
            Positioned(
              bottom: DimensSize.d34,
              left: DimensSize.d16,
              right: DimensSize.d16,
              child: Column(
                children: [
                  PrimaryButton(
                    buttonShape: ButtonShape.pill,
                    title: LocaleKeys.tryAgain.tr(),
                    onPressed: wm.onPressedTryAgain,
                  ),
                  const SizedBox(height: DimensSize.d12),
                  PrimaryButton(
                    buttonShape: ButtonShape.pill,
                    title: LocaleKeys.contactUs.tr(),
                    onPressed: wm.onPressedContactUs,
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
