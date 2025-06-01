import 'package:app/core/error_handler_factory.dart';
import 'package:app/core/wm/custom_wm.dart';
import 'package:app/core/wm/not_null_listenable_state.dart';
import 'package:app/di/di.dart';
import 'package:app/feature/browser_v2/data/tabs/browser_tab.dart';
import 'package:app/feature/browser_v2/screens/main/widgets/tabs/tabs_list/tabs_list.dart';
import 'package:app/feature/browser_v2/screens/main/widgets/tabs/tabs_list/tabs_list_model.dart';
import 'package:elementary/elementary.dart';
import 'package:elementary_helper/elementary_helper.dart';
import 'package:flutter/widgets.dart';
import 'package:render_metrics/render_metrics.dart';

/// Factory method for creating [BrowserTabsListWidgetModel]
BrowserTabsListWidgetModel defaultBrowserTabsListWidgetModelFactory(
  BuildContext context, {
  required ListenableState<String?> selectedGroupIdState,
  required RenderManager<String> renderManager,
  required ValueChanged<BrowserTab> onPressedTabMenu,
  required ValueChanged<String> onPressedTab,
}) {
  return BrowserTabsListWidgetModel(
    BrowserTabsListModel(
      createPrimaryErrorHandler(context),
      inject(),
    ),
    selectedGroupIdState,
    renderManager,
    onPressedTabMenu,
    onPressedTab,
  );
}

/// [WidgetModel] для [BrowserTabsList]
class BrowserTabsListWidgetModel
    extends CustomWidgetModel<BrowserTabsList, BrowserTabsListModel> {
  BrowserTabsListWidgetModel(
    super.model,
    this.selectedGroupIdState,
    this.renderManager,
    this.onPressedTabMenu,
    this.onPressedTab,
  );

  final ListenableState<String?> selectedGroupIdState;
  final RenderManager<String> renderManager;
  final ValueChanged<BrowserTab> onPressedTabMenu;
  final ValueChanged<String> onPressedTab;

  late final _selectedTabsState =
      createNotifier<List<NotNullListenableState<BrowserTab>>?>();

  ListenableState<List<NotNullListenableState<BrowserTab>>?>
      get selectedTabsState => _selectedTabsState;

  @override
  void initWidgetModel() {
    selectedGroupIdState.addListener(_handleSelectedGroup);
    super.initWidgetModel();
  }

  @override
  void dispose() {
    selectedGroupIdState.removeListener(_handleSelectedGroup);
    super.dispose();
  }

  void onCloseTab(String tabId) {
    final id = selectedGroupIdState.value;
    if (id == null) {
      return;
    }

    model.removeBrowserTab(
      groupId: id,
      tabId: tabId,
    );
  }

  void _handleSelectedGroup() {
    final groupId = selectedGroupIdState.value;

    if (groupId == null) {
      return;
    }

    _selectedTabsState.accept(model.getGroupTabs(groupId));
  }
}
