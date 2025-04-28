import 'dart:typed_data';

import 'package:flutter_inappwebview/flutter_inappwebview.dart';
import 'package:nekoton_webview/nekoton_webview.dart';

class CustomWebViewController {
  CustomWebViewController(this._nativeController);

  final InAppWebViewController _nativeController;

  bool _isDisposed = false;

  bool get isDisposed => _isDisposed;

  void dispose() {
    try {
      _nativeController.dispose();
      _isDisposed = true;
    } catch (_) {}
  }

  Future<void> transactionsFound(TransactionsFoundEvent event) async {
    if (_isDisposed) {
      return;
    }

    try {
      return await _nativeController.transactionsFound(
        event,
      );
    } catch (_) {}
  }

  Future<void> contractStateChanged(ContractStateChangedEvent event) async {
    if (_isDisposed) {
      return;
    }

    try {
      await _nativeController.contractStateChanged(event);
    } catch (_) {}
  }

  Future<void> networkChanged(NetworkChangedEvent event) async {
    if (_isDisposed) {
      return;
    }

    try {
      return await _nativeController.networkChanged(event);
    } catch (_) {}
  }

  Future<void> loadUrl({
    required URLRequest urlRequest,
    WebUri? allowingReadAccessTo,
  }) async {
    if (_isDisposed) {
      return;
    }

    try {
      return await _nativeController.loadUrl(
        urlRequest: urlRequest,
        allowingReadAccessTo: allowingReadAccessTo,
      );
    } catch (_) {}
  }

  Future<void> loggedOut() async {
    if (_isDisposed) {
      return;
    }

    try {
      return await _nativeController.loggedOut();
    } catch (_) {}
  }

  Future<WebUri?> getUrl() async {
    if (_isDisposed) {
      return null;
    }

    try {
      return await _nativeController.getUrl();
    } catch (_) {
      return null;
    }
  }

  Future<void> reload() async {
    if (_isDisposed) {
      return;
    }

    try {
      return await _nativeController.reload();
    } catch (_) {}
  }

  Future<Uint8List?> takeScreenshot({
    ScreenshotConfiguration? screenshotConfiguration,
  }) async {
    if (_isDisposed) {
      return null;
    }

    try {
      return _nativeController.takeScreenshot(
        screenshotConfiguration: screenshotConfiguration,
      );
    } catch (_) {
      return null;
    }
  }

  Future<bool> canGoBack() async {
    if (_isDisposed) {
      return false;
    }

    try {
      return await _nativeController.canGoBack();
    } catch (_) {
      return false;
    }
  }

  Future<bool> canGoForward() async {
    if (_isDisposed) {
      false;
    }

    try {
      return await _nativeController.canGoForward();
    } catch (_) {
      return false;
    }
  }

  Future<void> goBack() async {
    if (_isDisposed) {
      return;
    }

    try {
      return await _nativeController.goBack();
    } catch (_) {}
  }

  Future<void> goForward() async {
    if (_isDisposed) {
      return;
    }

    try {
      return await _nativeController.goForward();
    } catch (_) {}
  }

  Future<void> permissionsChanged(PermissionsChangedEvent event) async {
    if (_isDisposed) {
      return;
    }

    try {
      return await _nativeController.permissionsChanged(event);
    } catch (_) {}
  }

  Future<void> messageStatusUpdated(MessageStatusUpdatedEvent event) async {
    if (_isDisposed) {
      return;
    }

    try {
      return await _nativeController.messageStatusUpdated(event);
    } catch (_) {}
  }

  Future<void> initNekotonProvider({
    required ProviderApi providerApi,
  }) async {
    if (_isDisposed) {
      return;
    }

    try {
      return await _nativeController.initNekotonProvider(
        providerApi: providerApi,
      );
    } catch (_) {}
  }
}
