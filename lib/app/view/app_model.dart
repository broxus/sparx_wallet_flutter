import 'package:app/app/router/router.dart';
import 'package:app/app/service/app_lifecycle_service.dart';
import 'package:app/app/service/biometry_service.dart';
import 'package:app/app/service/localization/service/localization_service.dart';
import 'package:app/app/view/app.dart';
import 'package:app/bootstrap/bootstrap.dart';
import 'package:app/feature/messenger/data/message.dart';
import 'package:app/feature/messenger/domain/service/messenger_service.dart';
import 'package:app/feature/messenger/domain/service/messenger_value.dart';
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
  ) : super(errorHandler: errorHandler);

  final CompassRouter router;
  final AppLifecycleService _appLifecycleService;
  final LocalizationService _localizationService;
  final BiometryService _biometryService;
  final MessengerService _messengerService;

  BuildContext? get navContext =>
      CompassRouter.navigatorKey.currentState?.context;

  Stream<MessengerValue> get messagesExistStream =>
      _messengerService.messagesExistStream;

  AppLifecycleListener? _listener;

  @override
  void init() {
    _listener = AppLifecycleListener(
      onStateChange: _onStateChanged,
    );
    appStartSession(setCrashDetected: true);
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

  void _onStateChanged(AppLifecycleState state) {
    switch (state) {
      case AppLifecycleState.resumed:
        startLogSession();
        appStartSession(setCrashDetected: false);
      case AppLifecycleState.inactive:
        appStopSession();
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
