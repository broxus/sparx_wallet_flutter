import 'package:app/core/wm/not_null_listenable_state.dart';
import 'package:app/feature/browser_v2/data/tabs/browser_tab.dart';
import 'package:app/feature/browser_v2/screens/main/widgets/control_panels/navigation_panel/address_bar.dart';
import 'package:app/utils/types/fuction_types.dart';
import 'package:elementary_helper/elementary_helper.dart';
import 'package:flutter/material.dart';
import 'package:ui_components_lib/v2/ui_components_lib_v2.dart';

class BrowserNavigationPanel extends StatefulWidget {
  const BrowserNavigationPanel({
    required this.panelWidth,
    required this.urlWidth,
    required this.urlSliderController,
    required this.tabsState,
    required this.onPressedCurrentUrlMenu,
    required this.onPressedRefresh,
    required this.onEditingCompleteUrl,
    required this.onPageChanged,
    super.key,
  });

  static const height = DimensSizeV2.d48;

  final double panelWidth;
  final double urlWidth;
  final PageController urlSliderController;
  final ListenableState<List<NotNullListenableState<BrowserTab>>?> tabsState;
  final ValueChanged<String> onPressedCurrentUrlMenu;
  final ValueChanged<String> onPressedRefresh;
  final DoubleValueCallback<String, String> onEditingCompleteUrl;
  final ValueChanged<int> onPageChanged;

  @override
  State<BrowserNavigationPanel> createState() =>
      _BrowserTabViewMenuUrlPanelState();
}

class _BrowserTabViewMenuUrlPanelState extends State<BrowserNavigationPanel> {
  late final _pageViewController = widget.urlSliderController;
  late final _onPageChanged = widget.onPageChanged;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: widget.panelWidth,
      height: BrowserNavigationPanel.height,
      child: StateNotifierBuilder<List<NotNullListenableState<BrowserTab>>?>(
        listenableState: widget.tabsState,
        builder: (_, List<NotNullListenableState<BrowserTab>>? list) {
          if (list == null) {
            return const SizedBox.shrink();
          }

          return PageView.builder(
            physics: const ClampingScrollPhysics(),
            controller: _pageViewController,
            itemCount: list.length,
            onPageChanged: _onPageChanged,
            itemBuilder: (_, int index) {
              return BrowserAddressBar(
                key: ValueKey(list[index].value.id),
                width: widget.urlWidth,
                listenable: list[index],
                onPressedCurrentUrlMenu: widget.onPressedCurrentUrlMenu,
                onPressedRefresh: widget.onPressedRefresh,
                onEditingComplete: widget.onEditingCompleteUrl,
              );
            },
          );
        },
      ),
    );
  }
}
