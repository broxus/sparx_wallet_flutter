import 'dart:async';

import 'package:app/app/router/compass/compass.dart';
import 'package:app/app/service/bootstrap/bootstrap_service.dart';
import 'package:app/feature/error/error.dart';
import 'package:app/feature/onboarding/route.dart';
import 'package:app/utils/common_utils.dart';
import 'package:collection/collection.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/widgets.dart';
import 'package:get_it/get_it.dart';
import 'package:go_router/go_router.dart';
import 'package:injectable/injectable.dart';
import 'package:logging/logging.dart';
import 'package:sentry_flutter/sentry_flutter.dart';

/// Router implementation based on Compass navigation system.
///
/// The base navigation abstraction in [CompassRouter] is [CompassBaseRoute],
/// which can be either a [CompassRoute]/[CompassRouteParameterless])
/// or a [CompassShellRoute].
///
/// [CompassRoute]'s compose into the final URI structure. Each [CompassRoute]
/// take one path parameter of uri ((!) they aren't parametrized through path).
/// Composition of [CompassRoute] represents in the [currentRoutes] field.
///
/// [CompassShellRoute] are used to create nested navigation structures, such as
/// bottom navigation bars or side drawers, without affecting the URL structure.
///
/// This design ensures:
/// - Routes can be properly composed and navigated
/// - State can be preserved through query parameters
/// - Navigation is predictable and maintainable
@singleton
class CompassRouter {
  CompassRouter(
    this._bootstrapService,
  );

  final BootstrapService _bootstrapService;

  final _log = Logger('RouterHelper');

  /// Global navigator key used by the GoRouter instance.
  ///
  /// Can be used to access the navigator state from anywhere in the app.
  // ignore: avoid-global-state
  static GlobalKey<NavigatorState> navigatorKey = GlobalKey<NavigatorState>();

  /// The main GoRouter instance for the application.
  late final _router = _createRouter();

  /// List of navigation guards sorted by priority.
  ///
  /// Guards can intercept navigation requests and redirect as needed.
  late final _guards = GetIt.I.getAll<CompassGuard>().toList().sortedBy<num>(
        (it) => -it.priority,
      );

  late final _routs = GetIt.I.getAll<CompassBaseRoute>();

  /// Map of route data types to their corresponding route definitions.
  ///
  /// Only includes GoRoutes, not ShellRoutes.
  late final _routsByType = Map.fromEntries(
    _routs.map(
      (it) {
        if (it is! CompassBaseGoRoute) return null;

        return MapEntry(it.routeDataType, it);
      },
    ).nonNulls,
  );

  /// Map of path strings to their corresponding route definitions.
  ///
  /// Only includes GoRoutes, not ShellRoutes.
  late final _routsByPaths = Map.fromEntries(
    _routs.map(
      (it) {
        if (it is! CompassBaseGoRoute) return null;

        return MapEntry(
          it.pathWithoutLeadingSlash,
          it,
        );
      },
    ).nonNulls,
  );

  /// The main GoRouter instance for the application.
  @Deprecated('Should be used only in MaterialApp.router')
  GoRouter get router => _router;

  /// Returns the current [Uri] of the navigation stack.
  Uri get currentUri {
    // Manual check needed because state call currentConfiguration.last
    // that could throw BadStateException
    if (_router.routerDelegate.currentConfiguration.lastOrNull == null) {
      return Uri();
    }
    return _router.state.uri;
  }

  /// Returns the current active routes in the navigation stack.
  ///
  /// This is determined by parsing the current URI configuration.
  Iterable<CompassBaseGoRoute> get currentRoutes => _currentRoutesSubject.value;

  /// Returns the stream with current active routes in the navigation stack.
  late final _currentRoutesSubject = _router.routerDelegate.asBehaviourSubject(
    () => _locationByUri(currentUri),
    sync: true, // prevent inconsistencies in RestoreSubroutesGuard
  );

  Stream<Iterable<CompassBaseGoRoute>> get currentRoutesStream =>
      _currentRoutesSubject.stream;

  /// Navigates to a route specified by route data using replace approach.
  ///
  /// This method replaces the current page with the target page without
  /// adding to the navigation stack.
  /// It's similar to Go Router's `go` method.
  ///
  /// [data] The route data containing information needed for navigation.
  ///
  /// Throws [StateError] if no route is found for the provided data type.
  void compassPoint(CompassRouteData data) {
    final location = _routeDataToLocation(data);

    if (location == null) {
      throw StateError('No route for data by type ${data.runtimeType}');
    }

    _router.go(location.toString());
  }

  /// Navigates to a named route specified by route data using replace approach.
  ///
  /// This method replaces the current page with the target page without
  /// adding to the navigation stack. It leverages Go Router's `goNamed`
  /// method under the hood.
  ///
  /// [data] The route data containing information needed for navigation.
  void compassPointNamed(CompassRouteData data) {
    final route = _findRouteForData(data);

    if (route == null) {
      throw StateError('No route for data by type ${data.runtimeType}');
    }

    final name = route.name;
    if (name == null) {
      throw StateError("Route ${route.runtimeType} doesn't have name");
    }

    final location = route.toLocation(data);

    _router.goNamed(name, queryParameters: location.queryParameters);
  }

  /// Navigates to a route specified by route data by pushing to the stack.
  ///
  /// This method adds the target page to the navigation stack, allowing
  /// users to go back to the previous page.
  /// It's similar to Go Router's `push` method.
  ///
  /// [data] The route data containing information needed for navigation.
  /// [isContinue] When true (default), preserves current location's path
  /// and query parameters using continued location strategy. When false,
  /// uses standard location without preserving current state.
  ///
  /// Returns a Future that completes with a value
  /// when the pushed route is popped
  /// and the value is passed to [Navigator.pop].
  ///
  /// Throws [StateError] if no route is found for the provided data type.
  Future<R?> compassPush<R extends Object?>(
    CompassRouteData data, {
    bool isContinue = true,
  }) {
    final location = isContinue
        ? _routeDataToContinuedLocation(data)
        : _routeDataToLocation(data)?.toString();

    if (location == null) {
      throw StateError('No route for data by type ${data.runtimeType}');
    }

    return _router.push(location);
  }

  /// Navigates to a route while preserving the current location's path
  /// and query parameters.
  ///
  /// This method is useful for maintaining state while navigating between
  /// related screens.
  ///
  /// Technical implementation:
  /// 1. The current path is preserved using the '.' path segment
  /// 2. The new path segments are appended to the relative path
  /// 3. Query parameters from both the original and new location are merged
  ///
  /// [data] The route data containing information needed for navigation.
  ///
  /// Throws [StateError] if no route is found for the provided data type.
  void compassContinue(CompassRouteData data) {
    final continuedLocation = _routeDataToContinuedLocation(data);
    if (continuedLocation == null) {
      throw StateError('No route for data by type ${data.runtimeType}');
    }

    _router.go(continuedLocation);
  }

  /// Navigates back to the previous route in the navigation stack.
  ///
  /// This method first attempts to clear any query parameters from the
  /// current route, then pops the navigation stack if possible.
  ///
  /// [result] Optional value to return to the previous screen.
  void compassBack<T extends Object?>([T? result]) {
    try {
      final route = currentRoutes.lastOrNull;

      if (_router.canPop()) {
        _router.pop(result);
      }

      if (route is CompassRouteDataQueryMixin) {
        final routesAfterPop = currentRoutes.toList();
        final isRouteRemoved = routesAfterPop.none(
          (it) => it.path == route.path,
        );

        if (isRouteRemoved) {
          final currentUri = this.currentUri;
          final clearedQueries = route.clearScreenQueries(
            currentUri.queryParameters,
          );

          _router.go(
            currentUri.replace(queryParameters: clearedQueries).toString(),
          );
        }
      }
    } catch (e, s) {
      _log.warning('Failed to pop', e, s);
    }
  }

  void dispose() {
    // Detach all interceptors
    for (final guard in _guards) {
      guard.detach();
    }

    _router.dispose();
  }

  GoRouter _createRouter() {
    _validateRoutesDataIntersection();

    final initalRoute = _routsByType.values.firstWhere((it) => it.isInitial);
    final topLevelRoutes = _routs.where((it) => it.isTopLevel).toList();

    final router = GoRouter(
      restorationScopeId: 'app',
      navigatorKey: navigatorKey,
      initialLocation: initalRoute.path,
      routes: topLevelRoutes.map((it) => it.route).toList(),
      observers: [SentryNavigatorObserver()],
      redirect: _routerRedirect,
      errorBuilder: _routerErrorBuilder,
    );

    // Attach interceptors to the router
    unawaited(
      Future.microtask(() {
        for (final guard in _guards) {
          guard.attachToRouter(this);
        }
      }),
    );

    return router;
  }

  String? _routerRedirect(BuildContext context, GoRouterState state) {
    if (!_bootstrapService.isConfigured) {
      return null;
    }

    // Process redirects through all interceptors in order
    // Return the first non-null redirect found
    final location = _locationByUri(state.uri).toList();

    for (final guard in _guards) {
      final redirectData = guard.protect(context, location);
      if (redirectData != null) {
        final location = _routeDataToLocation(redirectData);
        if (location != null) {
          return location.toString();
        }
      }
    }

    // No redirection needed
    return null;
  }

  Widget _routerErrorBuilder(BuildContext context, GoRouterState state) {
    // Something went wrong, clear saved subroutes
    _log.severe('GoRouter error: ${state.error}');

    final isOnboarding = currentRoutes.lastOrNull is OnBoardingRoute;

    return ErrorPage(isOnboarding: isOnboarding);
  }

  void _validateRoutesDataIntersection() {
    if (kDebugMode) {
      final compassGoRoutes = _routsByPaths.entries
          .map(
            (entry) => entry.value,
          )
          .toList();

      for (final route1 in compassGoRoutes) {
        for (final route2 in compassGoRoutes) {
          if (route1 != route2 &&
              route1.routeDataType == route2.routeDataType) {
            throw StateError(
              'Duplicate route data type detected: ${route1.routeDataType}. '
              'Routes must have unique data types. '
              'Found in routes: ${route1.runtimeType} '
              'and ${route2.runtimeType}.',
            );
          }
        }
      }
    }
  }

  CompassBaseGoRoute<CompassRouteData>? _findRouteForData(
    CompassRouteData data,
  ) {
    return _routsByType[data.runtimeType];
  }

  Uri? _routeDataToLocation(
    CompassRouteData data,
  ) {
    if (data is UnsafeRedirectCompassRouteData) {
      return Uri.tryParse(data.route);
    } else {
      final route = _findRouteForData(data);
      return route?.toLocation(data);
    }
  }

  String? _routeDataToContinuedLocation(
    CompassRouteData data,
  ) {
    final newLocation = _routeDataToLocation(data);
    if (newLocation == null) {
      return null;
    }

    final concatedUri = newLocation.replace(
      queryParameters: {
        ...currentUri.queryParameters, // Preserve original parameters
        ...newLocation
            .queryParameters, // Add new parameters (overrides duplicates)
      },
    );

    return '.$concatedUri';
  }

  Iterable<CompassBaseGoRoute> _locationByUri(Uri uri) {
    return uri.pathSegments.map((it) => _routsByPaths[it]).nonNulls;
  }
}

/// An InheritedWidget that provides access to the CompassRouter instance
/// throughout the widget tree.
///
/// This provider allows widgets to access the router via BuildContext.
class CompassRouterProvider extends InheritedWidget {
  const CompassRouterProvider({
    required this.router,
    required super.child,
    super.key,
  });

  final CompassRouter router;

  static CompassRouter of(BuildContext context) {
    final provider =
        context.dependOnInheritedWidgetOfExactType<CompassRouterProvider>();
    assert(provider != null, 'No CompassRouterProvider found in context');
    return provider!.router;
  }

  @override
  bool updateShouldNotify(CompassRouterProvider oldWidget) {
    return true;
  }
}

/// Extension on BuildContext that provides convenient access to CompassRouter
/// navigation methods.
///
/// These methods allow for direct navigation from any widget that has access
/// to a BuildContext, without needing to manually retrieve the router instance.
extension CompassNavigationContextExtension on BuildContext {
  /// Returns the CompassRouter instance associated with this context.
  ///
  /// This method provides direct access to the router for advanced use cases.
  CompassRouter _compassRouter() {
    return CompassRouterProvider.of(this);
  }

  /// Returns the current active routes in the navigation stack.
  /// See [CompassRouter.currentRoutes] for more details.
  Iterable<CompassBaseGoRoute> currentRoutes() {
    // This makes currentRoutes dependent on GoRouterStateRegistryScope updates
    // to properly call didChangeDependencies on contexts
    // that depend on currentRoutes
    GoRouterState.of(this);
    return _compassRouter().currentRoutes;
  }

  /// Navigates to a route specified by route data using replace approach.
  ///
  /// [data] The route data containing information needed for navigation.
  ///
  /// See [CompassRouter.compassPoint] for more details.
  void compassPoint(CompassRouteData data) {
    return _compassRouter().compassPoint(data);
  }

  /// Navigates to a named route specified by route data using replace approach.
  ///
  /// [data] The route data containing information needed for navigation.
  ///
  /// See [CompassRouter.compassPointNamed] for more details.
  void compassPointNamed(CompassRouteData data) {
    return _compassRouter().compassPointNamed(data);
  }

  /// Navigates to a route specified by route data by pushing to the stack.
  ///
  /// [data] The route data containing information needed for navigation.
  /// [isContinue] When true (default), preserves current location's path
  /// and query parameters using continued location strategy. When false,
  /// uses standard location without preserving current state.
  ///
  /// Returns a Future that completes when the pushed route is popped.
  ///
  /// See [CompassRouter.compassPush] for more details.
  Future<R?> compassPush<R>(
    CompassRouteData data, {
    bool isContinue = true,
  }) {
    return _compassRouter().compassPush(data, isContinue: isContinue);
  }

  /// Navigates to a route while preserving the current location's path
  /// and query parameters.
  ///
  /// [data] The route data containing information needed for navigation.
  ///
  /// See [CompassRouter.compassContinue] for more details.
  void compassContinue(CompassRouteData data) {
    return _compassRouter().compassContinue(data);
  }

  /// Navigates back to the previous route in the navigation stack.
  ///
  /// [result] Optional value to return to the previous screen.
  ///
  /// See [CompassRouter.compassBack] for more details.
  void compassBack<T extends Object?>([T? result]) {
    return _compassRouter().compassBack(result);
  }
}
