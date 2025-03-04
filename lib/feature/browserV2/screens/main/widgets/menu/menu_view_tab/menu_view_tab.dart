import 'package:app/feature/browserV2/data/tabs_data.dart';
import 'package:app/feature/browserV2/screens/main/widgets/menu/background_blur.dart';
import 'package:app/feature/browserV2/screens/main/widgets/menu/menu_view_tab/nav_panel.dart';
import 'package:app/feature/browserV2/screens/main/widgets/menu/menu_view_tab/url_panel.dart';
import 'package:app/utils/types/fuction_types.dart';
import 'package:elementary_helper/elementary_helper.dart';
import 'package:flutter/material.dart';
import 'package:ui_components_lib/v2/ui_components_lib_v2.dart';

class BrowserTabViewMenu extends StatelessWidget {
  const BrowserTabViewMenu({
    required this.menuUrlPanelWidth,
    required this.urlWidth,
    required this.onPressedBackPressed,
    required this.onPressedForwardPressed,
    required this.onPressedDotsPressed,
    required this.onPressedBook,
    required this.onPressedTabs,
    required this.onPressedUrlMenu,
    required this.onEditingCompleteUrl,
    required this.urlSliderController,
    required this.tabsState,
    super.key,
  });

  final double menuUrlPanelWidth;
  final double urlWidth;
  final VoidCallback onPressedBackPressed;
  final VoidCallback onPressedForwardPressed;
  final VoidCallback onPressedDotsPressed;
  final VoidCallback onPressedBook;
  final VoidCallback onPressedTabs;
  final ValueChanged<String> onPressedUrlMenu;
  final DoubleValueCallback<String, String> onEditingCompleteUrl;
  final ScrollController urlSliderController;
  final ListenableState<BrowserTabsCollection> tabsState;

  static const _urlMenuHeight = DimensSizeV2.d48;
  static const _controlMenuHeight = DimensSizeV2.d48;
  static const _topPadding = DimensSizeV2.d8;
  static const height = _urlMenuHeight + _controlMenuHeight + _topPadding;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: height,
      child: BrowserMenuBackgroundBlur(
        child: Padding(
          padding: const EdgeInsets.only(top: _topPadding),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              BrowserTabViewMenuUrlPanel(
                panelWidth: menuUrlPanelWidth,
                urlWidth: urlWidth,
                height: _urlMenuHeight,
                controller: urlSliderController,
                tabsState: tabsState,
                onPressedUrlMenu: onPressedUrlMenu,
                onEditingCompleteUrl: onEditingCompleteUrl,
              ),
              BrowserTabViewMenuNavPanel(
                height: _controlMenuHeight,
                onPressedBackPressed: onPressedBackPressed,
                onPressedForwardPressed: onPressedForwardPressed,
                onPressedDotsPressed: onPressedDotsPressed,
                onPressedBook: onPressedBook,
                onPressedTabs: onPressedTabs,
              ),
            ],
          ),
        ),
      ),
    );
  }
}
