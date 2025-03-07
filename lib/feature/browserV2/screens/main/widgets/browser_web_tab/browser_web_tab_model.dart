import 'package:app/app/service/approvals_service.dart';
import 'package:app/app/service/assets_service.dart';
import 'package:app/app/service/connection/connection_service.dart';
import 'package:app/app/service/js_servcie.dart';
import 'package:app/app/service/messenger/service/messenger_service.dart';
import 'package:app/app/service/permissions_service.dart';
import 'package:app/app/service/storage_service/connections_storage_service.dart';
import 'package:app/feature/browser/inpage_provider/inpage_provider.dart';
import 'package:app/feature/browserV2/models/browser_basic_auth_creds.dart';
import 'package:app/feature/browserV2/screens/main/widgets/browser_web_tab/browser_web_tab.dart';
import 'package:app/feature/browserV2/screens/main/widgets/browser_web_tab/helpers/events_helper.dart';
import 'package:app/feature/browserV2/service/browser_service.dart';
import 'package:elementary/elementary.dart';
import 'package:elementary_helper/elementary_helper.dart';
import 'package:flutter_inappwebview/flutter_inappwebview.dart';
import 'package:nekoton_repository/nekoton_repository.dart';
import 'package:nekoton_webview/nekoton_webview.dart';

/// [ElementaryModel] for [BrowserWebTab]
class BrowserWebTabModel extends ElementaryModel {
  BrowserWebTabModel(
    ErrorHandler errorHandler,
    this._tabId,
    this._browserService,
    this._approvalsService,
    this._permissionsService,
    this._nekotonRepository,
    this._messengerService,
    this._assetsService,
    this._connectionsStorageService,
    this._connectionService,
    this._jsService,
  ) : super(errorHandler: errorHandler);

  final String _tabId;

  final BrowserService _browserService;
  final BrowserApprovalsService _approvalsService;
  final PermissionsService _permissionsService;
  final NekotonRepository _nekotonRepository;
  final MessengerService _messengerService;
  final AssetsService _assetsService;
  final ConnectionsStorageService _connectionsStorageService;
  final ConnectionService _connectionService;
  final JsService _jsService;

  late final _inpageProvider = InpageProvider(
    tabId: _tabId,
    approvalsService: _approvalsService,
    permissionsService: _permissionsService,
    nekotonRepository: _nekotonRepository,
    messengerService: _messengerService,
    assetsService: _assetsService,
    connectionsStorageService: _connectionsStorageService,
    connectionService: _connectionService,
  );

  late final _eventsHelper = EventsHelper(
    _nekotonRepository,
    _permissionsService,
    _jsService,
    _tabId,
  );

  final ScreenshotConfiguration _screenshotConfiguration =
      ScreenshotConfiguration(
    compressFormat: CompressFormat.JPEG,
    quality: 70,
    snapshotWidth: 160,
  );

  EntityValueListenable<String?> get nekotonJsState =>
      _jsService.nekotonJsState;

  String? get _activeTabId => _browserService.tM.activeTabId;

  @override
  void dispose() {
    _eventsHelper.dispose();

    return super.dispose();
  }

  Future<void> initEvents(InAppWebViewController controller) async {
    _eventsHelper.init(controller);
    _inpageProvider.controller = controller;

    await controller.initNekotonProvider(
      providerApi: _inpageProvider,
    );
  }

  BrowserBasicAuthCreds? getBasicAuthCreds(
    URLAuthenticationChallenge challenge,
  ) =>
      _browserService.aM.getBasicAuthCreds(challenge);

  void updateAuthCreds(
    URLAuthenticationChallenge challenge,
    BrowserBasicAuthCreds credits,
  ) {
    _browserService.auth.setBasicAuthCreds(challenge, credits);
  }

  void updateUrl(Uri? uri) {
    if(uri == null) {
      return;
    }
    _inpageProvider.url = uri;
    _browserService.tM.updateUrl(_tabId, uri);
  }

  void updateTitle(String title) {
    _browserService.tM.updateTitle(_tabId, title);
  }

  Future<void> createScreenshot({
    InAppWebViewController? webViewController,
    bool force = false,
  }) async {
    if (webViewController == null) {
      return;
    }
    return _browserService.tabs.createScreenshot(
      tabId: _tabId,
      takePictureCallback: () async => webViewController.takeScreenshot(
        screenshotConfiguration: _screenshotConfiguration,
      ),
    );
  }

  bool checkIsActiveTab(String id) {
    return _activeTabId == null || id == _activeTabId;
  }
}
