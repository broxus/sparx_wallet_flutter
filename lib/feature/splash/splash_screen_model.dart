import 'package:app/app/service/bootstrap/bootstrap_service.dart';
import 'package:app/app/service/network_connection/network_connection_service.dart';
import 'package:app/feature/browser_v2/domain/service/browser_service.dart';
import 'package:app/feature/splash/splash_screen.dart';
import 'package:app/runner.dart';
import 'package:elementary/elementary.dart';

/// [ElementaryModel] for [SplashScreen]
class SplashScreenModel extends ElementaryModel {
  SplashScreenModel(
    ErrorHandler errorHandler,
    this._bootstrapService,
    this._networkConnectionService,
    this._browserService,
  ) : super(errorHandler: errorHandler);

  final BootstrapService _bootstrapService;
  final NetworkConnectionService _networkConnectionService;
  final BrowserService _browserService;

  Future<bool> get isExistInternet => _networkConnectionService.isExistInternet;

  Future<void> configure() async {
    await _bootstrapService.init(currentAppBuildType);
    _browserService.init();
  }
}
