import 'dart:async';

import 'package:app/core/error_handler_factory.dart';
import 'package:app/core/wm/custom_wm.dart';
import 'package:app/di/di.dart';
import 'package:app/feature/browserV2/models/tabs_data.dart';
import 'package:app/feature/browserV2/screens/tabs/browser_tabs_screen.dart';
import 'package:app/feature/browserV2/screens/tabs/browser_tabs_screen_model.dart';
import 'package:elementary/elementary.dart';
import 'package:flutter/widgets.dart';
import 'package:logging/logging.dart';

/// Factory method for creating [BrowserTabsScreenWidgetModel]
BrowserTabsScreenWidgetModel defaultBrowserTabsScreenWidgetModelFactory(
  BuildContext context,
) {
  return BrowserTabsScreenWidgetModel(
    BrowserTabsScreenModel(
      createPrimaryErrorHandler(context),
      inject(),
    ),
  );
}

/// [WidgetModel] для [BrowserTabsScreen]
class BrowserTabsScreenWidgetModel
    extends CustomWidgetModel<BrowserTabsScreen, BrowserTabsScreenModel> {
  BrowserTabsScreenWidgetModel(
    super.model,
  );

  static final _emptyUri = Uri.parse('');

  static final _log = Logger('BrowserTabsScreen');

  StreamSubscription<BrowserTabsData>? _tabsSubscription;

  @override
  void initWidgetModel() {
    _tabsSubscription = model.originalTabsStream.listen((_) => _filter());
    super.initWidgetModel();
  }

  @override
  void dispose() {
    _tabsSubscription?.cancel();
    super.dispose();
  }

  void _filter() {
    //browserTabs
  }
}
