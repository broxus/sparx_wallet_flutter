import 'dart:async';
import 'dart:typed_data';

import 'package:app/app/service/app_permissions_service.dart';
import 'package:app/app/service/approvals_service.dart';
import 'package:app/app/service/assets_service.dart';
import 'package:app/app/service/connection/connection_service.dart';
import 'package:app/app/service/permissions_service.dart';
import 'package:app/app/service/storage_service/connections_storage/connections_storage_service.dart';
import 'package:app/core/app_build_type.dart';
import 'package:app/feature/browser_v2/custom_web_controller.dart';
import 'package:app/feature/browser_v2/data/browser_basic_auth_creds.dart';
import 'package:app/feature/browser_v2/data/browser_uri.dart';
import 'package:app/feature/browser_v2/domain/service/browser_service.dart';
import 'package:app/feature/browser_v2/inpage_provider/inpage_provider.dart';
import 'package:app/feature/browser_v2/screens/main/widgets/pages/page/browser_page.dart';
import 'package:app/feature/browser_v2/screens/main/widgets/pages/page/helpers/events_helper.dart';
import 'package:app/feature/ledger/ledger.dart';
import 'package:app/feature/messenger/domain/service/messenger_service.dart';
import 'package:app/feature/ton_connect/ton_connect.dart';
import 'package:app/runner.dart';
import 'package:elementary/elementary.dart';
import 'package:elementary_helper/elementary_helper.dart';
import 'package:flutter_inappwebview/flutter_inappwebview.dart';
import 'package:injectable/injectable.dart';
import 'package:nekoton_repository/nekoton_repository.dart';

/// [ElementaryModel] for [BrowserPage]
@injectable
class BrowserPageModel extends ElementaryModel {
  BrowserPageModel(
    ErrorHandler errorHandler,
    this._browserService,
    this._approvalsService,
    this._permissionsService,
    this._nekotonRepository,
    this._messengerService,
    this._assetsService,
    this._connectionsStorageService,
    this._connectionService,
    this._tonConnectJsBridge,
    this._ledgerService,
    this._appPermissionsService,
  ) : super(errorHandler: errorHandler);

  final isShowBrowserLog = currentAppBuildType == AppBuildType.development;

  final BrowserService _browserService;
  final BrowserApprovalsService _approvalsService;
  final PermissionsService _permissionsService;
  final NekotonRepository _nekotonRepository;
  final MessengerService _messengerService;
  final AssetsService _assetsService;
  final ConnectionsStorageService _connectionsStorageService;
  final ConnectionService _connectionService;
  final TonConnectJsBridge _tonConnectJsBridge;
  final LedgerService _ledgerService;
  final AppPermissionsService _appPermissionsService;

  InpageProvider? _inpageProvider;

  late final _eventsHelper = EventsHelper(
    _nekotonRepository,
    _permissionsService,
  );

  ListenableState<String?> get activeGroupIdState =>
      _browserService.tab.activeGroupIdState;

  ListenableState<String?> get activeTabIdState =>
      _browserService.tab.activeTabIdState;

  String? get _activeTabId => activeTabIdState.value;

  @override
  void dispose() {
    _eventsHelper.dispose();

    return super.dispose();
  }

  Future<void> initEvents({
    required String tabId,
    required CustomWebViewController controller,
  }) async {
    _eventsHelper.init(tabId: tabId, controller: controller);
    final inpageProvider = InpageProvider(
      tabId: tabId,
      approvalsService: _approvalsService,
      permissionsService: _permissionsService,
      nekotonRepository: _nekotonRepository,
      messengerService: _messengerService,
      assetsService: _assetsService,
      connectionsStorageService: _connectionsStorageService,
      connectionService: _connectionService,
      ledgerService: _ledgerService,
    );
    _inpageProvider = inpageProvider;
    inpageProvider.controller = controller;

    await controller.initNekotonProvider(providerApi: inpageProvider);
    await _tonConnectJsBridge.initJsBridge(controller);
  }

  BrowserBasicAuthCreds? getBasicAuthCreds(
    URLAuthenticationChallenge challenge,
  ) => _browserService.auth.getBasicAuthCreds(challenge);

  void updateAuthCreds(
    URLAuthenticationChallenge challenge,
    BrowserBasicAuthCreds credits,
  ) {
    _browserService.auth.setBasicAuthCreds(challenge, credits);
  }

  void updateUrl({required Uri? uri, required String tabId}) {
    if (uri == null) {
      return;
    }
    _inpageProvider?.url = uri;
    _tonConnectJsBridge.url = uri;
    _browserService.tab.updateCachedUrl(tabId, uri);
  }

  void updateTitle({required String title, required String tabId}) {
    _browserService.tab.updateTabTitle(tabId, title);
  }

  void addHistory(Uri? uri) {
    if (uri == null) {
      return;
    }
    _browserService.hist.createHistoryItem(uri);
  }

  Future<void> createScreenshot({
    required Future<Uint8List?> Function() takePictureCallback,
    required String tabId,
    bool force = false,
  }) async {
    return _browserService.tab.createScreenshot(
      tabId: tabId,
      takePictureCallback: takePictureCallback,
    );
  }

  bool checkIsActiveTab(String id) {
    return _activeTabId == null || id == _activeTabId;
  }

  Future<void> initUri(String tabId, Uri uri) async {
    final isPhishing = checkIsPhishingUri(uri);

    if (isPhishing) {
      unawaited(loadPhishingGuard(tabId, uri));
      return;
    }

    return _browserService.tab.requestUrlActiveTab(
      uri.host == '' && uri.path == 'blank'
          ? BrowserUri('')
          : BrowserUri.uri(uri),
    );
  }

  bool checkIsPhishingUri(Uri uri) =>
      _browserService.antiPhishing.checkIsPhishingUri(uri);

  Future<void> loadPhishingGuard(String tabId, Uri uri) {
    return _browserService.loadPhishingGuard(tabId, uri);
  }

  void addUrlToWhiteList(String path) {
    _browserService.antiPhishing.addToWhiteList(path);
    Future.delayed(const Duration(milliseconds: 100), () {
      _browserService.tab.requestUrlActiveTab(Uri.parse(path));
    });
  }

  Future<bool> checkPermission(
    String host,
    List<PermissionResourceType> resources,
  ) => _browserService.perm.checkHostPermissions(host, [
    for (final resource in resources) resource.toValue(),
  ]);

  Future<void> saveHostPermissions(
    String host,
    List<PermissionResourceType> resources,
  ) => _browserService.perm.saveHostPermissions(host, [
    for (final resource in resources) resource.toValue(),
  ]);

  Future<void> requestCameraPermissionIfNeed(
    List<PermissionResourceType> resources,
  ) async {
    if (resources.contains(PermissionResourceType.CAMERA) ||
        resources.contains(PermissionResourceType.CAMERA_AND_MICROPHONE)) {
      await _appPermissionsService.requestCamera();
    }
  }
}
