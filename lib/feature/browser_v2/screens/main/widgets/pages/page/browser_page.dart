import 'package:app/core/wm/not_null_listenable_state.dart';
import 'package:app/core/wm/custom_wm.dart';
import 'package:app/feature/browser_v2/custom_web_controller.dart';
import 'package:app/feature/browser_v2/data/tabs/browser_tab.dart';
import 'package:app/feature/browser_v2/screens/main/widgets/pages/browser_start_view.dart';
import 'package:app/feature/browser_v2/screens/main/widgets/pages/page/browser_page_wm.dart';
import 'package:elementary_helper/elementary_helper.dart';
import 'package:flutter/material.dart';
import 'package:flutter_inappwebview/flutter_inappwebview.dart';
import 'package:ui_components_lib/v2/ui_components_lib_v2.dart';

class BrowserPage extends InjectedElementaryWidget<BrowserPageWidgetModel> {
  BrowserPage({
    required ValueChanged<CustomWebViewController> onCreate,
    required ValueChanged<int> onWebPageScrollChanged,
    required VoidCallback onDispose,
    required ValueChanged<int> onLoadingProgressChanged,
    required this.width,
    required NotNullListenableState<BrowserTab> listenable,
    super.key,
  }) : super(
          param1: BrowserPageWmParams(
            tabState: listenable,
            onCreate: onCreate,
            onWebPageScrollChanged: onWebPageScrollChanged,
            onDispose: onDispose,
            onLoadingProgressChanged: onLoadingProgressChanged,
          ),
        );

  final double width;

  @override
  Widget build(BrowserPageWidgetModel wm) {
    return _Container(
      width: width,
      child: Stack(
        children: [
          StateNotifierBuilder(
            listenableState: wm.isNeedCreateWebViewState,
            builder: (_, bool? isNeedCreate) {
              isNeedCreate ??= false;

              if (!isNeedCreate) return const SizedBox.shrink();

              return InAppWebView(
                pullToRefreshController: wm.pullToRefreshController,
                initialSettings: wm.initialSettings,
                onScrollChanged: wm.onWebPageScrollChanged,
                onWebViewCreated: wm.onWebViewCreated,
                onLoadStart: wm.onWebPageLoadStart,
                onLoadStop: wm.onWebPageLoadStop,
                onLoadResource: wm.onWebPageLoadResource,
                onReceivedError: wm.onWebPageReceivedError,
                onReceivedHttpError: wm.onWebPageReceivedHttpError,
                onTitleChanged: wm.onWebPageTitleChanged,
                onReceivedHttpAuthRequest: wm.onWebPageReceivedHttpAuthRequest,
                shouldOverrideUrlLoading: wm.onWebPageShouldOverrideUrlLoading,
              );
            },
          ),
          StateNotifierBuilder(
            listenableState: wm.isShowStartViewState,
            builder: (_, bool? isNeedShow) {
              return isNeedShow ?? false
                  ? const BrowserStartView()
                  : const SizedBox.shrink();
            },
          ),
        ],
      ),
    );
  }
}

class _Container extends StatelessWidget {
  const _Container({
    required this.width,
    required this.child,
  });

  final double width;
  final Widget child;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: width,
      height: double.infinity,
      child: ColoredBox(
        color: context.themeStyleV2.colors.background0,
        child: child,
      ),
    );
  }
}
