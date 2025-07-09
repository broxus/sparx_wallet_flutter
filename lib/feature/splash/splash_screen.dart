import 'package:app/feature/splash/splash_screen_wm.dart';
import 'package:app/generated/generated.dart';
import 'package:elementary/elementary.dart';
import 'package:flutter/material.dart';
import 'package:ui_components_lib/v2/colors_v2.dart';

class SplashScreen extends ElementaryWidget<SplashScreenWidgetModel> {
  const SplashScreen({
    Key? key,
    WidgetModelFactory wmFactory = defaultSplashScreenWidgetModelFactory,
  }) : super(wmFactory, key: key);

  @override
  Widget build(SplashScreenWidgetModel wm) {
    return DecoratedBox(
      decoration: const BoxDecoration(color: ColorsResV2.n10),
      child: Center(
        child: wm.isIos ? const _IosLogo() : const _AndroidLogo(),
      ),
    );
  }
}

class _AndroidLogo extends StatelessWidget {
  const _AndroidLogo();

  @override
  Widget build(BuildContext context) {
    return Assets.splash.icSplashLogo.image(
      width: 240,
      height: 240,
    );
  }
}

class _IosLogo extends StatelessWidget {
  const _IosLogo();

  @override
  Widget build(BuildContext context) {
    return Assets.splash.icSplashBanner.image(
      width: 247,
      height: 72,
    );
  }
}
