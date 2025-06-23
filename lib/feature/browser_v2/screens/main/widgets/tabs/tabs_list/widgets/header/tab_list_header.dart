import 'package:app/core/wm/custom_wm.dart';
import 'package:app/feature/browser_v2/screens/main/widgets/tabs/tabs_list/widgets/group_header_item.dart';
import 'package:app/feature/browser_v2/screens/main/widgets/tabs/tabs_list/widgets/header/header_button.dart';
import 'package:app/feature/browser_v2/screens/main/widgets/tabs/tabs_list/widgets/header/tab_list_header_wm.dart';
import 'package:app/feature/browser_v2/screens/main/widgets/tabs/tabs_list/widgets/header/ui_models.dart';
import 'package:app/generated/generated.dart';
import 'package:elementary_helper/elementary_helper.dart';
import 'package:flutter/material.dart';
import 'package:ui_components_lib/v2/dimens_v2.dart';

class TabListHeader extends InjectedElementaryWidget<TabListHeaderWidgetModel> {
  const TabListHeader({
    required ListenableState<String?> selectedGroupIdState,
    required this.onPressedGroup,
    required this.onPressedCreateNewGroup,
    super.key,
  }) : super(
          param1: selectedGroupIdState,
        );

  final ValueChanged<String> onPressedGroup;
  final VoidCallback onPressedCreateNewGroup;

  @override
  Widget build(TabListHeaderWidgetModel wm) {
    return LayoutBuilder(
      builder: (_, BoxConstraints constraints) {
        final itemWidth = constraints.maxWidth / 3;
        final physic = wm.getPhysic(itemWidth);
        wm.updateItemWidth(itemWidth);

        return SizedBox(
          height: DimensSizeV2.d41,
          child: StateNotifierBuilder(
            listenableState: wm.uiState,
            builder: (_, List<TabListHeaderUiModel>? uiModels) {
              if (uiModels == null) {
                return const SizedBox.shrink();
              }
              return ListView.builder(
                controller: wm.scrollController,
                scrollDirection: Axis.horizontal,
                itemCount: uiModels.length,
                physics: physic,
                itemBuilder: (_, int index) {
                  return switch (uiModels[index]) {
                    TabListHeaderBookmarksUiModel() => BrowserHeaderTextButton(
                        key: ObjectKey(uiModels[index]),
                        width: itemWidth,
                        onPressed: wm.onPressedBookmarks,
                        text: LocaleKeys.browserBookmarks.tr(),
                        alignment: Alignment.centerLeft,
                      ),
                    TabListHeaderGroupUiModel(
                      :final id,
                      :final listenable,
                    ) =>
                      BrowserGroupHeaderItem(
                        key: ValueKey(id),
                        width: itemWidth,
                        listenable: listenable,
                        selectedGroupIdListenable: wm.selectedGroupIdState,
                        onPressed: () => onPressedGroup(id),
                      ),
                    TabListHeaderNewGroupUiModel() => BrowserHeaderTextButton(
                        key: ObjectKey(uiModels[index]),
                        width: itemWidth,
                        onPressed: onPressedCreateNewGroup,
                        text: LocaleKeys.newGroup.tr(),
                        alignment: Alignment.centerRight,
                      ),
                  };
                },
              );
            },
          ),
        );
      },
    );
  }
}
