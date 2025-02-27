import 'dart:async';

import 'package:app/core/error_handler_factory.dart';
import 'package:app/core/wm/custom_wm.dart';
import 'package:app/di/di.dart';
import 'package:app/feature/browser/bottom_sheets/browser_enter_basic_auth_creds_sheet.dart';
import 'package:app/feature/browserV2/models/browser_basic_auth_creds.dart';
import 'package:app/feature/browserV2/screens/main/widgets/browser_web_tab/browser_web_tab.dart';
import 'package:app/feature/browserV2/screens/main/widgets/browser_web_tab/browser_web_tab_model.dart';
import 'package:elementary/elementary.dart';
import 'package:elementary_helper/elementary_helper.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_inappwebview/flutter_inappwebview.dart';
import 'package:logging/logging.dart';
import 'package:ui_components_lib/ui_components_lib.dart';
import 'package:url_launcher/url_launcher.dart';

/// Factory method for creating [BrowserWebTabWidgetModel]
BrowserWebTabWidgetModel defaultBrowserWebTabWidgetModelFactory(
  BuildContext context, {
  required String tabId,
}) {
  return BrowserWebTabWidgetModel(
    BrowserWebTabModel(
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

/// [WidgetModel] для [BrowserWebTab]
class BrowserWebTabWidgetModel
    extends CustomWidgetModel<BrowserWebTab, BrowserWebTabModel> {
  BrowserWebTabWidgetModel(
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

  // static const Duration _scrollTimerDelay = Duration(milliseconds: 100);

  // Scroll position of the webview, used to hide the HUD when the user scrolls
// further than a certain threshold.
//   static const int _hudScrollMinYThreshold = 4;

// Scroll dY of the webview, used to hide and show the HUD when the user
// scrolls up and down.
//   static const int _hudScrollDYThresholdDown = 64;
//   static const int _hudScrollDYThresholdUp = 128;

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

  InAppWebViewController? _webViewController;

  late final _webViewVisibleState = createNotifier<bool>(false);

  ColorsPalette get colors => _theme.colors;

  EntityValueListenable<String?> get nekotonJsState => model.nekotonJsState;

  ListenableState<bool> get webViewVisibleState => _webViewVisibleState;

  ThemeStyle get _theme => context.themeStyle;

  String get _url => widget.tab.url.toString();

  @override
  void initWidgetModel() {
    _webViewVisibleState.accept(_url.isNotEmpty);
    super.initWidgetModel();
  }

  @override
  void dispose() {
    _webViewController?.dispose();
    widget.onDispose();
    super.dispose();
  }

  Future<void> onWebViewCreated(
    InAppWebViewController controller,
  ) async {
    widget.onCreate(controller);
    _webViewController = controller;
    await model.initEvents(controller);

    if (widget.tab.url.toString().isNotEmpty) {
      await controller.loadUrl(
        urlRequest: URLRequest(
          url: WebUri.uri(widget.tab.url),
        ),
      );
    }
  }

  void onLoadStart(
    _,
    Uri? url,
  ) {
    _updateUrl(url);
  }

  void onLoadStop(
    _,
    Uri? url,
  ) {
    // _pullToRefreshController?.endRefreshing();
    _updateUrl(url);
  }

  Future<void> onLoadResource(
    InAppWebViewController controller,
    _,
  ) async {
    // Seems very strange, but they do it in example ¯\_(ツ)_/¯
    // ignore: no-magic-number

    // final progress = await controller.getProgress();
    // if (progress == 100) {
    //   unawaited(_pullToRefreshController?.endRefreshing());
    // }
    // unawaited(_setState(progress: progress));
    // unawaited(_saveScreenshot());
  }

  void onReceivedError(
    _,
    WebResourceRequest request,
    WebResourceError error,
  ) {
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
    bool clampedY,
  ) {
    /*
    if (clampedY) {
      // If we are overscrolled down hide HUD
      if (y > 0) {
        context.read<HudBloc>().add(const HudEvent.hide());
      }

      // Hey, we are overscrolled!
      // Remove all that contains overscrolled y position
      // Hopefully it will be before any of timers will fire
      _delayedScrollEvents.removeWhere((event) {
        // Is this event overscrolled?
        if (event.y < y) return false;
        // Cancel timer
        event.timer.cancel();

        // Remove event from the list
        return true;
      });
    }
    */
  }

  void onScrollChanged(_, __, int y) {
    /*
    // Remove all events that are not active anymore (cancelled, executed)
    _delayedScrollEvents.removeWhere((event) => !event.timer.isActive);

    // New delayed scroll event, at this point we don't know if it's overscroll
    final event = DelayedScrollEvent(
      timer: Timer(
        _scrollTimerDelay,
            () => _onScrollSane(y),
      ),
      y: y,
    );
    // Add it to the list of delayed events
    _delayedScrollEvents.add(
      event,
    );

    if (y == 0) {
      context.read<HudBloc>().add(const HudEvent.show());
    }
    */
  }

  void _onRefresh() {
    _webViewController?.reload();
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

  bool _checkIsCustomAppLink(Uri url) {
    final path = url.toString();

    for (final segment in _customAppLinks) {
      if (path.contains(segment)) {
        return true;
      }
    }

    return false;
  }

  void _updateUrl(Uri? uri) {
    if (uri?.toString().trim().isEmpty ?? true) {
      _webViewVisibleState.accept(false);
      return;
    }
    _webViewVisibleState.accept(true);
    model.updateUrl(uri!);
  }
}
//
// // Delayed scroll event dataclass
// class DelayedScrollEvent {
//   const DelayedScrollEvent({
//     required this.timer,
//     required this.y,
//   });
//
//   // Timer that will fire when scroll event is not overscrolled
//   final Timer timer;
//
//   // Scroll position
//   final int y;
// }
