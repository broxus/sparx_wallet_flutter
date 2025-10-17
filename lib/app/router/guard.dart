import 'dart:async';
import 'package:app/app/router/compass/compass.dart';
import 'package:app/app/router/router.dart';
import 'package:flutter/material.dart';
import 'package:injectable/injectable.dart';
import 'package:logging/logging.dart';

/// Interceptor that redirects to onboarding if the user doesn't have any seeds.
@named
@Singleton(as: CompassGuard)
class LoggingGuard extends CompassGuard {
  LoggingGuard() : super(priority: priorityHigh);

  final _log = Logger('LoggingGuard');

  StreamSubscription<Iterable<CompassBaseGoRoute>>? _logSubscription;
  CompassRouter? _router;

  @override
  void attachToRouter(CompassRouter router) {
    _router = router;

    _logSubscription = router.currentRoutesStream.listen(_logRoute);
  }

  @override
  void detach() {
    _logSubscription?.cancel();
    _router = null;
  }

  @override
  CompassRouteData? protect(
    BuildContext? context,
    List<CompassBaseGoRoute> location,
  ) {
    // This interceptor doesn't do redirects in the router's redirect method
    return null;
  }

  void _logRoute(Iterable<CompassBaseGoRoute> routes) {
    final routesTypes = routes.map((it) => it.runtimeType).toList();
    final currentUri = _router?.currentUri.toString() ?? '';

    _log.fine('Route update: $currentUri - $routesTypes');
  }
}
