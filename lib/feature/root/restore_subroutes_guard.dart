import 'package:app/app/router/compass/compass.dart';
import 'package:app/app/router/router.dart';
import 'package:app/app/service/navigation_service.dart';
import 'package:flutter/material.dart';
import 'package:injectable/injectable.dart';
import 'package:logging/logging.dart';

/// Interceptor that restores subroutes when navigating between root app routes.
@named
@Singleton(as: CompassGuard)
class RestoreSubroutesGuard extends CompassGuard {
  RestoreSubroutesGuard(
    this._navigationService,
    this._compassRouter,
  ) : super(priority: priorityMedium);

  final NavigationService _navigationService;
  final CompassRouter _compassRouter;
  final _log = Logger('RestoreSubroutesGuard');

  CompassRouter? _router;

  // Last saved root app route
  CompassBaseRoute? _lastRootRoute;

  // Just for debouncing, because setLocation() can be called multiple times
  // with the same location
  String? _lastSetlocation;

  // Saved subroutes for each root app route
  final _savedSubroutes = <CompassBaseRoute, String>{};

  @override
  void attachToRouter(CompassRouter router) {
    _router = router;
    router.router.routerDelegate.addListener(_routeUpdated);
  }

  @override
  void detach() {
    _savedSubroutes.clear();
    _router?.router.routerDelegate.removeListener(_routeUpdated);
    _router = null;
    _lastRootRoute = null;
    _lastSetlocation = null;
  }

  @override
  CompassRouteData? protect(
    BuildContext? context,
    List<CompassBaseGoRoute> location,
  ) {
    final rootRoute = location.firstOrNull;
    if (rootRoute == null) return null;

    // Get saved subroute for the root app route (if any)
    final savedSubroute = _savedSubroutes[rootRoute];

    // Check if the root app route changed
    final isRootRouteChanged = _lastRootRoute != rootRoute;

    // If the root app route changed and there is a saved subroute,
    // return it
    // This is for the case when the user navigates to a subroute, then
    // navigates to another root app route and returns back to the previous
    // root app route using bottom tab bar. In this case, the subroute
    // should be restored.
    // Skip subroute restoration if navigated directly to subroute.
    if (isRootRouteChanged && location.length == 1 && savedSubroute != null) {
      _log.info('Restoring subroute: $savedSubroute');
      return UnsafeRedirectCompassRouteData(route: savedSubroute);
    }

    // Nothing to do, return null
    return null;
  }

  void _routeUpdated() {
    final router = _router;
    if (router == null) return;
    final currentConfiguration =
        router.router.routerDelegate.currentConfiguration;

    _updateLocation(
      currentConfiguration.uri.toString(),
      currentConfiguration.fullPath,
    );
  }

  void _updateLocation(String location, String fullPath) {
    // And because of that, we need to check if the location is the same
    // as the last one to avoid duplicate calls of NavigationService.setLocation
    if (_lastSetlocation == location) {
      return;
    }

    _lastSetlocation = location;

    final currentRoutes = _compassRouter.currentRoutes.toList();

    if (currentRoutes.isEmpty) return;

    final isSaveLocation = currentRoutes.every((it) => it.isSaveLocation);
    final rootRoute = currentRoutes.firstOrNull;

    _log.info('$currentRoutes -> isSaveLocation: $isSaveLocation');
    if (isSaveLocation) {
      _navigationService.saveLastLocation(location);
    }

    if (rootRoute == null) return;

    // Save subroute for the root app route
    if (rootRoute.isSaveSubroutes) {
      _savedSubroutes[rootRoute] = location;
    }

    // Save last root app route
    _lastRootRoute = rootRoute;
  }
}
