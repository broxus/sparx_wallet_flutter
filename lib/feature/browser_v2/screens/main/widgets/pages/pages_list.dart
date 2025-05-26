import 'package:app/feature/browser_v2/custom_web_controller.dart';
import 'package:app/feature/browser_v2/data/tabs/browser_tab.dart';
import 'package:app/feature/browser_v2/screens/main/widgets/pages/page/browser_page.dart';
import 'package:elementary_helper/elementary_helper.dart';
import 'package:flutter/material.dart';
import 'package:ui_components_lib/v2/ui_components_lib_v2.dart';

class BrowserPagesView extends StatelessWidget {
  const BrowserPagesView({
    required this.width,
    required this.viewVisibleState,
    required this.scrollController,
    required this.paddingPageAnimation,
    required this.onLoadingProgressChanged,
    required this.tabsState,
    required this.onCreateWebViewController,
    required this.onWebPageScrollChanged,
    required this.onDispose,
    super.key,
  });

  final double width;
  final ListenableState<bool> viewVisibleState;
  final ListenableState<List<BrowserTab>?> tabsState;
  final ScrollController scrollController;
  final Animation<double> paddingPageAnimation;
  final ValueChanged<int> onLoadingProgressChanged;
  final void Function(
    String tabId,
    CustomWebViewController controller,
  ) onCreateWebViewController;
  final ValueChanged<int> onWebPageScrollChanged;
  final ValueChanged<String> onDispose;

  @override
  Widget build(BuildContext context) {
    return StateNotifierBuilder<bool>(
      listenableState: viewVisibleState,
      builder: (_, bool? isVisible) {
        return Visibility(
          visible: isVisible ?? false,
          maintainState: true,
          maintainSize: true,
          maintainAnimation: true,
          child: ColoredBox(
            color: context.themeStyleV2.colors.background1,
            child: Column(
              children: [
                Flexible(
                  child: StateNotifierBuilder<List<BrowserTab>?>(
                    listenableState: tabsState,
                    builder: (_, List<BrowserTab>? tabs) {
                      if (tabs == null) {
                        return const SizedBox.shrink();
                      }

                      return ListView.builder(
                        scrollDirection: Axis.horizontal,
                        controller: scrollController,
                        physics: const NeverScrollableScrollPhysics(),
                        itemCount: tabs.length,
                        itemBuilder: (_, int index) {
                          return BrowserPage(
                            key: ValueKey(tabs[index].id),
                            onLoadingProgressChanged: onLoadingProgressChanged,
                            width: width,
                            tab: tabs[index],
                            onCreate: (controller) => onCreateWebViewController(
                              tabs[index].id,
                              controller,
                            ),
                            onWebPageScrollChanged: onWebPageScrollChanged,
                            onDispose: () => onDispose(tabs[index].id),
                          );
                        },
                      );
                    },
                  ),
                ),
                AnimatedBuilder(
                  animation: paddingPageAnimation,
                  builder: (BuildContext context, Widget? child) {
                    return SizedBox(
                      height: paddingPageAnimation.value,
                    );
                  },
                ),
              ],
            ),
          ),
        );
      },
    );
  }
}
