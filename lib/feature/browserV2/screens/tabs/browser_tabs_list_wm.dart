import 'package:app/app/router/app_route.dart';
import 'package:app/core/error_handler_factory.dart';
import 'package:app/core/wm/custom_wm.dart';
import 'package:app/di/di.dart';
import 'package:app/feature/browserV2/data/tabs_data.dart';
import 'package:app/feature/browserV2/screens/tabs/browser_tabs_list.dart';
import 'package:app/feature/browserV2/screens/tabs/browser_tabs_list_model.dart';
import 'package:elementary/elementary.dart';
import 'package:elementary_helper/elementary_helper.dart';
import 'package:flutter/widgets.dart';
import 'package:go_router/go_router.dart';

/// Factory method for creating [BrowserTabsListWidgetModel]
BrowserTabsListWidgetModel defaultBrowserTabsListWidgetModelFactory(
  BuildContext context,
) {
  return BrowserTabsListWidgetModel(
    BrowserTabsListModel(
      createPrimaryErrorHandler(context),
      inject(),
    ),
  );
}

/// [WidgetModel] для [BrowserTabsList]
class BrowserTabsListWidgetModel
    extends CustomWidgetModel<BrowserTabsList, BrowserTabsListModel> {
  BrowserTabsListWidgetModel(
    super.model,
  );

  ListenableState<BrowserTabsData> get tabsState => model.tabsState;

  void onChangeTab(String id) {
    model.setActiveTab(id);
    // TODO(knightforce): need?
    context.goNamed(AppRoute.browser.name);
  }

  void onCloseTab(String id, bool wasLast) {
    model.removeBrowserTab(id);
    if (wasLast) {
      // TODO(knightforce): need?
      context.goNamed(AppRoute.browser.name);
    }
  }
}
