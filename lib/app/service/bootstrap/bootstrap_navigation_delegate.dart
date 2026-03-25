import 'package:app/app/router/compass/guard.dart';
import 'package:app/app/router/router.dart';
import 'package:app/app/service/navigation_service.dart';
import 'package:app/feature/onboarding/route.dart';
import 'package:app/feature/wallet/route.dart';
import 'package:injectable/injectable.dart';
import 'package:logging/logging.dart';
import 'package:nekoton_repository/nekoton_repository.dart';

@injectable
class BootstrapNavigationDelegate {
  BootstrapNavigationDelegate(
    this._nekotonRepository,
    this._navigationService,
    this._router,
  );

  final NekotonRepository _nekotonRepository;
  final NavigationService _navigationService;
  final CompassRouter _router;

  bool? get hasSeeds => _nekotonRepository.hasSeeds.valueOrNull;

  final _logger = Logger('BootstrapNavigationDelegate');

  Future<void> goToResultBootstrap() async {
    if (hasSeeds == false) {
      _logger.info('Initial navigation. Navigate to onboarding');
      _router.compassPoint(const OnBoardingRouteData());
      return;
    }

    final savedNavigation = await _navigationService.getSavedState();

    if (savedNavigation != null) {
      _logger.info('Initial navigation. Navigate to $savedNavigation');
      // Use CompassRouter methods for all navigation to maintain consistency
      _router.compassPoint(
        UnsafeRedirectCompassRouteData(route: savedNavigation),
      );
    } else {
      _logger.info('Initial navigation. Navigate to wallet');
      _router.compassPoint(const WalletRouteData());
    }
  }
}
