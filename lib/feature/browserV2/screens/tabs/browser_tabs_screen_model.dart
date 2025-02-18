import 'dart:async';

import 'package:app/feature/browserV2/managers/tabs_manager.dart';
import 'package:app/feature/browserV2/models/tab/browser_tab.dart';
import 'package:app/feature/browserV2/models/tabs_data.dart';
import 'package:app/feature/browserV2/screens/tabs/browser_tabs_screen.dart';
import 'package:elementary/elementary.dart';

/// [ElementaryModel] for [BrowserTabsScreen]
class BrowserTabsScreenModel extends ElementaryModel {
  BrowserTabsScreenModel(
    ErrorHandler errorHandler,
    this._tabsManager,
  ) : super(errorHandler: errorHandler);

  final BrowserTabsManager _tabsManager;

  Stream<BrowserTabsData> get originalTabsStream => _tabsManager.tabsStream;

  List<BrowserTab> get browserTabs => _tabsManager.browserTabs;
}
