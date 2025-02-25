import 'dart:collection';

import 'package:app/feature/browserV2/models/tab/browser_tab.dart';
import 'package:app/feature/browserV2/screens/browser_view/widgets/browser_web_tab/browser_web_tab_wm.dart';
import 'package:app/feature/browserV2/screens/browser_view/widgets/start/browser_start_view.dart';
import 'package:elementary/elementary.dart';
import 'package:elementary_helper/elementary_helper.dart';
import 'package:flutter/material.dart';
import 'package:flutter_inappwebview/flutter_inappwebview.dart';

class BrowserWebTab extends ElementaryWidget<BrowserWebTabWidgetModel> {
  BrowserWebTab({
    required this.tab,
    Key? key,
    WidgetModelFactory<BrowserWebTabWidgetModel>? wmFactory,
  }) : super(
          wmFactory ??
              (ctx) => defaultBrowserWebTabWidgetModelFactory(
                    ctx,
                    tabId: tab.id,
                  ),
          key: key,
        );

  final BrowserTab tab;

  @override
  Widget build(BrowserWebTabWidgetModel wm) {
    return StateNotifierBuilder(
      listenableState: wm.webViewVisibleState,
      builder: (_, bool? isVisible) {
        isVisible ??= false;
        return Stack(
          children: [
            Opacity(
              opacity: isVisible ? 1 : 0,
              child: EntityStateNotifierBuilder<String?>(
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
                    onOverScrolled: wm.onOverScrolled,
                    onScrollChanged: wm.onScrollChanged,
                    onWebViewCreated: wm.onWebViewCreated,
                    onLoadStart: wm.onLoadStart,
                    onLoadStop: wm.onLoadStop,
                    onLoadResource: wm.onLoadResource,
                    onReceivedError: wm.onReceivedError,
                    onReceivedHttpError: wm.onReceivedHttpError,
                    onTitleChanged: wm.onTitleChanged,
                    onReceivedHttpAuthRequest: wm.onReceivedHttpAuthRequest,
                    shouldOverrideUrlLoading: wm.shouldOverrideUrlLoading,
                  );
                },
              ),
            ),
            if (!isVisible) const BrowserStartView(),
          ],
        );
      },
    );
  }
}
