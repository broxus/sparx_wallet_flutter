import 'package:app/core/wm/not_null_listenable_state.dart';
import 'package:app/feature/browser/custom_web_controller.dart';
import 'package:app/feature/browser/data/tabs/browser_tab.dart';
import 'package:app/feature/browser/screens/main/widgets/pages/page/browser_page.dart';
import 'package:elementary_helper/elementary_helper.dart';
import 'package:flutter/material.dart';
import 'package:ui_components_lib/v2/ui_components_lib_v2.dart';

class BrowserPagesView extends StatelessWidget {
  const BrowserPagesView({
    required this.width,
    required this.viewVisibleState,
    required this.viewTabScrollController,
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
  final ListenableState<List<NotNullListenableState<BrowserTab>>?> tabsState;
  final ScrollController viewTabScrollController;
  final Animation<double> paddingPageAnimation;
  final ValueChanged<int> onLoadingProgressChanged;
  final void Function(String tabId, CustomWebViewController controller)
  onCreateWebViewController;
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
            color: context.themeStyleV2.colors.background0,
            child: Column(
              children: [
                Flexible(
                  child:
                      StateNotifierBuilder<
                        List<NotNullListenableState<BrowserTab>>?
                      >(
                        listenableState: tabsState,
                        builder:
                            (
                              _,
                              List<NotNullListenableState<BrowserTab>>? list,
                            ) {
                              if (list == null) {
                                return const SizedBox.shrink();
                              }

                              return ListView.builder(
                                scrollDirection: Axis.horizontal,
                                controller: viewTabScrollController,
                                physics: const NeverScrollableScrollPhysics(),
                                itemCount: list.length,
                                itemBuilder: (_, int index) {
                                  return BrowserPage(
                                    key: ValueKey(list[index].value.id),
                                    onLoadingProgressChanged:
                                        onLoadingProgressChanged,
                                    width: width,
                                    tabState: list[index],
                                    onCreate: (controller) =>
                                        onCreateWebViewController(
                                          list[index].value.id,
                                          controller,
                                        ),
                                    onWebPageScrollChanged:
                                        onWebPageScrollChanged,
                                    onDispose: () =>
                                        onDispose(list[index].value.id),
                                  );
                                },
                              );
                            },
                      ),
                ),
                AnimatedBuilder(
                  animation: paddingPageAnimation,
                  builder: (BuildContext context, Widget? child) {
                    return SizedBox(height: paddingPageAnimation.value);
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
