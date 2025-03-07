import 'package:app/feature/browserV2/data/tabs_data.dart';
import 'package:app/feature/browserV2/models/tab/browser_tab.dart';
import 'package:app/feature/browserV2/screens/main/data/menu_data.dart';
import 'package:app/feature/browserV2/screens/main/widgets/browser_progress_indicator.dart';
import 'package:app/feature/browserV2/screens/main/widgets/menu/menu_tab_list.dart';
import 'package:app/feature/browserV2/screens/main/widgets/menu/menu_url.dart';
import 'package:app/feature/browserV2/screens/main/widgets/menu/menu_view_tab/menu_view_tab.dart';
import 'package:app/utils/types/fuction_types.dart';
import 'package:elementary_helper/elementary_helper.dart';
import 'package:flutter/material.dart';

class BrowserBottomMenu extends StatefulWidget {
  const BrowserBottomMenu({
    required this.menuState,
    required this.tabsState,
    required this.activeTabState,
    required this.screenHeight,
    required this.menuUrlPanelWidth,
    required this.urlWidth,
    required this.onCloseAllPressed,
    required this.onPlusPressed,
    required this.onDonePressed,
    required this.onPressedTabs,
    required this.onPressedUrlMenu,
    required this.onPressedRefresh,
    required this.onPressedMenuUrl,
    required this.onEditingCompleteUrl,
    required this.urlSliderController,
    required this.progressAnimation,
    super.key,
  });

  final ListenableState<BrowserTabsCollection> tabsState;
  final ListenableState<BrowserTab?> activeTabState;
  final double screenHeight;
  final double menuUrlPanelWidth;
  final double urlWidth;
  final VoidCallback onCloseAllPressed;
  final VoidCallback onPlusPressed;
  final VoidCallback onDonePressed;
  final VoidCallback onPressedTabs;
  final ValueChanged<String> onPressedUrlMenu;
  final ValueChanged<String> onPressedRefresh;
  final VoidCallback onPressedMenuUrl;
  final DoubleValueCallback<String, String> onEditingCompleteUrl;
  final ScrollController urlSliderController;
  final Animation<double> progressAnimation;

  final ListenableState<MenuType> menuState;

  @override
  State<BrowserBottomMenu> createState() => _BrowserBottomMenuState();
}

class _BrowserBottomMenuState extends State<BrowserBottomMenu> {
  final _listKey = UniqueKey();
  final _viewKey = UniqueKey();
  final _urlKey = UniqueKey();

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        BrowserProgressIndicator(
          animation: widget.progressAnimation,
        ),
        StateNotifierBuilder(
          listenableState: widget.menuState,
          builder: (_, MenuType? type) {
            return AnimatedCrossFade(
              firstChild: BrowserTabListMenu(
                key: _listKey,
                tabsState: widget.tabsState,
                onCloseAllPressed: widget.onCloseAllPressed,
                onPlusPressed: widget.onPlusPressed,
                onDonePressed: widget.onDonePressed,
              ),
              secondChild: AnimatedCrossFade(
                firstChild: BrowserTabViewMenu(
                  key: _viewKey,
                  menuUrlPanelWidth: widget.menuUrlPanelWidth,
                  urlWidth: widget.urlWidth,
                  onPressedTabs: widget.onPressedTabs,
                  onPressedUrlMenu: widget.onPressedUrlMenu,
                  onPressedRefresh: widget.onPressedRefresh,
                  onEditingCompleteUrl: widget.onEditingCompleteUrl,
                  urlSliderController: widget.urlSliderController,
                  tabsState: widget.tabsState,
                ),
                secondChild: MenuRawUrl(
                  widget.activeTabState,
                  key: _urlKey,
                  onPressed: widget.onPressedMenuUrl,
                ),
                crossFadeState: type == MenuType.view
                    ? CrossFadeState.showFirst
                    : CrossFadeState.showSecond,
                duration: const Duration(milliseconds: 150),
              ),
              crossFadeState: type == MenuType.list
                  ? CrossFadeState.showFirst
                  : CrossFadeState.showSecond,
              duration: const Duration(milliseconds: 150),
            );
          },
        ),
      ],
    );
  }
}
