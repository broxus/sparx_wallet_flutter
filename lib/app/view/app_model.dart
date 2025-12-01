import 'dart:async';

import 'package:app/app/router/router.dart';
import 'package:app/app/service/app_lifecycle_service.dart';
import 'package:app/app/service/app_links/app_links.dart';
import 'package:app/app/service/biometry_service.dart';
import 'package:app/app/service/bootstrap/bootstrap_service.dart';
import 'package:app/app/service/bootstrap/configurators/logger.dart';
import 'package:app/app/service/crash_detector/domain/service/crash_detector_service.dart';
import 'package:app/app/service/pending_deep_link_service.dart';
import 'package:app/app/view/app.dart';
import 'package:app/feature/browser/domain/browser_launcher.dart';
import 'package:app/feature/localization/localization.dart';
import 'package:app/feature/messenger/data/message.dart';
import 'package:app/feature/messenger/domain/service/messenger_service.dart';
import 'package:app/feature/profile/route.dart';
import 'package:app/generated/generated.dart';
import 'package:elementary/elementary.dart';
import 'package:flutter/widgets.dart';
import 'package:injectable/injectable.dart';
import 'package:nekoton_repository/nekoton_repository.dart' hide Message;

/// [ElementaryModel] for [App]
@injectable
class AppModel extends ElementaryModel with WidgetsBindingObserver {
  AppModel(
    ErrorHandler errorHandler,
    this.router,
    this._appLinksService,
    this._appLifecycleService,
    this._localizationService,
    this._biometryService,
    this._messengerService,
    this._crashDetectorService,
    this._loggerConfigurator,
    this._browserLauncher,
    this._nekotonRepository,
    this._bootstrapService,
    this._pendingDeepLinkService,
  ) : super(errorHandler: errorHandler);

  final CompassRouter router;
  final AppLinksService _appLinksService;
  final AppLifecycleService _appLifecycleService;
  final LocalizationService _localizationService;
  final BiometryService _biometryService;
  final MessengerService _messengerService;
  final CrashDetectorService _crashDetectorService;
  final LoggerConfigurator _loggerConfigurator;
  final BrowserLauncher _browserLauncher;
  final NekotonRepository _nekotonRepository;
  final BootstrapService _bootstrapService;
  final PendingDeepLinkService _pendingDeepLinkService;

  BuildContext? get navContext =>
      CompassRouter.navigatorKey.currentState?.context;

  Stream<bool> get messagesExistStream => _messengerService.messagesExistStream;

  AppLifecycleListener? _listener;
  StreamSubscription<BrowserAppLinksData>? _appLinksSubs;

  @override
  void init() {
    _listener = AppLifecycleListener(onStateChange: _onStateChanged);
    _crashDetectorService.startSession(setCrashDetected: true);
    _checkBiometry();
    _appLinksSubs = _appLinksService.browserLinksStream.listen(_listenAppLinks);
    _pendingDeepLinkService.attachToRouter(router);
    super.init();
  }

  @override
  void dispose() {
    router.dispose();
    _listener?.dispose();
    _appLinksSubs?.cancel();
    super.dispose();
  }

  @override
  void didChangeLocales(List<Locale>? locales) {
    super.didChangeLocales(locales);

    _localizationService.refreshLocale();
  }

  Message? getMessage() => _messengerService.takeMessage();

  Future<bool> checkCrashDetected() =>
      _crashDetectorService.checkCrashDetected();

  void _onStateChanged(AppLifecycleState state) {
    switch (state) {
      case AppLifecycleState.resumed:
        _loggerConfigurator.startLogSession();
        _crashDetectorService.startSession(setCrashDetected: false);
        _resumePolling();
      case AppLifecycleState.inactive:
        _crashDetectorService.stopSession();
        _pausePolling();
      case AppLifecycleState.paused:
      case AppLifecycleState.detached:
      case AppLifecycleState.hidden:
        break;
    }

    _appLifecycleService.updateState(state);
  }

  Future<void> _checkBiometry() async {
    final location = router.currentRoutes.firstOrNull;
    final canUpdateStatus = await _biometryService.canUpdateStatus();

    if (canUpdateStatus && location is ProfileRoute) {
      await _biometryService.setStatus(
        localizedReason: LocaleKeys.biometryAuthReason.tr(),
        isEnabled: true,
      );
    }
  }

  void _listenAppLinks(BrowserAppLinksData event) {
    WidgetsBinding.instance.addPostFrameCallback((_) async {
      // Wait for bootstrap to complete before handling deeplink
      await _bootstrapService.bootstrapStepStream.firstWhere(
        (step) => _bootstrapService.isConfigured,
      );

      // Wait for router to complete initial navigation
      // This ensures RootView and bottom navigation bar are fully mounted
      // before attempting to navigate to browser
      await router.currentRoutesStream.first;

      final hasSeeds = _nekotonRepository.hasSeeds.valueOrNull ?? false;

      if (hasSeeds) {
        // User already onboarded - open browser immediately
        _browserLauncher.openBrowserByUri(event.url);
      } else {
        // User not onboarded - store for later processing
        _pendingDeepLinkService.addPendingLink(event.url);
      }
    });
  }

  void _pausePolling() {
    _nekotonRepository
      ..pausePolling()
      ..pausePollingToken();
  }

  void _resumePolling() {
    _nekotonRepository
      ..resumePolling()
      ..resumePollingToken();
  }
}
