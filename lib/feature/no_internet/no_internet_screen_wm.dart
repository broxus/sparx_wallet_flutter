// ignore_for_file: use_build_context_synchronously

import 'package:app/app/router/router.dart';
import 'package:app/core/wm/custom_wm.dart';
import 'package:app/feature/no_internet/no_internet_screen.dart';
import 'package:app/feature/no_internet/no_internet_screen_model.dart';
import 'package:app/feature/splash/route.dart';
import 'package:elementary/elementary.dart';
import 'package:injectable/injectable.dart';
import 'package:ui_components_lib/ui_components_lib.dart';
import 'package:ui_components_lib/v2/text_styles_v2.dart';

/// [WidgetModel] для [NoInternetScreen]
@injectable
class NoInternetScreenWidgetModel
    extends CustomWidgetModel<NoInternetScreen, NoInternetScreenModel> {
  NoInternetScreenWidgetModel(super.model);

  ThemeStyleV2 get _theme => context.themeStyleV2;

  TextStylesV2 get textStyles => _theme.textStyles;

  ColorsPaletteV2 get colors => _theme.colors;

  Future<void> onPressedTryAgain() async {
    final isExistInternet = await model.isExistInternet;

    final ctx = contextSafe;

    if (ctx != null && isExistInternet) {
      contextSafe?.compassPoint(const SplashScreenRouteData());
    }
  }
}
