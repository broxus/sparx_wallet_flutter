import 'package:app/app/router/base/base.dart';
import 'package:app/app/router/base/route.dart';
import 'package:app/app/router/page_transitions.dart';
import 'package:app/feature/choose_network/route.dart';
import 'package:app/feature/onboarding/screen/welcome/welcome_screen.dart';
import 'package:injectable/injectable.dart';

@lazySingleton
class OnBoardingRoute
    extends SparxRouteParameterless<OnBoardingRouteData, void> {
  OnBoardingRoute(
    this.chooseNetworkRoute,
  ) : super(
          name: 'onboarding',
          pageBuilder: (context, _, state) => onboardingTransitionPageBuilder(
            context,
            state,
            const WelcomeScreen(),
          ),
          sparxBaseRoutes: [chooseNetworkRoute],
        );

  final ChooseNetworkRoute chooseNetworkRoute;

  @override
  OnBoardingRouteData dataFabric() {
    return OnBoardingRouteData();
  }
}

class OnBoardingRouteData implements SparxRouteData {}
