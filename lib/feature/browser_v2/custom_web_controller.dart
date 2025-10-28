import 'dart:typed_data';

import 'package:app/feature/browser_v2/data/browser_uri.dart';
import 'package:app/utils/common_utils.dart';
import 'package:flutter_inappwebview/flutter_inappwebview.dart';
import 'package:logging/logging.dart';
import 'package:nekoton_webview/nekoton_webview.dart';

class CustomWebViewController {
  CustomWebViewController(this._nativeController);

  static final _log = Logger('CustomWebViewController');

  final InAppWebViewController _nativeController;

  bool _isDisposed = false;

  bool get isDisposed => _isDisposed;

  void dispose() {
    try {
      _nativeController.dispose();
      _isDisposed = true;
    } catch (_) {}
  }

  void transactionsFound(TransactionsFoundEvent event) {
    _safeCall(() {
      return _nativeController.transactionsFound(event);
    });
  }

  void contractStateChanged(ContractStateChangedEvent event) {
    _safeCall(() => _nativeController.contractStateChanged(event));
  }

  void networkChanged(NetworkChangedEvent event) {
    _safeCall(() {
      return _nativeController.networkChanged(event);
    });
  }

  Future<void> loadUrl({
    required URLRequest urlRequest,
    BrowserUri? allowingReadAccessTo,
  }) async {
    return _safeCall(
      () => _nativeController.loadUrl(
        urlRequest: urlRequest,
        allowingReadAccessTo: allowingReadAccessTo,
      ),
    );
  }

  Future<void> loadData({
    required String data,
    String mimeType = 'text/html',
    String encoding = 'utf8',
    WebUri? baseUrl,
    WebUri? historyUrl,
    WebUri? allowingReadAccessTo,
  }) {
    return _safeCall(
      () => _nativeController.loadData(
        data: data,
        mimeType: mimeType,
        encoding: encoding,
        baseUrl: baseUrl,
        historyUrl: historyUrl,
        allowingReadAccessTo: allowingReadAccessTo,
      ),
    );
  }

  void loggedOut() {
    _safeCall(_nativeController.loggedOut);
  }

  Future<WebUri?> getUrl() {
    return _safeCall<WebUri?>(_nativeController.getUrl);
  }

  Future<void> reload() {
    return _safeCall(_nativeController.reload);
  }

  Future<Uint8List?> takeScreenshot({
    ScreenshotConfiguration? screenshotConfiguration,
  }) {
    return _safeCall<Uint8List?>(() async {
      try {
        return _nativeController.takeScreenshot(
          screenshotConfiguration: screenshotConfiguration,
        );
      } catch (e, s) {
        _log.severe('InAppWebViewController nativeController', e, s);
        return null;
      }
    });
  }

  Future<bool?> canGoBack() {
    return _safeCall<bool>(_nativeController.canGoBack);
  }

  Future<bool?> canGoForward() {
    return _safeCall<bool>(_nativeController.canGoForward);
  }

  Future<void> goBack() {
    return _safeCall(_nativeController.goBack);
  }

  Future<void> goForward() async {
    return _safeCall(_nativeController.goForward);
  }

  Future<void> permissionsChanged(PermissionsChangedEvent event) {
    return _safeCall(() => _nativeController.permissionsChanged(event));
  }

  Future<void> messageStatusUpdated(MessageStatusUpdatedEvent event) {
    return _safeCall(() => _nativeController.messageStatusUpdated(event));
  }

  Future<void> initNekotonProvider({required ProviderApi providerApi}) {
    return _safeCall(
      () => _nativeController.initNekotonProvider(providerApi: providerApi),
    );
  }

  Future<void> addUserScript({required UserScript userScript}) {
    return _safeCall(
      () => _nativeController.addUserScript(userScript: userScript),
    );
  }

  void addJavaScriptHandler({
    required String handlerName,
    required JavaScriptHandlerCallback callback,
  }) {
    _safeCall(
      () async => _nativeController.addJavaScriptHandler(
        handlerName: handlerName,
        callback: callback,
      ),
    );
  }

  Future<T?> _safeCall<T>(Future<T> Function() callback) async {
    if (_isDisposed) {
      return null;
    }

    return tryWrapper<T>(
      callback,
      onCatch: (Object e, StackTrace s) async {
        _log.severe('Exception:', e, s);
      },
    );
  }
}
