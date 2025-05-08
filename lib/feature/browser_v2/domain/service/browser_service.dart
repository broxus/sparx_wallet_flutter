import 'dart:async';

import 'package:app/app/service/app_links/app_links.dart';
import 'package:app/app/service/resources_service.dart';
import 'package:app/app/service/storage_service/general_storage_service.dart';
import 'package:app/feature/browser_v2/data/history_type.dart';
import 'package:app/feature/browser_v2/domain/service/storages/browser_bookmarks_storage_service.dart';
import 'package:app/feature/browser_v2/domain/service/storages/browser_favicon_url_storage_service.dart';
import 'package:app/feature/browser_v2/domain/service/storages/browser_history_storage_service.dart';
import 'package:app/feature/browser_v2/domain/service/storages/browser_permissions_storage_service.dart';
import 'package:app/feature/browser_v2/domain/service/storages/browser_tabs_storage_service.dart';
import 'package:app/feature/browser_v2/managers/bookmarks_manager.dart';
import 'package:app/feature/browser_v2/managers/broser_anti_phishing_manager.dart';
import 'package:app/feature/browser_v2/managers/browser_auth_manager.dart';
import 'package:app/feature/browser_v2/managers/favicon_manager.dart';
import 'package:app/feature/browser_v2/managers/history_manager.dart';
import 'package:app/feature/browser_v2/managers/permissions_manager.dart';
import 'package:app/feature/browser_v2/managers/tabs/tabs_manager.dart';
import 'package:app/feature/messenger/domain/service/messenger_service.dart';
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
    this._resourcesService,
  );

  final AppLinksService _appLinksService;
  final BrowserBookmarksStorageService _bookmarksStorageService;
  final BrowserFaviconURLStorageService _browserFaviconURLStorageService;
  final BrowserHistoryStorageService _browserHistoryStorageService;
  final BrowserTabsStorageService _browserTabsStorageService;
  final BrowserPermissionsStorageService _browserPermissionsStorageService;
  final GeneralStorageService _generalStorageService;
  final MessengerService _messengerService;
  final ResourcesService _resourcesService;

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

  late final antiPhishing = BrowserAntiPhishingManager(_resourcesService);

  StreamSubscription<BrowserAppLinksData>? _appLinksNavSubs;

  BookmarksManager get bM => bookmarks;

  FaviconManager get fM => favicon;

  HistoryManager get hM => history;

  BrowserTabsManager get tM => tabs;

  PermissionsManager get pM => permissions;

  BrowserAuthManager get aM => auth;

  Future<void> init() async {
    bookmarks.init();
    history.init();
    tabs.init();
    permissions.init();
    await antiPhishing.init();
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
    antiPhishing.dispose();
  }

  void openUrl(Uri uri) {
    tM.openUrl(uri);
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

  Future<void> loadPhishingGuard(
    String path,
  ) async {
    final html = await antiPhishing.getPhishingGuardHtml(path);
    return tabs.loadDataOnActiveTab(html);
  }

  Future<bool> loadPhishingGuardIfNeed({
    required String path,
    required String host,
  }) async {
    final list = antiPhishing.blackList;

    for (final link in list) {
      if (path != link && host != link) {
        continue;
      }

      unawaited(loadPhishingGuard(path));
      return true;
    }
    return false;
  }

  void _listenAppLinks(BrowserAppLinksData event) {
    openUrl(event.url);
  }
}
