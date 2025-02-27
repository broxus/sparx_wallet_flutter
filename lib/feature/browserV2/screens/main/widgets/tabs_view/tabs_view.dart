import 'package:app/feature/browserV2/data/tabs_data.dart';
import 'package:app/feature/browserV2/screens/main/widgets/browser_web_tab/browser_web_tab.dart';
import 'package:elementary_helper/elementary_helper.dart';
import 'package:flutter/material.dart';
import 'package:flutter_inappwebview/flutter_inappwebview.dart';

class BrowserTabsView extends StatelessWidget {
  const BrowserTabsView({
    required this.tabsState,
    required this.onCreate,
    required this.onDispose,
    super.key,
  });

  final ListenableState<BrowserTabsCollection> tabsState;
  final void Function(String tabId, InAppWebViewController controller) onCreate;
  final ValueChanged<String> onDispose;

  @override
  Widget build(BuildContext context) {
    return StateNotifierBuilder<BrowserTabsCollection?>(
      listenableState: tabsState,
      builder: (_, BrowserTabsCollection? data) {
        if (data == null) {
          return const SizedBox.shrink();
        }
        return PageView.builder(
          itemCount: data.count,
          itemBuilder: (_, int index) {
            return BrowserWebTab(
              key: ValueKey(data.list[index].id),
              tab: data.list[index],
              onCreate: (controller) => onCreate(
                data.list[index].id,
                controller,
              ),
              onDispose: () => onDispose(data.list[index].id),
            );
          },
        );
      },
    );
  }
}
