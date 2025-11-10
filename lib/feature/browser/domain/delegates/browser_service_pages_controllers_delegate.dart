import 'dart:collection';

import 'package:app/feature/browser/custom_web_controller.dart';
import 'package:app/feature/browser/domain/delegates/browser_base_delegate.dart';
import 'package:flutter_inappwebview/flutter_inappwebview.dart';
import 'package:injectable/injectable.dart';
import 'package:nekoton_webview/nekoton_webview.dart';

@injectable
class BrowserServicePagesControllersDelegate implements BrowserDelegate {
  final _controllers = HashMap<String, CustomWebViewController>();

  void setController(String tabId, CustomWebViewController controller) {
    _controllers[tabId] = controller;
  }

  void removeController(String tabId) => _controllers.remove(tabId);

  void refresh(String tabId) => _controllers[tabId]?.reload();

  void closeAllControllers() {
    _controllers
      ..forEach((k, c) => c.dispose())
      ..clear();
  }

  Future<void> permissionsChanged(
    String tabId,
    PermissionsChangedEvent event,
  ) async {
    return _controllers[tabId]?.permissionsChanged(event);
  }

  Future<void> loadUrl(String tabId, Uri uri) {
    return Future(() {
      _controllers[tabId]?.loadUrl(
        urlRequest: URLRequest(url: BrowserUri.uri(uri)),
      );
    });
  }

  Future<void> loadData(
    String tabId,
    String html, {
    WebUri? baseUrl,
    WebUri? historyUrl,
  }) {
    return Future(() {
      _controllers[tabId]?.loadData(
        data: html,
        baseUrl: baseUrl,
        historyUrl: historyUrl,
      );
    });
  }

  Future<void> goBack(String tabId) async => _controllers[tabId]?.goBack();

  Future<void> goForward(String tabId) async =>
      await _controllers[tabId]?.goForward();

  Future<bool> checkCanGoBack(String tabId) async =>
      (await _controllers[tabId]?.canGoBack()) ?? false;

  Future<bool> checkCanGoForward(String tabId) async =>
      (await _controllers[tabId]?.canGoForward()) ?? false;
}
