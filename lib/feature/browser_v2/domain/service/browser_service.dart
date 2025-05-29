import 'dart:async';

import 'package:app/app/router/router.dart';
import 'package:app/app/service/app_links/app_links.dart';
import 'package:app/app/service/storage_service/general_storage_service.dart';
import 'package:app/app/service/ton_connect/ton_connect_service.dart';
import 'package:app/feature/browser_v2/data/history_type.dart';
import 'package:app/feature/browser_v2/domain/service/storages/browser_bookmarks_storage_service.dart';
import 'package:app/feature/browser_v2/domain/service/storages/browser_favicon_url_storage_service.dart';
import 'package:app/feature/browser_v2/domain/service/storages/browser_groups_storage_service.dart';
import 'package:app/feature/browser_v2/domain/service/storages/browser_history_storage_service.dart';
import 'package:app/feature/browser_v2/domain/service/storages/browser_permissions_storage_service.dart';
import 'package:app/feature/browser_v2/domain/service/storages/browser_tabs_storage_service.dart';
import 'package:app/feature/browser_v2/managers/bookmarks_manager.dart';
import 'package:app/feature/browser_v2/managers/browser_auth_manager.dart';
import 'package:app/feature/browser_v2/managers/favicon_manager.dart';
import 'package:app/feature/browser_v2/managers/history_manager.dart';
import 'package:app/feature/browser_v2/managers/permissions_manager.dart';
import 'package:app/feature/browser_v2/managers/tabs/tabs_manager.dart';
import 'package:app/feature/browser_v2/screens/main/route.dart';
import 'package:app/feature/messenger/domain/service/messenger_service.dart';
import 'package:app/utils/common_utils.dart';
import 'package:flutter/material.dart';
import 'package:injectable/injectable.dart';
import 'package:nekoton_repository/nekoton_repository.dart';
import 'package:nekoton_webview/nekoton_webview.dart';
import 'package:rxdart/rxdart.dart';

@singleton
class BrowserService {
  BrowserService(
    this._appLinksService,
    this._bookmarksStorageService,
    this._browserFaviconURLStorageService,
    this._browserHistoryStorageService,
    this._browserGroupsStorageService,
    this._browserTabsStorageService,
    this._browserPermissionsStorageService,
    this._messengerService,
    this._generalStorageService,
    this._tonConnectService,
    this._nekotonRepository,
    this._compassRouter,
  );

  final AppLinksService _appLinksService;
  final BrowserBookmarksStorageService _bookmarksStorageService;
  final BrowserFaviconURLStorageService _browserFaviconURLStorageService;
  final BrowserHistoryStorageService _browserHistoryStorageService;
  final BrowserGroupsStorageService _browserGroupsStorageService;
  final BrowserTabsStorageService _browserTabsStorageService;
  final BrowserPermissionsStorageService _browserPermissionsStorageService;
  final GeneralStorageService _generalStorageService;
  final TonConnectService _tonConnectService;
  final MessengerService _messengerService;
  final NekotonRepository _nekotonRepository;
  final CompassRouter _compassRouter;

  late final bookmarks = BookmarksManager(
    _bookmarksStorageService,
    _messengerService,
  );
  late final favicon = FaviconManager(_browserFaviconURLStorageService);
  late final history = HistoryManager(_browserHistoryStorageService);
  late final tabs = BrowserTabsManager(
    _browserTabsStorageService,
    _browserGroupsStorageService,
    _generalStorageService,
  );
  late final permissions = PermissionsManager(
    _browserPermissionsStorageService,
  );

  final auth = BrowserAuthManager();

  final _isContentInteractedStream = BehaviorSubject.seeded(false);

  StreamSubscription<BrowserAppLinksData>? _appLinksNavSubs;

  BookmarksManager get bM => bookmarks;

  FaviconManager get fM => favicon;

  HistoryManager get hM => history;

  BrowserTabsManager get tM => tabs;

  PermissionsManager get pM => permissions;

  BrowserAuthManager get aM => auth;

  ValueStream<bool> get isContentInteractedStream => _isContentInteractedStream;

  void init() {
    bookmarks.init();
    history.init();
    tabs.init();
    permissions.init();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      _appLinksNavSubs =
          _appLinksService.browserLinksStream.listen(_listenAppLinks);
    });
  }

  Future<void> clear() async {
    await bookmarks.clear();
    await history.clear();
    await tabs.clear();
    await permissions.clear();
  }

  @disposeMethod
  void dispose() {
    tabs.dispose();
    _appLinksNavSubs?.cancel();
  }

  void openUrl(Uri uri) {
    if (_compassRouter.currentRoutes.lastOrNull is! BrowserRoute) {
      _compassRouter.compassPointNamed(const BrowserRouteData());
    }
    tM.openUrl(uri);
  }

  void createTabBookMark(String tabId) {
    final tab = tM.getTabById(tabId);

    if (tab == null || tab.url.host.isEmpty) {
      return;
    }

    bM.createBrowserBookmark(tab.url, tab.title);
  }

  Future<void> permissionsChanged(
    String tabId,
    PermissionsChangedEvent event,
  ) {
    return tabs.permissionsChanged(tabId, event);
  }

  void clearData(TimePeriod period, Set<TypeHistory> targets) {
    for (final target in targets) {
      switch (target) {
        case TypeHistory.browsingHistory:
          hM.clearHistory(period);
        case TypeHistory.cookie:
          _clearCookieAndData();
        case TypeHistory.cachedImages:
          tM.clearCachedFiles();
      }
    }
  }

  void updateInteractedState({required bool isInteracted}) {
    _isContentInteractedStream.add(isInteracted);
  }

  Future<void> _clearCookieAndData() async {
    await tryWrapper(tM.clearCookie);
    await tryWrapper(permissions.clearPermissions);

    final ids = tabs.allBrowserTabsIds;

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
    tM.openUrl(event.url);
  }
}
