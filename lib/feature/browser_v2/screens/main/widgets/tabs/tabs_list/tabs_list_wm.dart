import 'package:app/core/error_handler_factory.dart';
import 'package:app/core/wm/custom_wm.dart';
import 'package:app/di/di.dart';
import 'package:app/feature/browser_v2/data/groups/browser_group.dart';
import 'package:app/feature/browser_v2/data/tabs/browser_tab.dart';
import 'package:app/feature/browser_v2/screens/main/widgets/tabs/tabs_list/tabs_list.dart';
import 'package:app/feature/browser_v2/screens/main/widgets/tabs/tabs_list/tabs_list_model.dart';
import 'package:app/feature/browser_v2/screens/main/widgets/tabs/tabs_list/widgets/header.dart';
import 'package:app/feature/browser_v2/screens/main/widgets/tabs/tabs_list/widgets/tab_list_ui_models.dart';
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
  required ValueChanged<String> onPressedGroup,
  required ValueChanged<String> onPressedTab,
  required VoidCallback onPressedCreateNewGroup,
}) {
  return BrowserTabsListWidgetModel(
    BrowserTabsListModel(
      createPrimaryErrorHandler(context),
      inject(),
    ),
    selectedGroupIdState,
    renderManager,
    onPressedTabMenu,
    onPressedGroup,
    onPressedTab,
    onPressedCreateNewGroup,
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
    this._onPressedGroup,
    this.onPressedTab,
    this.onPressedCreateNewGroup,
  );

  final ListenableState<String?> selectedGroupIdState;
  final RenderManager<String> renderManager;
  final ValueChanged<BrowserTab> onPressedTabMenu;
  final ValueChanged<String> _onPressedGroup;
  final ValueChanged<String> onPressedTab;

  final VoidCallback onPressedCreateNewGroup;

  late final _selectedGroupTabsState = createNotifier<List<BrowserTab>?>();

  ListenableState<List<BrowserTab>?> get selectedGroupTabsState =>
      _selectedGroupTabsState;

  ListenableState<List<TabListHeaderUiModel>> get uiState => _uiState;

  late final _uiState = createNotifier<List<TabListHeaderUiModel>>([]);

  final _bookmarksUiModel = TabListHeaderBookmarksUiModel();
  final _newGroupUiModel = TabListHeaderNewGroupUiModel();

  CenterSnapScrollPhysics? physic;

  CenterSnapScrollPhysics getPhysic(double itemWidth) {
    return physic ??= CenterSnapScrollPhysics(itemWidth: itemWidth);
  }

  @override
  void initWidgetModel() {
    model.allGroupsState.addListener(_handleGroups);
    model.activeGroupState.addListener(_handleActiveGroup);
    selectedGroupIdState.addListener(_handleSelectedGroup);
    super.initWidgetModel();
  }

  @override
  void dispose() {
    model.allGroupsState.removeListener(_handleGroups);
    model.activeGroupState.removeListener(_handleActiveGroup);
    selectedGroupIdState.removeListener(_handleSelectedGroup);

    super.dispose();
  }

  void onPressedBookmarks() {
    // TODO(knightforce): create logic
  }

  void onPressedGroup(String groupId) {
    _onPressedGroup(groupId);
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
    final id = selectedGroupIdState.value;

    if (id == null) {
      return;
    }

    _handleGroups();
  }

  void _handleGroups() {
    final id = selectedGroupIdState.value;

    final groups = model.allGroupsState.value;

    _uiState.accept(
      [
        _bookmarksUiModel,
        if (groups != null)
          for (final group in groups)
            TabListHeaderGroupUiModel(
              id: group.id,
              title: group.title,
              tabsCountText: group.tabsCountText,
              isSelected: group.id == id,
            ),
        _newGroupUiModel,
      ],
    );

    if (id != null) {
      _selectedGroupTabsState.accept(
        model.getGroupTabs(id),
      );
    }
  }

  void _handleActiveGroup() {
    final activeGroupId = model.activeGroupState.value?.activeTabId;
    final selectedId = selectedGroupIdState.value;
    if (activeGroupId == selectedId) {
      return;
    }
    _handleGroups();
  }
}
