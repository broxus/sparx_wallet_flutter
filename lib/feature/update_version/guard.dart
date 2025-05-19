import 'dart:async';
import 'package:app/app/router/compass/compass.dart';
import 'package:app/app/router/router.dart';
import 'package:app/feature/update_version/route.dart';
import 'package:app/feature/update_version/update_version.dart';
import 'package:app/feature/wallet/route.dart';
import 'package:app/utils/common_utils.dart';
import 'package:flutter/material.dart';
import 'package:injectable/injectable.dart';
import 'package:logging/logging.dart';
import 'package:rxdart/rxdart.dart';

/// Interceptor that handles update requests and redirects
/// to the update version screen.
@named
@Singleton(as: CompassGuard)
class UpdateVersionGuard extends CompassGuard {
  UpdateVersionGuard(
    this._updateService,
  ) : super(priority: priorityLow);

  final UpdateService _updateService;
  final _log = Logger('UpdateVersionGuard');

  StreamSubscription<(UpdateRequest?, RouteInformation)>?
      _updateVersionSubscription;
  CompassRouter? _router;

  @override
  void attachToRouter(CompassRouter router) {
    _router = router;

    _updateVersionSubscription = Rx.combineLatest2(
      _updateService.updateRequests,
      router.router.routeInformationProvider.asStream(),
      (request, route) => (request, route),
    ).listen(_onUpdateRequests);
  }

  @override
  void detach() {
    _updateVersionSubscription?.cancel();
    _router = null;
  }

  @override
  CompassRouteData? protect(
    BuildContext? context,
    List<CompassBaseGoRoute> location,
  ) {
    // This interceptor doesn't do redirects in the router's redirect method
    // Instead, it listens to update requests and pushes routes
    return null;
  }

  void _onUpdateRequests((UpdateRequest?, RouteInformation) requestRoute) {
    final (request, _) = requestRoute;
    final router = _router;
    if (request == null || router == null) return;
    final currentRoutes = router.currentRoutes.toList();
    final currentRoute = currentRoutes.lastOrNull;
    if (currentRoute is! WalletRoute) return;
    final state = router.router.routeInformationProvider.value.uri;
    _log.info('Open update version screen $state, $currentRoutes, $request');
    _router?.compassPush(
      const UpdateVersionRouteData(),
    );
  }
}
