import 'package:app/feature/browserV2/data/tabs_data.dart';
import 'package:app/feature/browserV2/screens/main/widgets/menu/menu_tab_list.dart';
import 'package:app/feature/browserV2/screens/main/widgets/menu/menu_view_tab/menu_view_tab.dart';
import 'package:app/utils/types/fuction_types.dart';
import 'package:elementary_helper/elementary_helper.dart';
import 'package:flutter/material.dart';

class BrowserBottomMenu extends StatefulWidget {
  const BrowserBottomMenu({
    required this.viewVisibleState,
    required this.tabsState,
    required this.onCloseAllPressed,
    required this.onPlusPressed,
    required this.onDonePressed,
    required this.onPressedBackPressed,
    required this.onPressedForwardPressed,
    required this.onPressedDotsPressed,
    required this.onPressedBook,
    required this.onPressedTabs,
    required this.onEditingCompleteUrl,
    required this.urlSliderController,
    super.key,
  });

  final ListenableState<BrowserTabsCollection> tabsState;
  final VoidCallback onCloseAllPressed;
  final VoidCallback onPlusPressed;
  final VoidCallback onDonePressed;
  final VoidCallback onPressedBackPressed;
  final VoidCallback onPressedForwardPressed;
  final VoidCallback onPressedDotsPressed;
  final VoidCallback onPressedBook;
  final VoidCallback onPressedTabs;
  final DoubleValueCallback<String, String> onEditingCompleteUrl;
  final ScrollController urlSliderController;

  final ListenableState<bool> viewVisibleState;

  @override
  State<BrowserBottomMenu> createState() => _BrowserBottomMenuState();
}

class _BrowserBottomMenuState extends State<BrowserBottomMenu> {
  final _overlayController = OverlayPortalController();
  final _listKey = UniqueKey();
  final _viewKey = UniqueKey();

  final _fullHeight = BrowserTabViewMenu.height;
  final _listMenuHeight = BrowserTabListMenu.height;

  late final double _listMenuBottomPosition = -_fullHeight + _listMenuHeight;
  final double _viewMenuBottomPosition = 0;

  @override
  void initState() {
    _overlayController.show();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return OverlayPortal(
      controller: _overlayController,
      overlayChildBuilder: (_) {
        return StateNotifierBuilder(
          listenableState: widget.viewVisibleState,
          builder: (_, bool? isVisible) {
            return AnimatedPositioned(
              duration: const Duration(milliseconds: 250),
              bottom: isVisible ?? false
                  ? _viewMenuBottomPosition
                  : _listMenuBottomPosition,
              left: 0,
              right: 0,
              child: SizedBox(
                height: _fullHeight,
                child: AnimatedCrossFade(
                  firstChild: BrowserTabListMenu(
                    key: _listKey,
                    tabsState: widget.tabsState,
                    onCloseAllPressed: widget.onCloseAllPressed,
                    onPlusPressed: widget.onPlusPressed,
                    onDonePressed: widget.onDonePressed,
                  ),
                  secondChild: BrowserTabViewMenu(
                    key: _viewKey,
                    onPressedBackPressed: widget.onPressedBackPressed,
                    onPressedForwardPressed: widget.onPressedForwardPressed,
                    onPressedDotsPressed: widget.onPressedDotsPressed,
                    onPressedBook: widget.onPressedBook,
                    onPressedTabs: widget.onPressedTabs,
                    onEditingCompleteUrl: widget.onEditingCompleteUrl,
                    urlSliderController: widget.urlSliderController,
                    tabsState: widget.tabsState,
                  ),
                  crossFadeState: isVisible ?? false
                      ? CrossFadeState.showSecond
                      : CrossFadeState.showFirst,
                  duration: const Duration(milliseconds: 250),
                ),
              ),
            );
          },
        );
      },
    );
  }
}
