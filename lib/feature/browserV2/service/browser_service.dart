import 'package:app/app/service/messenger/service/messenger_service.dart';
import 'package:app/app/service/storage_service/general_storage_service.dart';
import 'package:app/feature/browserV2/managers/bookmarks_manager.dart';
import 'package:app/feature/browserV2/managers/browser_auth_manager.dart';
import 'package:app/feature/browserV2/managers/favicon_manager.dart';
import 'package:app/feature/browserV2/managers/history_manager.dart';
import 'package:app/feature/browserV2/managers/permissions_manager.dart';
import 'package:app/feature/browserV2/managers/tabs/tabs_manager.dart';
import 'package:app/feature/browserV2/service/storages/browser_bookmarks_storage_service.dart';
import 'package:app/feature/browserV2/service/storages/browser_favicon_url_storage_service.dart';
import 'package:app/feature/browserV2/service/storages/browser_history_storage_service.dart';
import 'package:app/feature/browserV2/service/storages/browser_permissions_storage_service.dart';
import 'package:app/feature/browserV2/service/storages/browser_tabs_storage_service.dart';
import 'package:injectable/injectable.dart';

@singleton
class BrowserService {
  BrowserService(
    this._bookmarksStorageService,
    this._browserFaviconURLStorageService,
    this._browserHistoryStorageService,
    this._browserTabsStorageService,
    this._browserPermissionsStorageService,
    this._messengerService,
    this._generalStorageService,
  );

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
  }

  void openNewTab() {
    // TODO
  }

  void createCurrentTabBookMark() {
    final activeTab = tM.activeTab;
    if (activeTab == null || activeTab.url.host.isEmpty) {
      return;
    }

    bM.createBrowserBookmark(activeTab.url, activeTab.title);
  }
}
