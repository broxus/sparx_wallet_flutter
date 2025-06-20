import 'dart:io';

import 'package:app/core/wm/custom_wm.dart';
import 'package:app/feature/browser_v2/data/browser_tab.dart';
import 'package:app/feature/browser_v2/data/tabs_data.dart';
import 'package:app/feature/browser_v2/screens/main/widgets/tabs/item/browser_tabs_list_item.dart';
import 'package:app/feature/browser_v2/screens/main/widgets/tabs/item/browser_tabs_list_item_model.dart';
import 'package:app/generated/generated.dart';
import 'package:elementary/elementary.dart';
import 'package:elementary_helper/elementary_helper.dart';
import 'package:injectable/injectable.dart';
import 'package:ui_components_lib/v2/ui_components_lib_v2.dart';

/// [WidgetModel] для [BrowserTabsListItem]
@injectable
class BrowserTabsListItemWidgetModel
    extends CustomWidgetModel<BrowserTabsListItem, BrowserTabsListItemModel> {
  BrowserTabsListItemWidgetModel(
    super.model,
    @factoryParam this.tab,
  );

  final BrowserTab tab;

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
    _updateTitle();
    super.initWidgetModel();
  }

  void _updateTitle() {
    String? title;

    if (tab.title != null) {
      title = tab.title;
    } else {
      final url = tab.url.toString();
      title = url.isEmpty ? LocaleKeys.startPage.tr() : url;
    }

    _titleState.accept(title);
  }

  @override
  void dispose() {
    model.activeTabState.removeListener(_handleActiveTab);
    model.screenshotsState.removeListener(_handleScreenShots);
    super.dispose();
  }

  void _handleActiveTab() {
    _activeState.accept(tab.id == model.activeTabState.value?.id);
  }

  void _handleScreenShots() {
    final filePath = model.screenshotsState.value?.get(tab.id);

    if (filePath == null) {
      return;
    }

    if (filePath != _lastFilePath) {
      _screenShotState.accept(File(filePath));
    }

    _lastFilePath = filePath;
  }
}
