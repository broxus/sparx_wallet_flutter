import 'dart:async';

import 'package:app/app/router/router.dart';
import 'package:app/app/service/app_links/app_links.dart';
import 'package:app/app/service/ton_connect/ton_connect_service.dart';
import 'package:app/feature/browser_v2/data/history_type.dart';
import 'package:app/feature/browser_v2/domain/delegates/browser_service_auth_delegate.dart';
import 'package:app/feature/browser_v2/domain/delegates/browser_service_bookmarks_delegate.dart';
import 'package:app/feature/browser_v2/domain/delegates/browser_service_favicon_delegate.dart';
import 'package:app/feature/browser_v2/domain/delegates/browser_service_history_delegate.dart';
import 'package:app/feature/browser_v2/domain/delegates/browser_service_permissions_delegate.dart';
import 'package:app/feature/browser_v2/domain/delegates/browser_service_tabs_delegate.dart';
import 'package:app/feature/browser_v2/screens/main/route.dart';
import 'package:app/utils/common_utils.dart';
import 'package:flutter/material.dart';
import 'package:flutter_inappwebview/flutter_inappwebview.dart';
import 'package:injectable/injectable.dart';
import 'package:nekoton_repository/nekoton_repository.dart';
import 'package:nekoton_webview/nekoton_webview.dart';
import 'package:rxdart/rxdart.dart';

@singleton
class BrowserService {
  BrowserService(
    this._appLinksService,
    this._tonConnectService,
    this._nekotonRepository,
    this._compassRouter,
    this._authDelegate,
    this._bookmarksDelegate,
    this._faviconDelegate,
    this._historyDelegate,
    this._permissionsDelegate,
    this._tabsDelegate,
  );

  final AppLinksService _appLinksService;
  final TonConnectService _tonConnectService;
  final NekotonRepository _nekotonRepository;
  final CompassRouter _compassRouter;

  final BrowserServiceAuthDelegate _authDelegate;
  final BrowserServiceBookmarksDelegate _bookmarksDelegate;
  final BrowserServiceFaviconDelegate _faviconDelegate;
  final BrowserServiceHistoryDelegate _historyDelegate;
  final BrowserServicePermissionsDelegate _permissionsDelegate;
  final BrowserServiceTabsDelegate _tabsDelegate;

  final _isContentInteractedStream = BehaviorSubject.seeded(false);

  StreamSubscription<BrowserAppLinksData>? _appLinksNavSubs;

  BrowserServiceAuth get auth => _authDelegate;

  BrowserServiceBookmarks get book => _bookmarksDelegate;

  BrowserServiceFavicon get fav => _faviconDelegate;

  BrowserServiceHistory get hist => _historyDelegate;

  BrowserServicePermissions get perm => _permissionsDelegate;

  BrowserServiceTabs get tab => _tabsDelegate;

  ValueStream<bool> get isContentInteractedStream => _isContentInteractedStream;

  void init() {
    _bookmarksDelegate.init();
    _historyDelegate.init();
    _permissionsDelegate.init();
    _tabsDelegate.init();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      _appLinksNavSubs =
          _appLinksService.browserLinksStream.listen(_listenAppLinks);
    });
  }

  Future<void> clear() async {
    await _bookmarksDelegate.clear();
    await _historyDelegate.clear();
    await _permissionsDelegate.clear();
    await _tabsDelegate.clear();
  }

  @disposeMethod
  void dispose() {
    _tabsDelegate.dispose();
    _appLinksNavSubs?.cancel();
  }

  void openUrl(Uri uri) {
    if (_compassRouter.currentRoutes.lastOrNull is! BrowserRoute) {
      _compassRouter.compassPointNamed(const BrowserRouteData());
    }
    _tabsDelegate.openUrl(uri);
  }

  void createTabBookMark(String tabId) {
    final item = _tabsDelegate.getTabById(tabId);

    if (item == null || item.url.host.isEmpty) {
      return;
    }

    _bookmarksDelegate.createBrowserBookmark(item.url, item.title);
  }

  Future<void> permissionsChanged(
    String tabId,
    PermissionsChangedEvent event,
  ) {
    return _tabsDelegate.permissionsChanged(tabId, event);
  }

  void clearData(TimePeriod period, Set<TypeHistory> targets) {
    for (final target in targets) {
      switch (target) {
        case TypeHistory.browsingHistory:
          _historyDelegate.clearHistory(period);
        case TypeHistory.cookie:
          _clearCookieAndData();
        case TypeHistory.cachedImages:
          _tabsDelegate.clearCachedFiles();
      }
    }
  }

  void updateInteractedState({required bool isInteracted}) {
    _isContentInteractedStream.add(isInteracted);
  }

  Future<bool> _clearCookie() async {
    return CookieManager.instance().deleteAllCookies();
  }

  Future<void> _clearCookieAndData() async {
    await tryWrapper(_clearCookie);
    await tryWrapper(_permissionsDelegate.clearPermissions);

    final ids = _tabsDelegate.allTabsIds;

    await tryWrapper(() async => _tonConnectService.disconnectAllInBrowser());
    await tryWrapper(() async => _nekotonRepository.unsubscribeAllContracts());

    await tryWrapper(() async {
      for (final id in ids) {
        await permissionsChanged(
          id,
          const PermissionsChangedEvent(PermissionsPartial(null, null)),
        );
      }
    });
  }

  void _listenAppLinks(BrowserAppLinksData event) {
    _tabsDelegate.openUrl(event.url);
  }
}
