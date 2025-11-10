import 'dart:io';

import 'package:app/core/wm/not_null_listenable_state.dart';
import 'package:app/feature/browser/data/tabs/browser_tab.dart';
import 'package:app/feature/browser/screens/main/widgets/control_panels/background_blur.dart';
import 'package:app/feature/browser/screens/main/widgets/control_panels/navigation_panel/navigation_panel.dart';
import 'package:app/feature/browser/screens/main/widgets/control_panels/toolbar/toolbar.dart';
import 'package:app/utils/types/fuction_types.dart';
import 'package:elementary_helper/elementary_helper.dart';
import 'package:flutter/material.dart';
import 'package:ui_components_lib/v2/ui_components_lib_v2.dart';

class BrowserPageControlPanel extends StatelessWidget {
  const BrowserPageControlPanel({
    required this.menuUrlPanelWidth,
    required this.urlWidth,
    required this.onPressedTabs,
    required this.onPressedDotsPressed,
    required this.onPressedCurrentUrlMenu,
    required this.onPressedRefresh,
    required this.onEditingCompleteUrl,
    required this.urlSliderPageController,
    required this.tabsState,
    required this.onPageChanged,
    super.key,
  });

  final double menuUrlPanelWidth;
  final double urlWidth;
  final VoidCallback onPressedTabs;
  final VoidCallback onPressedDotsPressed;
  final ValueChanged<String> onPressedCurrentUrlMenu;
  final ValueChanged<String> onPressedRefresh;
  final DoubleValueCallback<String, String> onEditingCompleteUrl;
  final PageController urlSliderPageController;
  final ListenableState<List<NotNullListenableState<BrowserTab>>?> tabsState;
  final ValueChanged<int> onPageChanged;

  static const minHeight =
      BrowserNavigationPanel.height + Toolbar.height + DimensSizeV2.d8;

  @override
  Widget build(BuildContext context) {
    return BrowserMenuBackgroundBlur(
      blurHeight: minHeight,
      child: Padding(
        padding: const EdgeInsets.only(top: DimensSizeV2.d8),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            BrowserNavigationPanel(
              panelWidth: menuUrlPanelWidth,
              urlWidth: urlWidth,
              urlSliderController: urlSliderPageController,
              tabsState: tabsState,
              onPressedCurrentUrlMenu: onPressedCurrentUrlMenu,
              onPressedRefresh: onPressedRefresh,
              onEditingCompleteUrl: onEditingCompleteUrl,
              onPageChanged: onPageChanged,
            ),
            const _Space(),
            Toolbar(
              onPressedTabs: onPressedTabs,
              onPressedDotsPressed: onPressedDotsPressed,
            ),
          ],
        ),
      ),
    );
  }
}

class _Space extends StatelessWidget {
  const _Space();

  static const _menuHeight =
      BrowserNavigationPanel.height + Toolbar.height - DimensSizeV2.d8;

  @override
  Widget build(BuildContext context) {
    final bottom =
        MediaQuery.of(context).viewInsets.bottom -
        _menuHeight -
        (Platform.isIOS ? DimensSizeV2.d32 : 0);

    return SizedBox(width: double.infinity, height: bottom > 0 ? bottom : 0);
  }
}
