import 'package:app/feature/browserV2/data/tabs_data.dart';
import 'package:app/feature/browserV2/screens/main/widgets/control_panel/background_blur.dart';
import 'package:app/feature/browserV2/screens/main/widgets/control_panel/menu_view_tab/url_panel.dart';
import 'package:app/feature/browserV2/screens/main/widgets/control_panel/nav_panel/nav_panel.dart';
import 'package:app/utils/types/fuction_types.dart';
import 'package:elementary_helper/elementary_helper.dart';
import 'package:flutter/material.dart';
import 'package:ui_components_lib/v2/ui_components_lib_v2.dart';

class BrowserTabViewMenu extends StatelessWidget {
  const BrowserTabViewMenu({
    required this.menuUrlPanelWidth,
    required this.urlWidth,
    required this.onPressedTabs,
    required this.onPressedUrlMenu,
    required this.onPressedRefresh,
    required this.onEditingCompleteUrl,
    required this.urlSliderController,
    required this.tabsState,
    super.key,
  });

  final double menuUrlPanelWidth;
  final double urlWidth;
  final VoidCallback onPressedTabs;
  final ValueChanged<String> onPressedUrlMenu;
  final ValueChanged<String> onPressedRefresh;
  final DoubleValueCallback<String, String> onEditingCompleteUrl;
  final ScrollController urlSliderController;
  final ListenableState<BrowserTabsCollection> tabsState;

  static const minHeight = BrowserTabViewMenuUrlPanel.height +
      BrowserTabViewMenuNavPanel.height +
      DimensSizeV2.d8;

  @override
  Widget build(BuildContext context) {
    return BrowserMenuBackgroundBlur(
      child: Padding(
        padding: const EdgeInsets.only(top: DimensSizeV2.d8),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            BrowserTabViewMenuUrlPanel(
              panelWidth: menuUrlPanelWidth,
              urlWidth: urlWidth,
              controller: urlSliderController,
              tabsState: tabsState,
              onPressedUrlMenu: onPressedUrlMenu,
              onPressedRefresh: onPressedRefresh,
              onEditingCompleteUrl: onEditingCompleteUrl,
            ),
            const _Space(),
            BrowserTabViewMenuNavPanel(
              onPressedTabs: onPressedTabs,
            ),
          ],
        ),
      ),
    );
  }
}

class _Space extends StatelessWidget {
  const _Space();

  static const _menuHeight = BrowserTabViewMenuUrlPanel.height +
      BrowserTabViewMenuNavPanel.height -
      DimensSizeV2.d8;

  @override
  Widget build(BuildContext context) {
    final bottom = MediaQuery.of(context).viewInsets.bottom - _menuHeight;

    return AnimatedSize(
      duration: const Duration(milliseconds: 250),
      child: SizedBox(
        width: double.infinity,
        height: bottom > 0 ? bottom : 0,
      ),
    );
  }
}
