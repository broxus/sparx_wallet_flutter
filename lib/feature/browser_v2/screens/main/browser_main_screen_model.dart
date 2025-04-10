import 'package:app/feature/browser_v2/data/tabs_data.dart';
import 'package:app/feature/browser_v2/data/browser_tab.dart';
import 'package:app/feature/browser_v2/domain/service/browser_service.dart';
import 'package:app/feature/browser_v2/screens/main/browser_main_screen.dart';
import 'package:app/utils/url_utils.dart';
import 'package:elementary/elementary.dart';
import 'package:elementary_helper/elementary_helper.dart';
import 'package:flutter/services.dart';
import 'package:flutter_inappwebview/flutter_inappwebview.dart';

const _searchEngineUri = 'https://duckduckgo.com/?q=';

/// [ElementaryModel] for [BrowserMainScreen]
class BrowserMainScreenModel extends ElementaryModel {
  BrowserMainScreenModel(
    ErrorHandler errorHandler,
    this._browserService,
  ) : super(errorHandler: errorHandler);
  final BrowserService _browserService;

  ListenableState<BrowserTabsCollection> get tabsState =>
      _browserService.tM.tabsState;

  ListenableState<BrowserTab?> get activeTabState =>
      _browserService.tM.activeTabState;

  void setActiveTab(String? id) {
    if (id == null) {
      return;
    }
    _browserService.tM.setActiveTab(id);
  }

  void removeBrowserTab(String id) {
    _browserService.tM.removeBrowserTab(id);
  }

  void clearTabs() => _browserService.tM.clearTabs();

  String createEmptyTab() => _browserService.tM.createEmptyTab();

  void requestUrl(String? tabId, String enteredText) {
    if (tabId == null) {
      return;
    }

    final text = enteredText.trim();

    if (text.isEmpty) {
      return;
    }

    final (isUrl, url) = _handleUrl(text);

    _browserService.tM.requestUrl(
      tabId,
      isUrl ? url! : Uri.parse('$_searchEngineUri$text'),
    );
  }

  void setController(String tabId, InAppWebViewController controller) {
    _browserService.tM.setController(tabId, controller);
  }

  void removeController(String tabId) {
    _browserService.tM.removeController(tabId);
  }

  void closeAllControllers() => _browserService.tM.closeAllControllers();

  void refresh(String tabId) {
    _browserService.tM.refresh(tabId);
  }

  void copyTabUrl(String tabId) {
    final url = _browserService.tM.activeTab?.url;

    if (url == null) {
      return;
    }

    Clipboard.setData(
      ClipboardData(
        text: url.toString(),
      ),
    );
  }

  void addUrlToBookmark(String tabId) {
    _browserService.createTabBookMark(tabId);
  }

  void clearUrlFromHistory(String tabId) {
    final url = _browserService.tM.activeTab?.url;

    if (url == null) {
      return;
    }

    _browserService.hM.removeHistoryItemByUri(url);
  }

  (bool, Uri?) _handleUrl(String text) {
    try {
      final uri = Uri.parse(text);
      return (UrlValidator.checkString(text), uri);
    } catch (_) {
      return (false, null);
    }
  }
}
