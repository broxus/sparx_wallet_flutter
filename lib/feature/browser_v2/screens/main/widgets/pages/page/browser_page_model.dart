import 'dart:typed_data';

import 'package:app/app/service/approvals_service.dart';
import 'package:app/app/service/assets_service.dart';
import 'package:app/app/service/connection/connection_service.dart';
import 'package:app/app/service/js_servcie.dart';
import 'package:app/app/service/permissions_service.dart';
import 'package:app/app/service/storage_service/connections_storage_service.dart';
import 'package:app/app/service/ton_connect/ton_connect_js_bridge.dart';
import 'package:app/feature/browser_v2/custom_web_controller.dart';
import 'package:app/feature/browser_v2/data/browser_basic_auth_creds.dart';
import 'package:app/feature/browser_v2/data/groups/browser_group.dart';
import 'package:app/feature/browser_v2/data/tabs/browser_tab.dart';
import 'package:app/feature/browser_v2/domain/service/browser_service.dart';
import 'package:app/feature/browser_v2/inpage_provider/inpage_provider.dart';
import 'package:app/feature/browser_v2/screens/main/widgets/pages/page/browser_page.dart';
import 'package:app/feature/browser_v2/screens/main/widgets/pages/page/helpers/events_helper.dart';
import 'package:app/feature/messenger/domain/service/messenger_service.dart';
import 'package:elementary/elementary.dart';
import 'package:elementary_helper/elementary_helper.dart';
import 'package:flutter_inappwebview/flutter_inappwebview.dart';
import 'package:nekoton_repository/nekoton_repository.dart';

/// [ElementaryModel] for [BrowserPage]
class BrowserPageModel extends ElementaryModel {
  BrowserPageModel(
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
    this._tonConnectJsBridge,
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
  final TonConnectJsBridge _tonConnectJsBridge;

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

  EntityValueListenable<String?> get nekotonJsState =>
      _jsService.nekotonJsState;

  ListenableState<BrowserGroup?> get activeGroupState =>
      _browserService.tM.activeGroupState;

  ListenableState<BrowserTab?> get activeTabState =>
      _browserService.tM.activeTabState;

  String? get _activeTabId => activeTabState.value?.id;

  @override
  void dispose() {
    _eventsHelper.dispose();

    return super.dispose();
  }

  Future<void> initEvents(CustomWebViewController controller) async {
    _eventsHelper.init(controller);
    _inpageProvider.controller = controller;

    await controller.initNekotonProvider(
      providerApi: _inpageProvider,
    );
    await _tonConnectJsBridge.initJsBridge(controller);
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
    if (uri == null) {
      return;
    }
    _inpageProvider.url = uri;
    _tonConnectJsBridge.url = uri;
    _browserService.tM.updateCachedUrl(_tabId, uri);
  }

  void updateTitle(String title) {
    _browserService.tM.updateTabTitle(_tabId, title);
  }

  void addHistory(Uri? uri) {
    if (uri == null) {
      return;
    }
    _browserService.hM.createHistoryItem(uri);
  }

  Future<void> createScreenshot({
    required Future<Uint8List?> Function() takePictureCallback,
    bool force = false,
  }) async {
    return _browserService.tabs.createScreenshot(
      tabId: _tabId,
      takePictureCallback: takePictureCallback,
    );
  }

  bool checkIsActiveTab(String id) {
    return _activeTabId == null || id == _activeTabId;
  }
}
