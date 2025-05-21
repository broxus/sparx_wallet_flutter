import 'package:app/core/error_handler_factory.dart';
import 'package:app/core/wm/custom_wm.dart';
import 'package:app/di/di.dart';
import 'package:app/feature/browser_v2/data/groups/browser_group.dart';
import 'package:app/feature/browser_v2/screens/main/widgets/tabs/header/tab_list_header.dart';
import 'package:app/feature/browser_v2/screens/main/widgets/tabs/header/tab_list_header_model.dart';
import 'package:app/feature/browser_v2/screens/main/widgets/tabs/header/ui_models/tab_list_ui_models.dart';
import 'package:elementary/elementary.dart';
import 'package:elementary_helper/elementary_helper.dart';
import 'package:flutter/material.dart';

/// Factory method for creating [TabListHeaderWidgetModel]
TabListHeaderWidgetModel defaultTabListHeaderWidgetModelFactory(
  BuildContext context, {
  required VoidCallback onPressedCreateNewGroup,
}) {
  return TabListHeaderWidgetModel(
    TabListHeaderModel(
      createPrimaryErrorHandler(context),
      inject(),
    ),
    onPressedCreateNewGroup,
  );
}

/// [WidgetModel] для [TabListHeader]
class TabListHeaderWidgetModel
    extends CustomWidgetModel<TabListHeader, TabListHeaderModel> {
  TabListHeaderWidgetModel(
    super.model,
    this._onPressedCreateNewGroup,
  );

  ListenableState<List<TabListHeaderUiModel>> get uiState => _uiState;

  late final _uiState = createNotifier<List<TabListHeaderUiModel>>([]);

  final _bookmarksUiModel = TabListHeaderBookmarksUiModel();
  final _newGroupUiModel = TabListHeaderNewGroupUiModel();

  CenterSnapScrollPhysics? physic;

  CenterSnapScrollPhysics getPhysic(double itemWidth) {
    return physic ??= CenterSnapScrollPhysics(itemWidth: itemWidth);
  }

  final VoidCallback _onPressedCreateNewGroup;

  @override
  void initWidgetModel() {
    model.allGroupsState.addListener(_handleGroups);
    model.activeGroupState.addListener(_handleGroups);
    super.initWidgetModel();
  }

  @override
  void dispose() {
    model.allGroupsState.removeListener(_handleGroups);
    model.activeGroupState.removeListener(_handleGroups);
    super.dispose();
  }

  void onPressedBookmarks() {
    // TODO(knightforce): create logic
  }

  void onPressedCreateNewGroup() {
    _onPressedCreateNewGroup();
  }

  void onPressedGroup(String id) {
    model.setActiveGroup(id);
  }

  void _handleGroups() {
    final groups = model.allGroupsState.value;
    final activeGroupId = model.activeGroupState.value?.id;
    _uiState.accept(
      [
        _bookmarksUiModel,
        if (groups != null)
          for (final group in groups.list)
            TabListHeaderGroupUiModel(
              id: group.id,
              title: group.title,
              tabsCountText: group.tabsCountText,
              isSelected: group.id == activeGroupId,
            ),
        _newGroupUiModel,
      ],
    );
  }
}
