import 'dart:io';

import 'package:app/app/router/compass/compass.dart';
import 'package:app/app/router/router.dart';
import 'package:app/app/service/bootstrap/bootstrap_steps.dart';
import 'package:app/core/wm/custom_wm.dart';
import 'package:app/feature/bootstrap_failed/route.dart';
import 'package:app/feature/no_internet/route.dart';
import 'package:app/feature/splash/splash_screen.dart';
import 'package:app/feature/splash/splash_screen_model.dart';
import 'package:app/feature/wallet/route.dart';
import 'package:elementary/elementary.dart';
import 'package:injectable/injectable.dart';
import 'package:logging/logging.dart';

/// [WidgetModel] для [SplashScreen]
@injectable
class SplashScreenWidgetModel
    extends CustomWidgetModel<SplashScreen, SplashScreenModel> {
  SplashScreenWidgetModel(
    super.model,
  );
  final _logger = Logger('SplashScreenWidgetModel');

  late final isIos = Platform.isIOS;

  @override
  void initWidgetModel() {
    super.initWidgetModel();
    _init();
  }

  Future<void> _init() async {
    final isExistInternet = await model.isExistInternet;

    if (!isExistInternet) {
      contextSafe?.compassPoint(const NoInternetRouteData());
      return;
    }

    final isConfigurationSuccess = await model.configure();

    if (isConfigurationSuccess) {
      final savedNavigation = await model.getSavedNavigation();

      if (savedNavigation != null) {
        _logger.info('Navigate to $savedNavigation');
        // Use CompassRouter methods for all navigation to maintain consistency
        contextSafe?.compassPoint(
          UnsafeRedirectCompassRouteData(route: savedNavigation),
        );
      } else {
        _logger.info('Navigate to wallet');
        contextSafe?.compassPoint(const WalletRouteData());
      }
    } else {
      final stepIndex = model.getBootstrapStepPathParam();
      final step = BootstrapSteps.values[int.tryParse(stepIndex) ?? 0];

      contextSafe?.compassPoint(BootstrapFailedRouteData(step: step));
    }
  }
}
