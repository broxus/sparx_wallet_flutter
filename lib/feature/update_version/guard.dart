import 'dart:async';
import 'package:app/app/router/compass/compass.dart';
import 'package:app/app/router/router.dart';
import 'package:app/bootstrap/sentry.dart';
import 'package:app/feature/update_version/route.dart';
import 'package:app/feature/update_version/update_version.dart';
import 'package:app/feature/wallet/route.dart';
import 'package:app/utils/utils.dart';
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

  static const _minimumDelaySeconds = 60;

  final UpdateService _updateService;
  final _log = Logger('UpdateVersionGuard');

  StreamSubscription<(UpdateRequest?, CompassBaseGoRoute?)>?
      _updateVersionSubscription;
  CompassRouter? _router;
  int? _warningLastTimeSecs;

  @override
  void attachToRouter(CompassRouter router) {
    _router = router;

    _updateVersionSubscription = Rx.combineLatest2(
      _updateService.updateRequests,
      router.currentRoutesStream,
      (request, route) => (request, route.lastOrNull),
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

  Future<void> _onUpdateRequests(
    (UpdateRequest?, CompassBaseGoRoute?) requestRoute,
  ) async {
    final (request, currentRoute) = requestRoute;
    if (request == null) return;
    if (currentRoute is! WalletRoute) return;

    _log.info('Open update version screen $currentRoute, $request');

    if (!_checkMinimumDelayBetweenShow()) {
      return;
    }

    await _router?.compassPush(
      const UpdateVersionRouteData(),
      isContinue: false,
    );
  }

  // Normally this check isn’t required, but if a bug causes
  // `UpdateVersionRouteData()` to fire twice, it can lead to a jarring user
  // experience. This method enforces a minimum delay between shows.
  bool _checkMinimumDelayBetweenShow() {
    final nowSecs = NtpTime.now().millisecondsSinceEpoch ~/ 1000;

    final warningLastTimeSecs = _warningLastTimeSecs;
    if (warningLastTimeSecs != null) {
      final elapsedSecs = nowSecs - warningLastTimeSecs;

      if (elapsedSecs < _minimumDelaySeconds) {
        _log.info(
          'Not enough time between request show: '
          '$elapsedSecs < $_minimumDelaySeconds',
        );
        SentryWorker.instance.captureException(
          StateError('Update screen tries show twice'),
        );
        return false;
      }
    }

    _warningLastTimeSecs = nowSecs;

    return true;
  }
}
