import 'package:app/app/router/compass/compass.dart';
import 'package:app/feature/choose_network/route.dart';
import 'package:app/feature/onboarding/screen/welcome/welcome_screen.dart';
import 'package:flutter/widgets.dart';
import 'package:go_router/go_router.dart';
import 'package:injectable/injectable.dart';

@named
@Singleton(as: CompassBaseRoute)
class OnBoardingRoute extends CompassRouteParameterless<OnBoardingRouteData> {
  OnBoardingRoute(
    @Named.from(ChooseNetworkRoute) CompassBaseRoute chooseNetworkRoute,
  ) : super(
          name: 'onboarding',
          path: '/onboarding',
          pageBuilder: (context, _, state) => onboardingTransitionPageBuilder(
            context,
            state,
            const WelcomeScreen(),
          ),
          isTopLevel: true,
          compassBaseRoutes: [chooseNetworkRoute],
        );

  @override
  OnBoardingRouteData createData() {
    return const OnBoardingRouteData();
  }
}

class OnBoardingRouteData implements CompassRouteData {
  const OnBoardingRouteData();
}

CustomTransitionPage<void> onboardingTransitionPageBuilder(
  BuildContext _,
  GoRouterState state,
  Widget child,
) {
  return CustomTransitionPage<void>(
    key: state.pageKey,
    name: state.name,
    child: child,
    transitionsBuilder: (
      BuildContext context,
      Animation<double> animation,
      Animation<double> secondaryAnimation,
      Widget child,
    ) {
      return SlideTransition(
        position: animation.drive(
          Tween<Offset>(
            begin: const Offset(-1, 0),
            end: Offset.zero,
          ).chain(
            CurveTween(curve: Curves.easeInOut),
          ),
        ),
        child: child,
      );
    },
  );
}
