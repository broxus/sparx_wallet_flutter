import 'dart:async';

import 'package:app/core/wm/custom_wm.dart';
import 'package:app/core/wm/not_null_listenable_state.dart';
import 'package:app/feature/browser_v1/bottom_sheets/browser_enter_basic_auth_creds_sheet.dart';
import 'package:app/feature/browser_v2/custom_web_controller.dart';
import 'package:app/feature/browser_v2/data/browser_basic_auth_creds.dart';
import 'package:app/feature/browser_v2/data/tabs/browser_tab.dart';
import 'package:app/feature/browser_v2/screens/main/widgets/pages/page/browser_page.dart';
import 'package:app/feature/browser_v2/screens/main/widgets/pages/page/browser_page_model.dart';
import 'package:elementary/elementary.dart';
import 'package:elementary_helper/elementary_helper.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_inappwebview/flutter_inappwebview.dart';
import 'package:injectable/injectable.dart';
import 'package:logging/logging.dart';
import 'package:ui_components_lib/ui_components_lib.dart';
import 'package:url_launcher/url_launcher.dart';

class BrowserPageWmParams {
  const BrowserPageWmParams({
    required this.tabState,
    required this.onCreate,
    required this.onWebPageScrollChanged,
    required this.onDispose,
    required this.onLoadingProgressChanged,
  });

  final NotNullListenableState<BrowserTab> tabState;
  final ValueChanged<CustomWebViewController> onCreate;
  final ValueChanged<int> onWebPageScrollChanged;
  final VoidCallback onDispose;
  final ValueChanged<int> onLoadingProgressChanged;
}

/// [WidgetModel] для [BrowserPage]
@injectable
class BrowserPageWidgetModel extends CustomWidgetModelParametrized<
    BrowserPage,
    BrowserPageModel,
    BrowserPageWmParams> with AutomaticKeepAliveWidgetModelMixin {
  BrowserPageWidgetModel(super.model);

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

  final _screenshotConfiguration = ScreenshotConfiguration(
    compressFormat: CompressFormat.JPEG,
    quality: 70,
    snapshotWidth: 160,
  );

  late final _isNeedCreateWebViewState = createNotifier<bool>(false);
  late final _isShowStartViewState =
      createNotifier<bool>(_url.toString().isEmpty);

  CustomWebViewController? _webViewController;

  Uri? _prevUri;

  ColorsPalette get colors => _theme.colors;

  ListenableState<bool> get isNeedCreateWebViewState =>
      _isNeedCreateWebViewState;

  ListenableState<bool> get isShowStartViewState => _isShowStartViewState;

  ThemeStyle get _theme => context.themeStyle;

  NotNullListenableState<BrowserTab> get _tabState => wmParams.value.tabState;

  String get _tabId => _tabState.value.id;

  Uri get _url => _tabState.value.url;

  bool get _isCreate => _isNeedCreateWebViewState.value ?? false;

  @override
  void initWidgetModel() {
    super.initWidgetModel();
    model.activeTabIdState.addListener(_handleActiveTab);
    _tabState.addListener(_handleTabState);
  }

  @override
  void dispose() {
    wmParams.value.onDispose();
    _webViewController?.dispose();
    model.activeTabIdState.removeListener(_handleActiveTab);
    _tabState.removeListener(_handleTabState);
    super.dispose();
  }

  // Callback that is called when the WebView and its controller are created
  Future<void> onWebViewCreated(
    InAppWebViewController controller,
  ) async {
    final customController = CustomWebViewController(controller);

    wmParams.value.onCreate(customController);
    _webViewController = customController;
    await model.initEvents(
      tabId: _tabId,
      controller: customController,
    );

    if (_url.toString().isNotEmpty) {
      unawaited(
        model.initUri(_tabId, _url),
      );
    }
    controller.addJavaScriptHandler(
      handlerName: 'phishClick',
      callback: (args) => model.addUrlToWhiteList(args.first as String),
    );
  }

  // Start loading page
  void onWebPageLoadStart(
    _,
    Uri? uri,
  ) {
    _createScreenshot();
    model
      ..updateUrl(
        tabId: _tabId,
        uri: uri,
      )
      ..addHistory(uri);
  }

  // Stop loading page
  void onWebPageLoadStop(
    _,
    Uri? uri,
  ) {
    pullToRefreshController.endRefreshing();
    _createScreenshot();
    model.updateUrl(
      tabId: _tabId,
      uri: uri,
    );
  }

  // Load any resource on the page. JS, CSS, images, etc.
  Future<void> onWebPageLoadResource(
    InAppWebViewController controller,
    _,
  ) async {
    final progress = await controller.getProgress();

    if (progress == 100) {
      unawaited(pullToRefreshController.endRefreshing());
    }
    if (progress != null && model.checkIsActiveTab(_tabId)) {
      wmParams.value.onLoadingProgressChanged(progress);
    }
  }

  // Network or WebView issues No internet, DNS, timeout
  void onWebPageReceivedError(
    _,
    WebResourceRequest request,
    WebResourceError error,
  ) {
    _createScreenshot();
    pullToRefreshController.endRefreshing();
    _log.warning(
      'Failed to load ${request.url}: ${error.type} ${error.description}',
    );
  }

  // The server responded with an HTTP error (4xx/5xx)
  void onWebPageReceivedHttpError(
    InAppWebViewController controller,
    WebResourceRequest request,
    WebResourceResponse errorResponse,
  ) {
    pullToRefreshController.endRefreshing();
    _log.warning(
      'Failed to load ${request.url}: '
      'HTTP ${errorResponse.statusCode} '
      '${errorResponse.reasonPhrase}',
    );
  }

  // Called when the page title changes.
  void onWebPageTitleChanged(_, String? title) {
    if (title?.trim().isEmpty ?? true) {
      return;
    }
    model.updateTitle(
      tabId: _tabId,
      title: title!,
    );
  }

  void onWebPageScrollChanged(_, __, int y) {
    wmParams.value.onWebPageScrollChanged(y);
  }

  // Called during HTTP authorization if the site requires login/password
  // (e.g. 401 Unauthorized with WWW-Authenticate header).
  Future<HttpAuthResponse?> onWebPageReceivedHttpAuthRequest(
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

  // Called when trying to load a new URL (click/redirect).
  // You can intercept and cancel or replace the load.
  Future<NavigationActionPolicy> onWebPageShouldOverrideUrlLoading(
    InAppWebViewController controller,
    NavigationAction navigationAction,
  ) async {
    final url = navigationAction.request.url;

    if (url == null) {
      return NavigationActionPolicy.ALLOW;
    }

    final isGuardPhishing = model.checkIsPhishingUri(url);

    if (isGuardPhishing) {
      unawaited(
        model.loadPhishingGuard(_tabId, url),
      );
      return NavigationActionPolicy.CANCEL;
    }

    if (isGuardPhishing) {
      return NavigationActionPolicy.CANCEL;
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

  Future<void> _onRefresh() async {
    try {
      await _webViewController?.reload();
    } catch (_) {}
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
    if (_isCreate || !model.checkIsActiveTab(_tabId)) {
      return;
    }

    _isNeedCreateWebViewState.accept(true);
  }

  void _createScreenshot() {
    if (_webViewController == null) {
      return;
    }
    model.createScreenshot(
      tabId: _tabId,
      takePictureCallback: () async {
        try {
          return await _webViewController!.takeScreenshot(
            screenshotConfiguration: _screenshotConfiguration,
          );
        } catch (_) {
          return null;
        }
      },
    );
  }

  void _handleTabState() {
    if (_prevUri != _url) {
      _isShowStartViewState.accept(_url.toString().isEmpty);
    }

    _prevUri = _url;
  }
}
