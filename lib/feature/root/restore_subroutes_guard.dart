import 'dart:async';

import 'package:app/app/router/compass/compass.dart';
import 'package:app/app/router/router.dart';
import 'package:app/app/service/bootstrap/bootstrap_service.dart';
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
    this._bootstrapService,
  ) : super(priority: priorityMedium);

  final NavigationService _navigationService;
  final BootstrapService _bootstrapService;
  final _log = Logger('RestoreSubroutesGuard');

  // Last saved root app route
  CompassBaseRoute? _lastRootRoute;

  // Saved subroutes for each root app route
  final _savedSubroutes = <CompassBaseRoute, String>{};

  StreamSubscription<Iterable<CompassBaseGoRoute>>? _routeUpdatesSubscription;

  CompassRouter? _router;

  @override
  void attachToRouter(CompassRouter router) {
    _router = router;
    _routeUpdatesSubscription = router.currentRoutesStream.listen(
      _updateLocation,
    );
  }

  @override
  void detach() {
    _savedSubroutes.clear();
    _routeUpdatesSubscription?.cancel();
    _lastRootRoute = null;
    _router = null;
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

  void _updateLocation(
    Iterable<CompassBaseGoRoute> currentRoutes,
  ) {
    if (currentRoutes.isEmpty) return;

    final location = _router?.currentUri.toString();
    if (location == null) return;

    final isSaveLocation = currentRoutes.every((it) => it.isSaveLocation);
    final rootRoute = currentRoutes.firstOrNull;

    _log.info('$currentRoutes -> isSaveLocation: $isSaveLocation');
    if (isSaveLocation && _bootstrapService.isConfigured) {
      /// Ensures that the application's bootstrap sequence has fully completed
      /// before proceeding. It guarantees that EncryptedStorage is ready.
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
