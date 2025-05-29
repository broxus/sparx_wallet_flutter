import 'dart:async';

import 'package:app/feature/browser_v2/custom_web_controller.dart';
import 'package:app/feature/browser_v2/data/groups/browser_group.dart';
import 'package:app/feature/browser_v2/data/tabs/browser_tab.dart';
import 'package:app/feature/browser_v2/domain/service/browser_service.dart';
import 'package:app/feature/browser_v2/screens/main/browser_main_screen.dart';
import 'package:app/utils/url_utils.dart';
import 'package:elementary/elementary.dart';
import 'package:elementary_helper/elementary_helper.dart';
import 'package:flutter/services.dart';

const _searchEngineUri = 'https://duckduckgo.com/?q=';

/// [ElementaryModel] for [BrowserMainScreen]
class BrowserMainScreenModel extends ElementaryModel {
  BrowserMainScreenModel(
    ErrorHandler errorHandler,
    this._browserService,
  ) : super(errorHandler: errorHandler);
  final BrowserService _browserService;

  ListenableState<BrowserGroup?> get activeGroupState =>
      _browserService.tM.activeGroupState;

  ListenableState<BrowserTab?> get activeTabState =>
      _browserService.tM.activeTabState;

  String? get activeTabId => activeTabState.value?.id;

  void setActiveGroup(String groupId) {
    _browserService.tM.setActiveGroup(groupId);
  }

  void setActiveTab(String tabId) {
    _browserService.tM.setActiveTab(tabId);
  }

  BrowserTab? getTabById(String? tabId) {
    if (tabId == null) {
      return null;
    }
    return _browserService.tM.getTabById(tabId);
  }

  int? getTabIndex({
    required String groupId,
    required String tabId,
  }) {
    return _browserService.tabs.getTabIndex(
      groupId: groupId,
      tabId: tabId,
    );
  }

  void clearTabs() => _browserService.tM.clearTabs();

  void createEmptyTab(String groupId) {
    _browserService.tM.createEmptyTab(groupId);
  }

  void requestUrl(String? tabId, String enteredText) {
    if (tabId == null) {
      return;
    }

    final text = enteredText.trim();

    if (text.isEmpty) {
      return;
    }

    final isUrl = UrlValidator.checkString(text);

    unawaited(
      _browserService.tM.requestUrl(
        tabId,
        isUrl ? Uri.parse(text) : Uri.parse('$_searchEngineUri$text'),
      ),
    );
  }

  void setController(String tabId, CustomWebViewController controller) {
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

  BrowserGroup? createBrowserGroup({
    String? name,
    String? tabId,
  }) =>
      _browserService.tabs.createBrowserGroup(
        name: name,
        isSwitchToCreatedGroup: tabId == null,
        initTabId: tabId,
      );

  List<BrowserTab> getGroupTabs(String groupId) {
    return _browserService.tabs.getGroupTabs(groupId);
  }

  String? getTabIdByIndex({
    required String groupId,
    required int index,
  }) {
    return _browserService.tabs.getTabIdByIndex(
      groupId: groupId,
      index: index,
    );
  }
}
