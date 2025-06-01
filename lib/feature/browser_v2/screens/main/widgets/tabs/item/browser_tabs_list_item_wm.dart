import 'dart:io';

import 'package:app/core/error_handler_factory.dart';
import 'package:app/core/wm/custom_wm.dart';
import 'package:app/core/wm/not_null_listenable_state.dart';
import 'package:app/di/di.dart';
import 'package:app/feature/browser_v2/data/tabs/browser_tab.dart';
import 'package:app/feature/browser_v2/data/tabs/tabs_data.dart';
import 'package:app/feature/browser_v2/screens/main/widgets/tabs/item/browser_tabs_list_item.dart';
import 'package:app/feature/browser_v2/screens/main/widgets/tabs/item/browser_tabs_list_item_model.dart';
import 'package:elementary/elementary.dart';
import 'package:elementary_helper/elementary_helper.dart';
import 'package:flutter/widgets.dart';
import 'package:ui_components_lib/v2/ui_components_lib_v2.dart';

/// Factory method for creating [BrowserTabsListItemWidgetModel]
BrowserTabsListItemWidgetModel defaultBrowserTabsListItemWidgetModelFactory(
  BuildContext context, {
  required NotNullListenableState<BrowserTab> tabNotifier,
}) {
  return BrowserTabsListItemWidgetModel(
    BrowserTabsListItemModel(
      createPrimaryErrorHandler(context),
      inject(),
    ),
    tabNotifier,
  );
}

/// [WidgetModel] для [BrowserTabsListItem]
class BrowserTabsListItemWidgetModel
    extends CustomWidgetModel<BrowserTabsListItem, BrowserTabsListItemModel> {
  BrowserTabsListItemWidgetModel(
    super.model,
    this.tabNotifier,
  );

  final NotNullListenableState<BrowserTab> tabNotifier;

  String? _lastFilePath;

  late final _activeState = createNotifier<bool?>();

  late final _screenShotState = createNotifier<File?>();

  ListenableState<bool?> get activeState => _activeState;

  ListenableState<File?> get screenShotState => _screenShotState;

  ColorsPaletteV2 get colors => context.themeStyleV2.colors;

  String get id => tabNotifier.value.id;

  @override
  void initWidgetModel() {
    model.activeTabIdState.addListener(_handleActiveTab);
    model.screenshotsState.addListener(_handleScreenShots);
    super.initWidgetModel();
  }

  @override
  void dispose() {
    model.activeTabIdState.removeListener(_handleActiveTab);
    model.screenshotsState.removeListener(_handleScreenShots);
    super.dispose();
  }

  void _handleActiveTab() {
    _activeState.accept(
      tabNotifier.value.id == model.activeTabIdState.value,
    );
  }

  void _handleScreenShots() {
    final filePath = model.screenshotsState.value?.get(tabNotifier.value.id);

    if (filePath == null) {
      return;
    }

    if (filePath != _lastFilePath) {
      _screenShotState.accept(File(filePath));
    }

    _lastFilePath = filePath;
  }
}
