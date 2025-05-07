import 'dart:async';

import 'package:app/app/router/compass/compass.dart';
import 'package:app/app/service/service.dart';
import 'package:app/feature/error/error.dart';
import 'package:app/feature/onboarding/route.dart';
import 'package:collection/collection.dart';
import 'package:flutter/widgets.dart';
import 'package:get_it/get_it.dart';
import 'package:go_router/go_router.dart';
import 'package:injectable/injectable.dart';
import 'package:logging/logging.dart';

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
  ///
  /// This is created by [_createRouter] and handles all navigation.
  late final router = _createRouter();

  /// List of navigation guards sorted by priority.
  ///
  /// Guards can intercept navigation requests and redirect as needed.
  late final _interceptors =
      GetIt.I.getAll<CompassGuard>().toList().sortedBy<num>(
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

        return MapEntry(it.path, it);
      },
    ).nonNulls,
  );

  /// Returns the current active routes in the navigation stack.
  ///
  /// This is determined by parsing the current URI configuration.
  Iterable<CompassBaseGoRoute> get currentRoutes => _locationByUri(
        router.routerDelegate.currentConfiguration.uri,
      );

  /// Navigates to a route specified by route data using replace approach.
  ///
  /// This method replaces the current page with the target page without
  /// adding to the navigation stack.
  /// It's similar to Go Router's `go` method.
  ///
  /// [data] The route data containing information needed for navigation.
  ///
  /// Throws [StateError] if no route is found for the provided data type.
  void compassPoint<T extends CompassRouteData>(T data) {
    final route = _findRouteForData<T>();
    if (route == null) throw StateError('No route for data by type $T');

    router.go(route.toLocation(data).toString());
  }

  /// Navigates to a route specified by route data by pushing to the stack.
  ///
  /// This method adds the target page to the navigation stack, allowing
  /// users to go back to the previous page.
  /// It's similar to Go Router's `push` method.
  ///
  /// [data] The route data containing information needed for navigation.
  ///
  /// Returns a Future that completes with a value
  /// when the pushed route is popped
  /// and the value is passed to [Navigator.pop].
  ///
  /// Throws [StateError] if no route is found for the provided data type.
  Future<R?> compassPush<T extends CompassRouteData, R>(T data) {
    final route = _findRouteForData<T>();
    if (route == null) throw StateError('No route for data by type $T');

    return router.push(route.toLocation(data).toString());
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
  void compassContinue<T extends CompassRouteData>(T data) {
    final route = _findRouteForData<T>();
    if (route == null) throw StateError('No route for data by type $T');

    final originalLocation = router.state.uri;
    final newLocation = route.toLocation(data);

    final concatedUri = newLocation.replace(
      pathSegments: [
        '.', // Use relative path to maintain current path context
        ...newLocation.pathSegments,
      ],
      queryParameters: {
        ...originalLocation.queryParameters, // Preserve original parameters
        ...newLocation
            .queryParameters, // Add new parameters (overrides duplicates)
      },
    );

    router.go(concatedUri.toString());
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
      if (route is CompassRouteDataQueryMixin) {
        final currentUri = router.state.uri;
        final clearedQueries = route.clearScreenQueries(
          currentUri.queryParameters,
        );

        router.go(
          currentUri.replace(queryParameters: clearedQueries).toString(),
        );
      }

      if (router.canPop()) {
        router.pop();
      }
    } catch (e, s) {
      _log.warning('Failed to pop', e, s);
    }
  }

  void dispose() {
    // Detach all interceptors
    for (final interceptor in _interceptors) {
      interceptor.detach();
    }

    router.dispose();
  }

  GoRouter _createRouter() {
    final initalRoute = _routsByType.values.firstWhere((it) => it.isInitial);

    final topLevelRoutes = _routs.where((it) => it.isTopLevel).toList();

    final router = GoRouter(
      restorationScopeId: 'app',
      navigatorKey: navigatorKey,
      redirect: (context, state) {
        if (!_bootstrapService.isConfigured) {
          return null;
        }

        // Process redirects through all interceptors in order
        // Return the first non-null redirect found
        final location = _locationByUri(state.uri).toList();

        for (final interceptor in _interceptors) {
          final redirectData = interceptor.protect(context, location);
          if (redirectData != null) {
            if (redirectData is UnsafeRedirectCompassRouteData) {
              return redirectData.route;
            } else {
              final route = _routsByType[redirectData.runtimeType];
              if (route != null) {
                return route.toLocation(redirectData).toString();
              }
            }
          }
        }

        // No redirection needed
        return null;
      },
      initialLocation: initalRoute.path,
      routes: topLevelRoutes.map((it) => it.route).toList(),
      errorBuilder: (context, state) {
        // Something went wrong, clear saved subroutes
        _log.severe('GoRouter error: ${state.error}');

        final isOnboarding = currentRoutes.lastOrNull is OnBoardingRoute;

        return ErrorPage(isOnboarding: isOnboarding);
      },
    );

    // Attach interceptors to the router
    unawaited(
      Future.microtask(() {
        for (final interceptor in _interceptors) {
          interceptor.attachToRouter(this);
        }
      }),
    );

    return router;
  }

  CompassBaseGoRoute<T>? _findRouteForData<T extends CompassRouteData>() {
    final route = _routsByType[T];
    if (route == null) return null;

    return route as CompassBaseGoRoute<T>;
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
    return router != oldWidget.router;
  }
}

/// Extension on BuildContext that provides convenient access to CompassRouter
/// navigation methods.
///
/// These methods allow for direct navigation from any widget that has access
/// to a BuildContext, without needing to manually retrieve the router instance.
extension CompassNavigationContextExtension on BuildContext {
  /// Navigates to a route specified by route data using replace approach.
  ///
  /// [data] The route data containing information needed for navigation.
  ///
  /// See [CompassRouter.compassPoint] for more details.
  void compassPoint<T extends CompassRouteData>(T data) {
    return CompassRouterProvider.of(this).compassPoint(data);
  }

  /// Navigates to a route specified by route data by pushing to the stack.
  ///
  /// [data] The route data containing information needed for navigation.
  ///
  /// Returns a Future that completes when the pushed route is popped.
  ///
  /// See [CompassRouter.compassPush] for more details.
  Future<R?> compassPush<T extends CompassRouteData, R>(T data) {
    return CompassRouterProvider.of(this).compassPush(data);
  }

  /// Navigates to a route while preserving the current location's path
  /// and query parameters.
  ///
  /// [data] The route data containing information needed for navigation.
  ///
  /// See [CompassRouter.compassContinue] for more details.
  void compassContinue<T extends CompassRouteData>(T data) {
    return CompassRouterProvider.of(this).compassContinue(data);
  }

  /// Navigates back to the previous route in the navigation stack.
  ///
  /// [result] Optional value to return to the previous screen.
  ///
  /// See [CompassRouter.compassBack] for more details.
  void compassBack<T extends Object?>([T? result]) {
    return CompassRouterProvider.of(this).compassBack(result);
  }
}
