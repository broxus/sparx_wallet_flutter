import 'package:app/app/router/router.dart';
import 'package:app/app/service/app_lifecycle_service.dart';
import 'package:app/app/service/biometry_service.dart';
import 'package:app/app/service/bootstrap/configurators/logger.dart';
import 'package:app/app/service/crash_detector/domain/service/crash_detector_service.dart';
import 'package:app/app/service/localization/service/localization_service.dart';
import 'package:app/app/view/app.dart';
import 'package:app/feature/messenger/data/message.dart';
import 'package:app/feature/messenger/domain/service/messenger_service.dart';
import 'package:app/feature/profile/route.dart';
import 'package:app/generated/generated.dart';
import 'package:elementary/elementary.dart';
import 'package:flutter/widgets.dart';

/// [ElementaryModel] for [App]
class AppModel extends ElementaryModel with WidgetsBindingObserver {
  AppModel(
    ErrorHandler errorHandler,
    this.router,
    this._appLifecycleService,
    this._localizationService,
    this._biometryService,
    this._messengerService,
    this._crashDetectorService,
    this._loggerConfigurator,
  ) : super(errorHandler: errorHandler);

  final CompassRouter router;
  final AppLifecycleService _appLifecycleService;
  final LocalizationService _localizationService;
  final BiometryService _biometryService;
  final MessengerService _messengerService;
  final CrashDetectorService _crashDetectorService;
  final LoggerConfigurator _loggerConfigurator;

  BuildContext? get navContext =>
      CompassRouter.navigatorKey.currentState?.context;

  Stream<bool> get messagesExistStream => _messengerService.messagesExistStream;

  AppLifecycleListener? _listener;

  @override
  void init() {
    _listener = AppLifecycleListener(
      onStateChange: _onStateChanged,
    );
    _crashDetectorService.startSession(setCrashDetected: true);
    _checkBiometry();
    super.init();
  }

  @override
  void dispose() {
    router.dispose();
    _listener?.dispose();
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
      case AppLifecycleState.inactive:
        _crashDetectorService.stopSession();
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
}
