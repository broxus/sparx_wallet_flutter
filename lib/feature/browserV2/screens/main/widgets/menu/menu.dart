import 'package:app/feature/browserV2/data/tabs_data.dart';
import 'package:app/feature/browserV2/screens/main/screen_type.dart';
import 'package:app/feature/browserV2/screens/main/widgets/menu/menu_tab_list.dart';
import 'package:app/feature/browserV2/screens/main/widgets/menu/menu_view_tab.dart';
import 'package:elementary_helper/elementary_helper.dart';
import 'package:flutter/material.dart';

class BrowserBottomMenu extends StatefulWidget {
  const BrowserBottomMenu({
    required this.typeState,
    required this.tabsState,
    required this.onCloseAllPressed,
    required this.onPlusPressed,
    required this.onDonePressed,
    required this.onPressedBackPressed,
    required this.onPressedForwardPressed,
    required this.onPressedDotsPressed,
    required this.onPressedBook,
    required this.onPressedTabs,
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

  final ListenableState<BrowserMainScreenType> typeState;

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

  late BrowserMainScreenType? _type = widget.typeState.value;

  @override
  void initState() {
    widget.typeState.addListener(_handleType);
    _overlayController.show();
    super.initState();
  }

  @override
  void dispose() {
    widget.typeState.removeListener(_handleType);
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return OverlayPortal(
      controller: _overlayController,
      overlayChildBuilder: (_) {
        return AnimatedPositioned(
          duration: const Duration(milliseconds: 250),
          bottom: switch (_type) {
            BrowserMainScreenType.list => _listMenuBottomPosition,
            BrowserMainScreenType.view => _viewMenuBottomPosition,
            _ => 0,
          },
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
              ),
              crossFadeState: _type == BrowserMainScreenType.list
                  ? CrossFadeState.showFirst
                  : CrossFadeState.showSecond,
              duration: const Duration(milliseconds: 250),
            ),
          ),
        );
      },
    );
  }

  void _handleType() {
    setState(() {
      _type = widget.typeState.value;
    });
  }
}
