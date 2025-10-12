import 'dart:async';

import 'package:app/app/router/compass/compass.dart';
import 'package:app/app/router/router.dart';
import 'package:app/feature/browser_v2/domain/browser_launcher.dart';
import 'package:app/feature/wallet/route.dart';
import 'package:injectable/injectable.dart';
import 'package:logging/logging.dart';

/// Service that stores deep links received during onboarding
/// and automatically processes them when WalletRoute becomes active.
@singleton
class PendingDeepLinkService {
  PendingDeepLinkService(
    this._browserLauncher,
  );

  final BrowserLauncher _browserLauncher;
  final _log = Logger('PendingDeepLinkService');

  /// Queue of pending deep links to be processed
  final List<Uri> _pendingLinks = [];

  StreamSubscription<Iterable<CompassBaseGoRoute>>? _routeSubscription;

  /// Add a deep link to the pending queue
  void addPendingLink(Uri link) {
    _log.info('Adding pending deep link: $link');
    _pendingLinks.add(link);
  }

  /// Attach to router and start listening for navigation changes
  void attachToRouter(CompassRouter router) {
    _routeSubscription = router.currentRoutesStream.listen(_listenRouteChanges);
  }

  /// Listen to route changes and process pending links when WalletRoute
  /// is active
  void _listenRouteChanges(Iterable<CompassBaseGoRoute> routes) {
    final rootRoute = routes.firstOrNull;

    // Check if we're on WalletRoute and have pending links
    if (rootRoute is WalletRoute && _pendingLinks.isNotEmpty) {
      final pendingLink = _pendingLinks.removeAt(0);
      _log.info('Processing pending deep link: $pendingLink');

      // Open browser with the pending link
      _browserLauncher.openBrowserByUri(pendingLink);
    }
  }

  @disposeMethod
  void dispose() {
    _routeSubscription?.cancel();
    _pendingLinks.clear();
  }
}
