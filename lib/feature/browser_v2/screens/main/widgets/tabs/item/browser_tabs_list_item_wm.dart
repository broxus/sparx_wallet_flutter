import 'dart:io';

import 'package:app/core/wm/custom_wm.dart';
import 'package:app/core/wm/not_null_listenable_state.dart';
import 'package:app/feature/browser_v2/data/tabs/browser_tab.dart';
import 'package:app/feature/browser_v2/screens/main/widgets/tabs/item/browser_tabs_list_item.dart';
import 'package:app/feature/browser_v2/screens/main/widgets/tabs/item/browser_tabs_list_item_model.dart';
import 'package:elementary/elementary.dart';
import 'package:elementary_helper/elementary_helper.dart';
import 'package:injectable/injectable.dart';

/// [WidgetModel] для [BrowserTabsListItem]
@injectable
class BrowserTabsListItemWidgetModel extends CustomWidgetModelParametrized<
    BrowserTabsListItem,
    BrowserTabsListItemModel,
    NotNullListenableState<BrowserTab>> {
  BrowserTabsListItemWidgetModel(
    super.model,
  );

  String? _lastFilePath;

  late final _activeState = createNotifier<bool?>();

  late final _screenShotState = createNotifier<File?>();

  NotNullListenableState<BrowserTab> get tabNotifier => wmParams.value;

  ListenableState<bool?> get activeState => _activeState;

  ListenableState<File?> get screenShotState => _screenShotState;

  @override
  void initWidgetModel() {
    super.initWidgetModel();
    model.activeTabIdState.addListener(_handleActiveTab);
    model.screenshotsState.addListener(_handleScreenShots);
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
    final id = tabNotifier.value.id;

    final filePath = model.screenshotsState.value?[id];

    if (filePath == null) {
      return;
    }

    if (filePath != _lastFilePath) {
      final file = File(filePath);

      if (file.existsSync()) {
        _screenShotState.accept(file);
      } else {
        _screenShotState.accept(null);
      }
    }

    _lastFilePath = filePath;
  }
}
