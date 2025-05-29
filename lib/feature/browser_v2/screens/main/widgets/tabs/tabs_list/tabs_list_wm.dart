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

  late final _selectedTabsState = createNotifier<List<BrowserTab>?>();

  ListenableState<List<BrowserTab>?> get selectedTabsState =>
      _selectedTabsState;

  ListenableState<List<TabListHeaderUiModel>> get uiState => _uiState;

  late final _uiState = createNotNullNotifier<List<TabListHeaderUiModel>>([]);
  late final scrollController = createScrollController();

  final _bookmarksUiModel = TabListHeaderBookmarksUiModel();
  final _newGroupUiModel = TabListHeaderNewGroupUiModel();

  CenterSnapScrollPhysics? _physic;
  double? _itemWidth;

  @override
  void initWidgetModel() {
    model.allGroupsState.addListener(_handleAllGroups);
    selectedGroupIdState.addListener(_handleSelectedGroupId);
    super.initWidgetModel();
  }

  @override
  void dispose() {
    model.allGroupsState.removeListener(_handleAllGroups);
    selectedGroupIdState.removeListener(_handleSelectedGroupId);
    super.dispose();
  }

  CenterSnapScrollPhysics getPhysic(double itemWidth) {
    return _physic ??= CenterSnapScrollPhysics(itemWidth: itemWidth);
  }

  //ignore: use_setters_to_change_properties
  void updateItemWidth(double itemWidth) {
    _itemWidth = itemWidth;
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

  void _handleSelectedGroupId() {
    final id = selectedGroupIdState.value;

    if (id == null) {
      return;
    }

    _handleAllGroups();
    _scrollToGroup();
  }

  void _handleAllGroups() {
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
      _selectedTabsState.accept(
        model.getGroupTabs(id),
      );
    }
  }

  void _scrollToGroup() {
    if (_itemWidth == null) {
      return;
    }

    final selectedId = selectedGroupIdState.value;

    final index = _uiState.value.indexWhere(
      (item) => item is TabListHeaderGroupUiModel && item.id == selectedId,
    );

    if (index == -1) {
      return;
    }

    scrollController.animateTo(
      _itemWidth! * index - _itemWidth!,
      duration: const Duration(milliseconds: 250),
      curve: Curves.linear,
    );
  }
}
