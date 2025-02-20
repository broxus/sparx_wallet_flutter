import 'dart:collection';

import 'package:app/feature/browserV2/models/tab/browser_tab.dart';
import 'package:app/feature/browserV2/screens/tabs/widgets/browser_tab_view/browser_tab_view_wm.dart';
import 'package:elementary/elementary.dart';
import 'package:elementary_helper/elementary_helper.dart';
import 'package:flutter/material.dart';
import 'package:flutter_inappwebview/flutter_inappwebview.dart';

class BrowserTabView extends ElementaryWidget<BrowserTabViewWidgetModel> {
  BrowserTabView({
    required this.tab,
    Key? key,
    WidgetModelFactory<BrowserTabViewWidgetModel>? wmFactory,
  }) : super(
          wmFactory ??
              (ctx) => defaultBrowserTabViewWidgetModelFactory(
                    ctx,
                    tabId: tab.id,
                  ),
          key: key,
        );

  final BrowserTab tab;

  @override
  Widget build(BrowserTabViewWidgetModel wm) {
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
                injectionTime: UserScriptInjectionTime.AT_DOCUMENT_START,
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
    );
  }
}
