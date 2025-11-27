import 'dart:async';

import 'package:app/feature/browser/data/history_type.dart';
import 'package:app/feature/browser/domain/delegates/browser_anti_phishing_delegate.dart';
import 'package:app/feature/browser/domain/delegates/browser_service_auth_delegate.dart';
import 'package:app/feature/browser/domain/delegates/browser_service_bookmarks_delegate.dart';
import 'package:app/feature/browser/domain/delegates/browser_service_favicon_delegate.dart';
import 'package:app/feature/browser/domain/delegates/browser_service_history_delegate.dart';
import 'package:app/feature/browser/domain/delegates/browser_service_permissions_delegate.dart';
import 'package:app/feature/browser/domain/delegates/browser_service_tabs_delegate.dart';
import 'package:app/feature/ton_connect/ton_connect.dart';
import 'package:app/utils/common_utils.dart';
import 'package:app/utils/url_utils.dart';
import 'package:flutter_inappwebview/flutter_inappwebview.dart';
import 'package:injectable/injectable.dart';
import 'package:nekoton_repository/nekoton_repository.dart';
import 'package:nekoton_webview/nekoton_webview.dart';
import 'package:rxdart/rxdart.dart';

@singleton
class BrowserService {
  BrowserService(
    this._tonConnectService,
    this._nekotonRepository,
    this._authDelegate,
    this._bookmarksDelegate,
    this._faviconDelegate,
    this._historyDelegate,
    this._permissionsDelegate,
    this._tabsDelegate,
    this._antiPhishingDelegate,
  );

  static const searchEngineHost = 'duckduckgo.com';
  static const searchUrl = 'https://$searchEngineHost/?q=';

  final TonConnectService _tonConnectService;
  final NekotonRepository _nekotonRepository;

  final BrowserServiceAuthDelegate _authDelegate;
  final BrowserServiceBookmarksDelegate _bookmarksDelegate;
  final BrowserServiceFaviconDelegate _faviconDelegate;
  final BrowserServiceHistoryDelegate _historyDelegate;
  final BrowserServicePermissionsDelegate _permissionsDelegate;
  final BrowserServiceTabsDelegate _tabsDelegate;
  final BrowserAntiPhishingDelegate _antiPhishingDelegate;

  final _isContentInteractedStream = BehaviorSubject.seeded(false);

  BrowserServiceAuth get auth => _authDelegate;

  BrowserServiceBookmarks get book => _bookmarksDelegate;

  BrowserServiceFavicon get fav => _faviconDelegate;

  BrowserServiceHistory get hist => _historyDelegate;

  BrowserServicePermissions get perm => _permissionsDelegate;

  BrowserServiceTabs get tab => _tabsDelegate;

  BrowserAntiPhishing get antiPhishing => _antiPhishingDelegate;

  ValueStream<bool> get isContentInteractedStream => _isContentInteractedStream;

  Future<void> init() async {
    _bookmarksDelegate.init();
    _permissionsDelegate.init();
    _tabsDelegate.init();
    await _antiPhishingDelegate.init();
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
    _antiPhishingDelegate.dispose();
  }

  void createTabBookMark(String tabId) {
    final item = _tabsDelegate.getTabById(tabId);

    if (item == null || item.url.host.isEmpty) {
      return;
    }

    _bookmarksDelegate.createBrowserBookmark(item.url, item.title);
  }

  Future<void> permissionsChanged(String tabId, PermissionsChangedEvent event) {
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

  Future<void> loadPhishingGuard(String tabId, Uri uri) async {
    final html = await _antiPhishingDelegate.getPhishingGuardHtml(uri);

    return _tabsDelegate.loadData(tabId, html);
  }

  Future<void> requestUrlSafe(String? tabId, String enteredText) async {
    if (tabId == null) {
      return;
    }

    final text = enteredText.trim();

    if (text.isEmpty) {
      return;
    }

    final isUrl = UrlValidator.checkString(text);

    final url = isUrl
        ? Uri.parse(text)
        : Uri.parse('${BrowserService.searchUrl}$text');

    if (isUrl) {
      final isPhishing = antiPhishing.checkIsPhishingUri(url);

      if (isPhishing) {
        await loadPhishingGuard(tabId, url);
        return;
      }
    }

    return tab.requestUrl(tabId, url);
  }

  Future<void> requestUrlActiveTabSafe(String enteredText) async {
    final id = _tabsDelegate.activeTabId;

    if (id == null) {
      return;
    }

    return requestUrlSafe(id, enteredText);
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
}
