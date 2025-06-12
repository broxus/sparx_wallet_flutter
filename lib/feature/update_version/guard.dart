import 'dart:async';
import 'package:app/app/router/compass/compass.dart';
import 'package:app/app/router/router.dart';
import 'package:app/bootstrap/sentry.dart';
import 'package:app/feature/update_version/route.dart';
import 'package:app/feature/update_version/update_version.dart';
import 'package:app/feature/wallet/route.dart';
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

  @override
  void attachToRouter(CompassRouter router) {
    unawaited(
      Future(
        () async {
          final request =
              await _updateService.updateRequests.whereNotNull().first;

          await router.currentRoutesStream
              .where((it) => it.lastOrNull is WalletRoute)
              .first;

          _log.info('Open update version screen $request');

          await router.compassPush(
            const UpdateVersionRouteData(),
            isContinue: false,
          );
        },
      ).catchError(
        (Object e, StackTrace s) {
          _log.severe('Error during update', e, s);
          SentryWorker.instance.captureException(e, stackTrace: s);
        },
      ),
    );
  }

  @override
  void detach() {}

  @override
  CompassRouteData? protect(
    BuildContext? context,
    List<CompassBaseGoRoute> location,
  ) {
    // This interceptor doesn't do redirects in the router's redirect method
    // Instead, it listens to update requests and pushes routes
    return null;
  }
}
