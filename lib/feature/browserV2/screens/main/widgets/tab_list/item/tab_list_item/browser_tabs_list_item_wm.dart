import 'dart:io';

import 'package:app/core/error_handler_factory.dart';
import 'package:app/core/wm/custom_wm.dart';
import 'package:app/di/di.dart';
import 'package:app/feature/browserV2/screens/main/widgets/tab_list/item/tab_list_item/browser_tabs_list_item.dart';
import 'package:app/feature/browserV2/screens/main/widgets/tab_list/item/tab_list_item/browser_tabs_list_item_model.dart';
import 'package:elementary/elementary.dart';
import 'package:elementary_helper/elementary_helper.dart';
import 'package:flutter/widgets.dart';
import 'package:ui_components_lib/v2/ui_components_lib_v2.dart';

/// Factory method for creating [BrowserTabsListItemWidgetModel]
BrowserTabsListItemWidgetModel defaultBrowserTabsListItemWidgetModelFactory(
  BuildContext context,
) {
  return BrowserTabsListItemWidgetModel(
    BrowserTabsListItemModel(
      createPrimaryErrorHandler(context),
      inject(),
    ),
  );
}

/// [WidgetModel] для [BrowserTabsListItem]
class BrowserTabsListItemWidgetModel
    extends CustomWidgetModel<BrowserTabsListItem, BrowserTabsListItemModel> {
  BrowserTabsListItemWidgetModel(
    super.model,
  );

  String? _lastFilePath;

  late final _activeState = createNotifier<bool?>();

  late final _screenShotState = createNotifier<File?>();

  late final _titleState = createNotifier<String?>();

  ListenableState<bool?> get activeState => _activeState;

  ListenableState<File?> get screenShotState => _screenShotState;

  ListenableState<String?> get titleState => _titleState;

  ColorsPaletteV2 get colors => context.themeStyleV2.colors;

  @override
  void initWidgetModel() {
    model.activeTabState.addListener(_handleActiveTab);
    model.screenshotsState.addListener(_handleScreenShots);
    super.initWidgetModel();
  }

  @override
  void didUpdateWidget(BrowserTabsListItem oldWidget) {
    if (oldWidget.tab.url != widget.tab.url) {
      _titleState.accept(widget.tab.url.toString());
    }
    super.didUpdateWidget(oldWidget);
  }

  @override
  void dispose() {
    model.activeTabState.removeListener(_handleActiveTab);
    model.screenshotsState.removeListener(_handleScreenShots);
    super.dispose();
  }

  void _handleActiveTab() {
    _activeState.accept(widget.tab.id == model.activeTabState.value?.id);
  }

  void _handleScreenShots() {
    final filePath = model.screenshotsState.value?.get(widget.tab.id);

    if (filePath == null) {
      return;
    }

    if (filePath != _lastFilePath) {
      _screenShotState.accept(File(filePath));
    }

    _lastFilePath = filePath;
  }
}
