import 'package:app/app/router/router.dart';
import 'package:app/app/service/app_lifecycle_service.dart';
import 'package:app/app/service/biometry_service.dart';
import 'package:app/app/service/bootstrap/bootstrap_service.dart';
import 'package:app/app/service/localization/service/localization_service.dart';
import 'package:app/app/service/navigation/service/navigation_service.dart';
import 'package:app/app/service/ton_connect/models/models.dart';
import 'package:app/app/service/ton_connect/ton_connect_service.dart';
import 'package:app/app/view/app.dart';
import 'package:app/bootstrap/bootstrap.dart';
import 'package:app/generated/generated.dart';
import 'package:elementary/elementary.dart';
import 'package:flutter/widgets.dart';
import 'package:nekoton_repository/nekoton_repository.dart';

/// [ElementaryModel] for [App]
class AppModel extends ElementaryModel with WidgetsBindingObserver {
  AppModel(
    ErrorHandler errorHandler,
    this._bootstrapService,
    this._navigationService,
    this._nekotonRepository,
    this._appLifecycleService,
    this._localizationService,
    this._biometryService,
    this._tonConnectService,
  ) : super(errorHandler: errorHandler);

  final BootstrapService _bootstrapService;
  final NavigationService _navigationService;
  final NekotonRepository _nekotonRepository;
  final AppLifecycleService _appLifecycleService;
  final LocalizationService _localizationService;
  final BiometryService _biometryService;

  final TonConnectService _tonConnectService;

  late final appRouter = AppRouter(
    _bootstrapService,
    _navigationService,
    _nekotonRepository,
  );

  AppLifecycleListener? _listener;

  @override
  void init() {
    _tonConnectService.open().then((_) {
      // _tonConnectService.connect(
      //   ConnectQuery.fromQuery(
      //     'v=2&id=939aa6ad9b67d83cb41738da844d2462cc7adbc31a08eb382a835372fb280f67&r=%7B%22manifestUrl%22%3A%22https%3A%2F%2Fton-connect.github.io%2Fdemo-dapp-with-wallet%2Ftonconnect-manifest.json%22%2C%22items%22%3A%5B%7B%22name%22%3A%22ton_addr%22%7D%5D%7D&ret=none',
      //   ),
      // );
    });

    Future.delayed(const Duration(milliseconds: 100), () {
      _listener = AppLifecycleListener(
        onStateChange: _onStateChanged,
      );
    });
    appStartSession(setCrashDetected: true);
    _checkBiometry();
    super.init();
  }

  @override
  void dispose() {
    appRouter.dispose();
    _listener?.dispose();
    super.dispose();
  }

  @override
  void didChangeLocales(List<Locale>? locales) {
    super.didChangeLocales(locales);

    _localizationService.refreshLocale();
  }

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
    final location = _navigationService.state.location;
    final canUpdateStatus = await _biometryService.canUpdateStatus();

    if (canUpdateStatus && location == AppRoute.profile.path) {
      await _biometryService.setStatus(
        localizedReason: LocaleKeys.biometryAuthReason.tr(),
        isEnabled: true,
      );
    }
  }
}
