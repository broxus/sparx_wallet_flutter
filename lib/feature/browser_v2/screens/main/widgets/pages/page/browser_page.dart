import 'dart:collection';

import 'package:app/feature/browser_v2/models/tab/browser_tab.dart';
import 'package:app/feature/browser_v2/screens/main/widgets/pages/browser_start_view.dart';
import 'package:app/feature/browser_v2/screens/main/widgets/pages/page/browser_page_wm.dart';
import 'package:elementary/elementary.dart';
import 'package:elementary_helper/elementary_helper.dart';
import 'package:flutter/material.dart';
import 'package:flutter_inappwebview/flutter_inappwebview.dart';
import 'package:ui_components_lib/v2/ui_components_lib_v2.dart';

class BrowserPage extends ElementaryWidget<BrowserPageWidgetModel> {
  BrowserPage({
    required this.tab,
    required this.width,
    required this.onCreate,
    required this.onWebPageScrollChanged,
    required this.onOverScrolled,
    required this.onDispose,
    required this.onLoadingProgressChanged,
    Key? key,
    WidgetModelFactory<BrowserPageWidgetModel>? wmFactory,
  }) : super(
          wmFactory ??
              (ctx) => defaultBrowserPageWidgetModelFactory(
                    ctx,
                    tabId: tab.id,
                  ),
          key: key,
        );

  final BrowserTab tab;
  final double width;
  final ValueChanged<InAppWebViewController> onCreate;
  final ValueChanged<int> onWebPageScrollChanged;
  final ValueChanged<int> onOverScrolled;
  final VoidCallback onDispose;
  final ValueChanged<double> onLoadingProgressChanged;

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

              if (!isNeedCreate) {
                return const SizedBox.shrink();
              }
              return EntityStateNotifierBuilder<String?>(
                listenableEntityState: wm.nekotonJsState,
                loadingBuilder: (_, __) => const SizedBox.shrink(),
                errorBuilder: (_, __, ___) => const SizedBox.shrink(),
                builder: (_, String? jsStr) {
                  return InAppWebView(
                    pullToRefreshController: wm.pullToRefreshController,
                    initialSettings: wm.initialSettings,
                    initialUserScripts: UnmodifiableListView<UserScript>([
                      if (jsStr != null)
                        UserScript(
                          source: jsStr,
                          injectionTime:
                              UserScriptInjectionTime.AT_DOCUMENT_START,
                        ),
                    ]),
                    onOverScrolled: wm.onWebPageOverScrolled,
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
