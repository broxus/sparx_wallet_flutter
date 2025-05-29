import 'dart:math';

import 'package:app/feature/browser_v2/screens/main/widgets/tabs/tabs_list/widgets/group_header_item.dart';
import 'package:app/feature/browser_v2/screens/main/widgets/tabs/tabs_list/widgets/header_button.dart';
import 'package:app/feature/browser_v2/screens/main/widgets/tabs/tabs_list/widgets/tab_list_ui_models.dart';
import 'package:app/generated/generated.dart';
import 'package:elementary_helper/elementary_helper.dart';
import 'package:flutter/cupertino.dart';
import 'package:ui_components_lib/v2/dimens_v2.dart';

class TabListHeader extends StatelessWidget {
  const TabListHeader({
    required this.getPhysic,
    required this.updateItemWidth,
    required this.onPressedCreateNewGroup,
    required this.onPressedGroup,
    required this.onPressedBookmarks,
    required this.uiState,
    required this.scrollController,
    super.key,
  });

  final ScrollPhysics Function(double itemWidth) getPhysic;
  final ValueChanged<double> updateItemWidth;
  final VoidCallback onPressedCreateNewGroup;
  final ValueChanged<String> onPressedGroup;
  final VoidCallback onPressedBookmarks;
  final ListenableState<List<TabListHeaderUiModel>> uiState;
  final ScrollController scrollController;

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(
      builder: (_, BoxConstraints constraints) {
        final itemWidth = constraints.maxWidth / 3;
        final physic = getPhysic(itemWidth);
        updateItemWidth(itemWidth);

        return SizedBox(
          height: DimensSizeV2.d41,
          child: StateNotifierBuilder(
            listenableState: uiState,
            builder: (_, List<TabListHeaderUiModel>? uiModels) {
              if (uiModels == null) {
                return const SizedBox.shrink();
              }
              return ListView.builder(
                controller: scrollController,
                scrollDirection: Axis.horizontal,
                itemCount: uiModels.length,
                physics: physic,
                itemBuilder: (_, int index) {
                  return switch (uiModels[index]) {
                    TabListHeaderBookmarksUiModel() => BrowserHeaderTextButton(
                        key: ObjectKey(uiModels[index]),
                        width: itemWidth,
                        onPressed: onPressedBookmarks,
                        text: LocaleKeys.browserBookmarks.tr(),
                        alignment: Alignment.centerLeft,
                      ),
                    TabListHeaderGroupUiModel(
                      :final id,
                      :final tabsCountText,
                      :final title,
                      :final isSelected,
                    ) =>
                      BrowserGroupHeaderItem(
                        key: ValueKey(id),
                        width: itemWidth,
                        onPressed: () => onPressedGroup(id),
                        name: title ?? '',
                        count: tabsCountText,
                        isSelected: isSelected,
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

class CenterSnapScrollPhysics extends ClampingScrollPhysics {
  const CenterSnapScrollPhysics({
    required this.itemWidth,
    super.parent,
  });

  final double itemWidth;

  @override
  CenterSnapScrollPhysics applyTo(ScrollPhysics? ancestor) {
    return CenterSnapScrollPhysics(
      itemWidth: itemWidth,
      parent: buildParent(ancestor),
    );
  }

  static const SpringDescription _spring = SpringDescription(
    mass: 1,
    stiffness: 60,
    damping: 20,
  );

  @override
  Simulation? createBallisticSimulation(
    ScrollMetrics position,
    double velocity,
  ) {
    final current = position.pixels;
    final tol = toleranceFor(position);

    final target = _getTargetPixels(position);

    if ((target - current).abs() <= tol.distance) {
      return null;
    }

    return ScrollSpringSimulation(
      _spring,
      current,
      target,
      0,
      tolerance: tol,
    );
  }

  double _getCurrentPage(ScrollMetrics position) {
    final offset = (position.viewportDimension - itemWidth) / 2;
    return (position.pixels + offset) / itemWidth;
  }

  double _getTargetPixels(ScrollMetrics position) {
    final currentPage = _getCurrentPage(position);
    final targetPage = currentPage.roundToDouble();
    final offset = (position.viewportDimension - itemWidth) / 2;
    final pixels = targetPage * itemWidth - offset;
    return max(
      position.minScrollExtent,
      min(position.maxScrollExtent, pixels),
    );
  }

  @override
  bool get allowImplicitScrolling => false;
}
