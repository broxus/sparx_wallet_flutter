import 'package:app/feature/browserV2/data/tabs_data.dart';
import 'package:app/feature/browserV2/screens/main/widgets/browser_web_tab/browser_tab.dart';
import 'package:elementary_helper/elementary_helper.dart';
import 'package:flutter/material.dart';
import 'package:flutter_inappwebview/flutter_inappwebview.dart';

class BrowserTabsView extends StatelessWidget {
  const BrowserTabsView({
    required this.width,
    required this.viewVisibleState,
    required this.scrollController,
    required this.progressController,
    required this.tabsState,
    required this.onCreate,
    required this.onScrollChanged,
    required this.onDispose,
    super.key,
  });

  final double width;
  final ListenableState<bool> viewVisibleState;
  final ListenableState<BrowserTabsCollection> tabsState;
  final ScrollController scrollController;
  final AnimationController progressController;
  final void Function(String tabId, InAppWebViewController controller) onCreate;
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
                    onCreate: (controller) => onCreate(
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
