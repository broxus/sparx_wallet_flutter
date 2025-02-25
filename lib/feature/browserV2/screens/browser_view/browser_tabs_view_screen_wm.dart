import 'package:app/core/error_handler_factory.dart';
import 'package:app/core/wm/custom_wm.dart';
import 'package:app/di/di.dart';
import 'package:app/feature/browserV2/data/tabs_data.dart';
import 'package:app/feature/browserV2/screens/browser_view/browser_tabs_view_screen.dart';
import 'package:app/feature/browserV2/screens/browser_view/browser_tabs_view_screen_model.dart';
import 'package:elementary/elementary.dart';
import 'package:elementary_helper/elementary_helper.dart';
import 'package:flutter/widgets.dart';
import 'package:logging/logging.dart';

/// Factory method for creating [BrowserTabsViewScreenWidgetModel]
BrowserTabsViewScreenWidgetModel defaultBrowserTabsViewScreenWidgetModelFactory(
  BuildContext context,
) {
  return BrowserTabsViewScreenWidgetModel(
    BrowserTabsViewScreenModel(
      createPrimaryErrorHandler(context),
      inject(),
    ),
  );
}

/// [WidgetModel] для [BrowserTabsViewScreen]
class BrowserTabsViewScreenWidgetModel
    extends CustomWidgetModel<BrowserTabsViewScreen, BrowserTabsViewScreenModel> {
  BrowserTabsViewScreenWidgetModel(
    super.model,
  );

  static final _log = Logger('BrowserTabsScreen');

  ListenableState<BrowserTabsData?> get tabsState => model.tabsState;

  @override
  void initWidgetModel() {
    super.initWidgetModel();
  }

  @override
  void dispose() {
    super.dispose();
  }
}
