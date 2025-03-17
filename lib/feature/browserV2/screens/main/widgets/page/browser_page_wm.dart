import 'dart:async';

import 'package:app/core/error_handler_factory.dart';
import 'package:app/core/wm/custom_wm.dart';
import 'package:app/di/di.dart';
import 'package:app/feature/browser/bottom_sheets/browser_enter_basic_auth_creds_sheet.dart';
import 'package:app/feature/browserV2/models/browser_basic_auth_creds.dart';
import 'package:app/feature/browserV2/screens/main/widgets/page/browser_page.dart';
import 'package:app/feature/browserV2/screens/main/widgets/page/browser_page_model.dart';
import 'package:elementary/elementary.dart';
import 'package:elementary_helper/elementary_helper.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_inappwebview/flutter_inappwebview.dart';
import 'package:logging/logging.dart';
import 'package:ui_components_lib/ui_components_lib.dart';
import 'package:url_launcher/url_launcher.dart';

/// Factory method for creating [BrowserPageWidgetModel]
BrowserPageWidgetModel defaultBrowserPageWidgetModelFactory(
  BuildContext context, {
  required String tabId,
}) {
  return BrowserPageWidgetModel(
    BrowserPageModel(
      createPrimaryErrorHandler(context),
      tabId,
      inject(),
      inject(),
      inject(),
      inject(),
      inject(),
      inject(),
      inject(),
      inject(),
      inject(),
    ),
  );
}

/// [WidgetModel] для [BrowserPage]
class BrowserPageWidgetModel
    extends CustomWidgetModel<BrowserPage, BrowserPageModel>
    with AutomaticKeepAliveWidgetModelMixin {
  BrowserPageWidgetModel(
    super.model,
  );

  static const _allowSchemes = [
    'http',
    'https',
    'file',
    'chrome',
    'data',
    'javascript',
    'about',
  ];

  static const _customAppLinks = [
    'metamask.app.link',
    'app.tonkeeper.com',
  ];

  static final _log = Logger('BrowserTabView');

  final initialSettings = InAppWebViewSettings(
    applicationNameForUserAgent: 'SparXWalletBrowser',
    useShouldOverrideUrlLoading: true,
    isInspectable: kDebugMode,
  );

  late final pullToRefreshController = PullToRefreshController(
    settings: PullToRefreshSettings(
      color: colors.textSecondary,
    ),
    onRefresh: _onRefresh,
  );

  late final _isNeedCreateWebViewState = createNotifier<bool>(false);
  late final _isShowStartViewState =
      createNotifier<bool>(widget.tab.url.host.isEmpty);

  InAppWebViewController? _webViewController;

  ColorsPalette get colors => _theme.colors;

  ListenableState<bool> get isNeedCreateWebViewState =>
      _isNeedCreateWebViewState;

  ListenableState<bool> get isShowStartViewState => _isShowStartViewState;

  EntityValueListenable<String?> get nekotonJsState => model.nekotonJsState;

  ThemeStyle get _theme => context.themeStyle;

  String get _url => widget.tab.url.toString();

  bool get _isCreate => _isNeedCreateWebViewState.value ?? false;

  @override
  void initWidgetModel() {
    model.activeTabState.addListener(_handleActiveTab);
    super.initWidgetModel();
  }

  @override
  void didUpdateWidget(BrowserPage oldWidget) {
    if (oldWidget.tab.url != widget.tab.url) {
      _isShowStartViewState.accept(widget.tab.url.host.isEmpty);
    }
    super.didUpdateWidget(oldWidget);
  }

  @override
  void dispose() {
    widget.onDispose();
    _webViewController?.dispose();
    model.activeTabState.removeListener(_handleActiveTab);
    super.dispose();
  }

  Future<void> onWebViewCreated(
    InAppWebViewController controller,
  ) async {
    widget.onCreate(controller);
    _webViewController = controller;
    await model.initEvents(controller);

    if (_url.isNotEmpty) {
      await controller.loadUrl(
        urlRequest: URLRequest(
          url: WebUri.uri(widget.tab.url),
        ),
      );
    }
  }

  void onLoadStart(
    _,
    Uri? uri,
  ) {
    model
      ..createScreenshot(webViewController: _webViewController)
      ..updateUrl(uri)
      ..addHistory(uri);
  }

  void onLoadStop(
    _,
    Uri? uri,
  ) {
    // _pullToRefreshController?.endRefreshing();
    model
      ..createScreenshot(webViewController: _webViewController)
      ..updateUrl(uri);
  }

  Future<void> onLoadResource(
    InAppWebViewController controller,
    _,
  ) async {
    final progress = await controller.getProgress();

    if (progress != null && model.checkIsActiveTab(widget.tab.id)) {
      unawaited(widget.progressController.animateTo(progress / 100));
    }
  }

  void onReceivedError(
    _,
    WebResourceRequest request,
    WebResourceError error,
  ) {
    model.createScreenshot(webViewController: _webViewController);
    // _pullToRefreshController?.endRefreshing();
    _log.warning(
      'Failed to load ${request.url}: ${error.type} ${error.description}',
    );
  }

  void onReceivedHttpError(
    InAppWebViewController controller,
    WebResourceRequest request,
    WebResourceResponse errorResponse,
  ) {
    // _pullToRefreshController?.endRefreshing();
    _log.warning(
      'Failed to load ${request.url}: '
      'HTTP ${errorResponse.statusCode} '
      '${errorResponse.reasonPhrase}',
    );
  }

  void onTitleChanged(_, String? title) {
    if (title?.trim().isEmpty ?? true) {
      return;
    }
    model.updateTitle(title!);
  }

  void onOverScrolled(
    _,
    __,
    int y,
    ___,
    ____,
  ) {
    widget.onScrollChanged(y);
  }

  void onScrollChanged(_, __, int y) {
    widget.onScrollChanged(y);
  }

  Future<HttpAuthResponse?> onReceivedHttpAuthRequest(
    _,
    URLAuthenticationChallenge challenge,
  ) async {
    final fromStorage = model.getBasicAuthCreds(challenge);
    if (fromStorage != null) {
      return HttpAuthResponse(
        username: fromStorage.username,
        password: fromStorage.password,
        action: HttpAuthResponseAction.PROCEED,
      );
    }

    final entered = await Navigator.of(context, rootNavigator: true)
        .push<BrowserBasicAuthCreds>(
      showBrowserEnterBasicAuthCredsSheet(
        host: challenge.protectionSpace.host,
      ),
    );

    if (entered == null) {
      // this thing returns HttpAuthResponseAction.CANCEL
      return HttpAuthResponse();
    }

    model.updateAuthCreds(challenge, entered);

    return HttpAuthResponse(
      username: entered.username,
      password: entered.password,
      action: HttpAuthResponseAction.PROCEED,
    );
  }

  Future<NavigationActionPolicy> shouldOverrideUrlLoading(
    InAppWebViewController controller,
    NavigationAction navigationAction,
  ) async {
    final url = navigationAction.request.url;

    if (url == null) {
      return NavigationActionPolicy.ALLOW;
    }

    final scheme = navigationAction.request.url?.scheme;

    if (!_allowSchemes.contains(scheme) || _checkIsCustomAppLink(url)) {
      try {
        await launchUrl(url);
      } catch (_) {}

      return NavigationActionPolicy.CANCEL;
    }

    return NavigationActionPolicy.ALLOW;
  }

  void _onRefresh() {
    _webViewController?.reload();
  }

  bool _checkIsCustomAppLink(Uri url) {
    final path = url.toString();

    for (final segment in _customAppLinks) {
      if (path.contains(segment)) {
        return true;
      }
    }

    return false;
  }

  void _handleActiveTab() {
    _createWebView();
  }

  void _createWebView() {
    if (_isCreate || !model.checkIsActiveTab(widget.tab.id)) {
      return;
    }

    _isNeedCreateWebViewState.accept(true);
  }
}
