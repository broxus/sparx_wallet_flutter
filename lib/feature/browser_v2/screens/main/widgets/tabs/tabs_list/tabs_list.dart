import 'package:app/core/wm/custom_wm.dart';
import 'package:app/core/wm/not_null_listenable_state.dart';
import 'package:app/feature/browser_v2/data/tabs/browser_tab.dart';
import 'package:app/feature/browser_v2/screens/main/widgets/control_panels/tabs_list_action_bar.dart';
import 'package:app/feature/browser_v2/screens/main/widgets/tabs/item/browser_tabs_list_item.dart';
import 'package:app/feature/browser_v2/screens/main/widgets/tabs/tabs_list/tabs_list_wm.dart';
import 'package:app/feature/browser_v2/screens/main/widgets/tabs/tabs_list/widgets/header/tab_list_header.dart';
import 'package:app/generated/generated.dart';
import 'package:elementary_helper/elementary_helper.dart';
import 'package:flutter/material.dart';
import 'package:render_metrics/render_metrics.dart';
import 'package:ui_components_lib/ui_components_lib.dart';

class BrowserTabsList extends InjectedElementaryParametrizedWidget<
    BrowserTabsListWidgetModel, ListenableState<String?>> {
  const BrowserTabsList({
    required ListenableState<String?> selectedGroupIdState,
    required this.onPressedTab,
    required this.onPressedTabMenu,
    required this.onPressedGroup,
    required this.renderManager,
    required this.onPressedCreateNewGroup,
    required this.tabListScrollController,
    super.key,
  }) : super(
          wmFactoryParam: selectedGroupIdState,
        );

  final ScrollController tabListScrollController;
  final ValueChanged<String> onPressedGroup;
  final VoidCallback onPressedCreateNewGroup;
  final ValueChanged<BrowserTab> onPressedTabMenu;
  final RenderManager<String> renderManager;
  final ValueChanged<String> onPressedTab;

  // TODO(nesquikm): We should calculate this value based on the screen size
  static const _cardAspectRatio = 0.9;

  static const padding = EdgeInsets.only(
    top: DimensSizeV2.d24,
    bottom: DimensSizeV2.d16 + BrowserTabsListActionBar.height,
    left: DimensSizeV2.d16,
    right: DimensSizeV2.d16,
  );

  @override
  Widget build(BrowserTabsListWidgetModel wm) {
    return Column(
      children: [
        TabListHeader(
          selectedGroupIdState: wm.selectedGroupIdState,
          onPressedGroup: onPressedGroup,
          onPressedCreateNewGroup: onPressedCreateNewGroup,
        ),
        const _Separator(),
        Expanded(
          child:
              StateNotifierBuilder<List<NotNullListenableState<BrowserTab>>?>(
            listenableState: wm.selectedTabsState,
            builder: (
              _,
              List<NotNullListenableState<BrowserTab>>? tabsNotifiers,
            ) {
              if (tabsNotifiers == null) {
                return const SizedBox.shrink();
              } else if (tabsNotifiers.isEmpty) {
                return const _Empty();
              }

              return GridView.count(
                controller: tabListScrollController,
                padding: padding,
                crossAxisCount: 2,
                crossAxisSpacing: DimensSizeV2.d8,
                mainAxisSpacing: DimensSizeV2.d8,
                childAspectRatio: _cardAspectRatio,
                children: [
                  for (final notifiers in tabsNotifiers)
                    BrowserTabsListItem(
                      key: ValueKey(notifiers.value.id),
                      renderManager: renderManager,
                      tabNotifier: notifiers,
                      onPressedTabMenu: () => onPressedTabMenu(notifiers.value),
                      onPressed: () => onPressedTab(notifiers.value.id),
                      onClosePressed: () => wm.onCloseTab(notifiers.value.id),
                    ),
                ],
              );
            },
          ),
        ),
      ],
    );
  }
}

class _Separator extends StatelessWidget {
  const _Separator();

  @override
  Widget build(BuildContext context) {
    return Divider(
      height: DimensSizeV2.d1,
      color: context.themeStyleV2.colors.primaryA.withAlpha(25),
    );
  }
}

class _Empty extends StatelessWidget {
  const _Empty();

  @override
  Widget build(BuildContext context) {
    final theme = context.themeStyleV2;
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: DimensSizeV2.d24),
      child: Column(
        spacing: DimensSizeV2.d8,
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Text(
            LocaleKeys.browserNoTabsTitle.tr(),
            style: theme.textStyles.headingLarge,
          ),
          Text(
            LocaleKeys.browserNoTabsDescription.tr(),
            style: theme.textStyles.paragraphMedium.copyWith(
              color: theme.colors.content4,
            ),
            textAlign: TextAlign.center,
          ),
        ],
      ),
    );
  }
}
