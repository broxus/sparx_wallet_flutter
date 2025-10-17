import 'package:app/app/router/compass/compass.dart';
import 'package:app/feature/add_seed/add_existing_wallet/route.dart';
import 'package:app/feature/add_seed/create_password/route.dart';
import 'package:app/feature/choose_network/choose_network_screen.dart';
import 'package:injectable/injectable.dart';

const _nextStepQueryParam = 'nextStep';

@named
@Singleton(as: CompassBaseRoute)
class ChooseNetworkRoute extends CompassRoute<ChooseNetworkRouteData> {
  ChooseNetworkRoute(
    @Named.from(CreateSeedOnboardingPasswordRoute)
    CompassBaseRoute createSeedOnboardingPasswordRoute,
    @Named.from(AddExistingWalletRoute) CompassBaseRoute addExistingWalletRoute,
  ) : super(
        path: '/choose-network',
        builder: (context, data, _) {
          return ChooseNetworkScreen(nextStep: data.nextStep);
        },
        compassBaseRoutes: [
          createSeedOnboardingPasswordRoute,
          addExistingWalletRoute,
        ],
      );

  @override
  ChooseNetworkRouteData fromQueryParams(Map<String, String> queryParams) {
    return ChooseNetworkRouteData(
      nextStep: ChooseNetworkNextStep.values.byName(
        queryParams[_nextStepQueryParam]!,
      ),
    );
  }
}

/// Enum representing possible next steps after choosing a network
enum ChooseNetworkNextStep { createSeedPassword, addExistingWallet }

class ChooseNetworkRouteData implements CompassRouteDataQuery {
  const ChooseNetworkRouteData({required this.nextStep});

  final ChooseNetworkNextStep nextStep;

  @override
  Map<String, String> toQueryParams() {
    return {_nextStepQueryParam: nextStep.name};
  }
}
