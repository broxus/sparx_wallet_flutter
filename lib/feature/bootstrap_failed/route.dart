import 'package:app/app/router/compass/compass.dart';
import 'package:app/app/service/bootstrap/bootstrap_steps.dart';
import 'package:app/feature/bootstrap_failed/view/bootstrap_failed_page.dart';
import 'package:app/feature/network/configure_networks/route.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:injectable/injectable.dart';

part 'route.freezed.dart';

/// Constants for query parameter names
const bootstrapFailedStepQueryParam = 'step';

@lazySingleton
class BootstrapFailedRoute extends CompassRoute<BootstrapFailedRouteData, void> {
  BootstrapFailedRoute({
    required this.configureNetworksRoute,
  }) : super(
          name: 'bootstrap-failed',
          path: '/bootstrap-failed',
          isTopLevel: true, // Mark as top-level route
          builder: (context, data, _) => BootstrapFailedPage(
            step: data.step,
          ),
          compassBaseRoutes: [configureNetworksRoute],
        );

  final ConfigureNetworksRoute configureNetworksRoute;

  @override
  BootstrapFailedRouteData fromQueryParams(Map<String, String> queryParams) {
    final stepStr = queryParams[bootstrapFailedStepQueryParam] ?? '0';
    final stepIndex = int.tryParse(stepStr) ?? 0;
    return BootstrapFailedRouteData(
      step: BootstrapSteps.values[stepIndex],
    );
  }
}

/// Data model for BootstrapFailed route
@freezed
class BootstrapFailedRouteData
    with _$BootstrapFailedRouteData
    implements CompassRouteDataQuery {
  const factory BootstrapFailedRouteData({
    /// Bootstrap step that failed
    required BootstrapSteps step,
  }) = _BootstrapFailedRouteData;

  const BootstrapFailedRouteData._();

  @override
  Map<String, String> toQueryParams() {
    return {
      bootstrapFailedStepQueryParam: step.index.toString(),
    };
  }
}
