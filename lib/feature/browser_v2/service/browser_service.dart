import 'dart:async';

import 'package:app/app/service/app_links/app_links.dart';
import 'package:app/app/service/messenger/service/messenger_service.dart';
import 'package:app/app/service/storage_service/general_storage_service.dart';
import 'package:app/feature/browser_v2/data/history_type.dart';
import 'package:app/feature/browser_v2/managers/bookmarks_manager.dart';
import 'package:app/feature/browser_v2/managers/browser_auth_manager.dart';
import 'package:app/feature/browser_v2/managers/favicon_manager.dart';
import 'package:app/feature/browser_v2/managers/history_manager.dart';
import 'package:app/feature/browser_v2/managers/permissions_manager.dart';
import 'package:app/feature/browser_v2/managers/tabs/tabs_manager.dart';
import 'package:app/feature/browser_v2/service/storages/browser_bookmarks_storage_service.dart';
import 'package:app/feature/browser_v2/service/storages/browser_favicon_url_storage_service.dart';
import 'package:app/feature/browser_v2/service/storages/browser_history_storage_service.dart';
import 'package:app/feature/browser_v2/service/storages/browser_permissions_storage_service.dart';
import 'package:app/feature/browser_v2/service/storages/browser_tabs_storage_service.dart';
import 'package:flutter/material.dart';
import 'package:flutter_inappwebview/flutter_inappwebview.dart';
import 'package:injectable/injectable.dart';

@singleton
class BrowserService {
  BrowserService(
    this._appLinksService,
    this._bookmarksStorageService,
    this._browserFaviconURLStorageService,
    this._browserHistoryStorageService,
    this._browserTabsStorageService,
    this._browserPermissionsStorageService,
    this._messengerService,
    this._generalStorageService,
  );

  final AppLinksService _appLinksService;
  final BrowserBookmarksStorageService _bookmarksStorageService;
  final BrowserFaviconURLStorageService _browserFaviconURLStorageService;
  final BrowserHistoryStorageService _browserHistoryStorageService;
  final BrowserTabsStorageService _browserTabsStorageService;
  final BrowserPermissionsStorageService _browserPermissionsStorageService;
  final GeneralStorageService _generalStorageService;

  final MessengerService _messengerService;

  late final bookmarks = BookmarksManager(
    _bookmarksStorageService,
    _messengerService,
  );
  late final favicon = FaviconManager(_browserFaviconURLStorageService);
  late final history = HistoryManager(_browserHistoryStorageService);
  late final tabs = BrowserTabsManager(
    _browserTabsStorageService,
    _generalStorageService,
  );
  late final permissions = PermissionsManager(
    _browserPermissionsStorageService,
  );

  final auth = BrowserAuthManager();

  StreamSubscription<BrowserAppLinksData>? _appLinksNavSubs;

  BookmarksManager get bM => bookmarks;

  FaviconManager get fM => favicon;

  HistoryManager get hM => history;

  BrowserTabsManager get tM => tabs;

  PermissionsManager get pM => permissions;

  BrowserAuthManager get aM => auth;

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
    favicon.dispose();
    tabs.dispose();
    _appLinksNavSubs?.cancel();
  }

  void openUrl(Uri uri) {
    tM.createBrowserTab(uri);
  }

  void openStringUrl(String url) {
    return openUrl(WebUri(url));
  }

  void createTabBookMark(String tabId) {
    final tab = tM.getTabById(tabId);

    if (tab == null || tab.url.host.isEmpty) {
      return;
    }

    bM.createBrowserBookmark(tab.url, tab.title);
  }

  void clearData(TimePeriod period, Set<TypeHistory> targets) {
    for (final target in targets) {
      switch (target) {
        case TypeHistory.browsingHistory:
          hM.clearHistory(period);
        case TypeHistory.cookie:
          tM.clearCookie();
        case TypeHistory.cachedImages:
          tM.clearCachedFiles();
      }
    }
  }

  void _listenAppLinks(BrowserAppLinksData event) {
    openUrl(event.url);
  }
}
