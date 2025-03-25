import 'package:app/feature/browser_v2/data/tabs_data.dart';
import 'package:app/feature/browser_v2/screens/main/widgets/page/browser_page.dart';
import 'package:elementary_helper/elementary_helper.dart';
import 'package:flutter/material.dart';
import 'package:flutter_inappwebview/flutter_inappwebview.dart';

class BrowserPagesView extends StatelessWidget {
  const BrowserPagesView({
    required this.width,
    required this.viewVisibleState,
    required this.scrollController,
    required this.progressController,
    required this.tabsState,
    required this.onCreateWebViewController,
    required this.onScrollChanged,
    required this.onDispose,
    super.key,
  });

  final double width;
  final ListenableState<bool> viewVisibleState;
  final ListenableState<BrowserTabsCollection> tabsState;
  final ScrollController scrollController;
  final AnimationController progressController;
  final void Function(
    String tabId,
    InAppWebViewController controller,
  ) onCreateWebViewController;
  final ValueChanged<int> onScrollChanged;
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
          child: StateNotifierBuilder<BrowserTabsCollection?>(
            listenableState: tabsState,
            builder: (_, BrowserTabsCollection? data) {
              if (data == null) {
                return const SizedBox.shrink();
              }

              return ListView.builder(
                scrollDirection: Axis.horizontal,
                controller: scrollController,
                physics: const NeverScrollableScrollPhysics(),
                itemCount: data.count,
                itemBuilder: (_, int index) {
                  return BrowserPage(
                    key: ValueKey(data.list[index].id),
                    progressController: progressController,
                    width: width,
                    tab: data.list[index],
                    onCreate: (controller) => onCreateWebViewController(
                      data.list[index].id,
                      controller,
                    ),
                    onScrollChanged: onScrollChanged,
                    onDispose: () => onDispose(data.list[index].id),
                  );
                },
              );
            },
          ),
        );
      },
    );
  }
}
