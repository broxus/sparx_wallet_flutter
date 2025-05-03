import 'package:app/app/router/compass/data_from_query.dart';
import 'package:app/app/router/compass/go_route.dart';
import 'package:app/app/router/compass/route.dart';
import 'package:app/app/router/compass/shell_route.dart';
import 'package:go_router/go_router.dart';

export 'data_from_query.dart';
export 'go_route.dart';
export 'guard.dart';
export 'route.dart';

/// Route implementation for screens with query parameters.
///
/// Use this for routes that require data to be passed via query parameters.
abstract class CompassRoute<T extends CompassRouteDataQuery>
    extends CompassBaseGoRoute<T> with CompassRouteDataQueryMixin<T> {
  CompassRoute({
    required super.name,
    this.compassBaseRoutes = const [],
    super.builder,
    super.pageBuilder,
    super.isInitial,
    super.isTopLevel,
    super.isSaveLocation,
    super.isSaveSubroutes,
    super.redirect,
    super.parentNavigatorKey,
    super.path,
  }) : super(
          routes: compassBaseRoutes.map((it) => it.route).toList(),
        );

  /// Child routes that will be nested under this route.
  ///
  /// These are automatically converted to GoRouter routes in the constructor.
  final List<CompassBaseRoute> compassBaseRoutes;
}

/// Route implementation for screens without query parameters.
///
/// This class extends [CompassBaseGoRoute] and incorporates the
/// [EmptyRouteDataMixin] to handle parameterless navigation.
/// Use this for routes that don't require any data to be passed.
abstract class CompassRouteParameterless<T extends CompassRouteData>
    extends CompassBaseGoRoute<T> with EmptyRouteDataMixin<T> {
  CompassRouteParameterless({
    required super.name,
    this.compassBaseRoutes = const [],
    super.builder,
    super.pageBuilder,
    super.isInitial,
    super.isTopLevel,
    super.isSaveLocation,
    super.isSaveSubroutes,
    super.redirect,
    super.parentNavigatorKey,
    super.path,
  }) : super(
          routes: compassBaseRoutes.map((it) => it.route).toList(),
        );

  /// Child routes that will be nested under this route.
  ///
  /// These are automatically converted to GoRouter routes in the constructor.
  final List<CompassBaseRoute> compassBaseRoutes;
}

/// Route implementation for shell routes (tabbed navigation).
///
/// This class extends [CompassBaseStatefulShellRoute] to create a navigation
/// shell with branches, typically used for bottom tab navigation or similar
/// interfaces where multiple navigation stacks exist simultaneously.
abstract class CompassShellRoute extends CompassBaseStatefulShellRoute {
  CompassShellRoute({
    this.compassBaseRoutes = const [],
    super.isTopLevel,
    super.name,
    super.parentNavigatorKey,
  }) : super(
          branches: compassBaseRoutes
              .map(
                (it) => StatefulShellBranch(
                  routes: [it.route],
                ),
              )
              .toList(),
        );

  /// Branch routes that will be part of this shell.
  ///
  /// Each route becomes a separate branch in the StatefulShellRoute,
  /// allowing for independent navigation stacks within the shell.
  final List<CompassBaseRoute> compassBaseRoutes;
}

