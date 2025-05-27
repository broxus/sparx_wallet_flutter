import 'package:app/app/router/compass/compass.dart';
import 'package:app/app/service/bootstrap/bootstrap_steps.dart';
import 'package:app/feature/bootstrap_failed/view/bootstrap_failed_page.dart';
import 'package:app/feature/network/configure_networks/route.dart';
import 'package:injectable/injectable.dart';

/// Constants for query parameter names
const _stepQueryParam = 'step';

@named
@Singleton(as: CompassBaseRoute)
class BootstrapFailedRoute extends CompassRoute<BootstrapFailedRouteData> {
  BootstrapFailedRoute(
    @Named.from(ConfigureNetworksRoute) CompassBaseRoute configureNetworksRoute,
  ) : super(
          name: 'bootstrap-failed',
          path: '/bootstrap-failed',
          isTopLevel: true, // Mark as top-level route
          builder: (context, data, _) => BootstrapFailedPage(
            step: data.step,
          ),
          compassBaseRoutes: [configureNetworksRoute],
        );

  @override
  BootstrapFailedRouteData fromQueryParams(Map<String, String> queryParams) {
    final stepStr = queryParams[_stepQueryParam] ?? '0';
    final stepIndex = int.tryParse(stepStr) ?? 0;
    return BootstrapFailedRouteData(
      step: BootstrapSteps.values[stepIndex],
    );
  }
}

class BootstrapFailedRouteData implements CompassRouteDataQuery {
  const BootstrapFailedRouteData({
    required this.step,
  });

  /// Bootstrap step that failed
  final BootstrapSteps step;

  @override
  Map<String, String> toQueryParams() {
    return {
      _stepQueryParam: step.index.toString(),
    };
  }
}
