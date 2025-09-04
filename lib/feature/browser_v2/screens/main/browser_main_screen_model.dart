import 'dart:async';

import 'package:app/core/wm/not_null_listenable_state.dart';
import 'package:app/feature/browser_v2/custom_web_controller.dart';
import 'package:app/feature/browser_v2/data/groups/browser_group.dart';
import 'package:app/feature/browser_v2/data/tabs/browser_tab.dart';
import 'package:app/feature/browser_v2/domain/service/browser_service.dart';
import 'package:app/feature/browser_v2/screens/main/browser_main_screen.dart';
import 'package:app/utils/url_utils.dart';
import 'package:elementary/elementary.dart';
import 'package:elementary_helper/elementary_helper.dart';
import 'package:flutter/services.dart';
import 'package:injectable/injectable.dart';

const _searchEngineUri = 'https://duckduckgo.com/?q=';

/// [ElementaryModel] for [BrowserMainScreen]
@injectable
class BrowserMainScreenModel extends ElementaryModel {
  BrowserMainScreenModel(
    ErrorHandler errorHandler,
    this._browserService,
  ) : super(errorHandler: errorHandler);
  final BrowserService _browserService;

  ListenableState<String?> get activeGroupIdState =>
      _browserService.tab.activeGroupIdState;

  ListenableState<String?> get activeTabIdState =>
      _browserService.tab.activeTabIdState;

  NotNullListenableState<List<String>> get allTabsIdsState =>
      _browserService.tab.allTabsIdsState;

  ListenableState<String?> get activeTabUrlHostState =>
      _browserService.tab.activeTabUrlHostState;

  String? get activeTabId => activeTabIdState.value;

  void setActiveGroup(String groupId) {
    _browserService.tab.setActiveGroup(groupId);
  }

  void setActiveTab(String tabId) {
    _browserService.tab.setActiveTab(tabId);
  }

  BrowserTab? getTabById(String? tabId) {
    if (tabId == null) {
      return null;
    }
    return _browserService.tab.getTabById(tabId);
  }

  int? getTabIndex({
    required String groupId,
    required String tabId,
  }) {
    return _browserService.tab.getTabIndex(
      groupId: groupId,
      tabId: tabId,
    );
  }

  void clearTabs(String groupId) => _browserService.tab.clearTabs(groupId);

  void createEmptyTab(String groupId) {
    _browserService.tab.createEmptyTab(groupId);
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
      _browserService.tab.requestUrl(
        tabId,
        isUrl ? Uri.parse(text) : Uri.parse('${BrowserService.searchUrl}$text'),
      ),
    );
  }

  void setController(String tabId, CustomWebViewController controller) {
    _browserService.tab.setController(tabId, controller);
  }

  void removeController(String tabId) {
    _browserService.tab.removeController(tabId);
  }

  void closeAllControllers() => _browserService.tab.closeAllControllers();

  void refresh(String tabId) {
    _browserService.tab.refresh(tabId);
  }

  void copyTabUrl(String tabId) {
    final url = _browserService.tab.getTabUriId(tabId);

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
    final url = _browserService.tab.getTabUriId(tabId);

    if (url == null) {
      return;
    }

    _browserService.hist.removeHistoryItemByUri(url);
  }

  BrowserGroup? createBrowserGroup({
    String? name,
    String? originalGroupId,
    String? tabId,
  }) =>
      _browserService.tab.createBrowserGroup(
        name: name,
        isSwitchToCreatedGroup: tabId == null,
        originalGroupId: originalGroupId,
        initTabId: tabId,
      );

  List<NotNullListenableState<BrowserTab>> getGroupTabs(String groupId) {
    return _browserService.tab.getGroupTabsListenable(groupId);
  }

  String? getTabIdByIndex({
    required String groupId,
    required int index,
  }) {
    return _browserService.tab.getTabIdByIndex(
      groupId: groupId,
      index: index,
    );
  }

  void updateInteractedState({required bool isInteracted}) {
    _browserService.updateInteractedState(isInteracted: isInteracted);
  }
}
