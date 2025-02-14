import 'package:app/app/service/bootstrap/bootstrap_service.dart';
import 'package:app/app/service/network_connection/network_connection_service.dart';
import 'package:app/feature/browserV2/browser_manager.dart';
import 'package:app/feature/splash/splash_screen.dart';
import 'package:app/runner.dart';
import 'package:elementary/elementary.dart';

/// [ElementaryModel] for [SplashScreen]
class SplashScreenModel extends ElementaryModel {
  SplashScreenModel(
    ErrorHandler errorHandler,
    this._bootstrapService,
    this._networkConnectionService,
    this._browserManager,
  ) : super(errorHandler: errorHandler);

  final BootstrapService _bootstrapService;
  final NetworkConnectionService _networkConnectionService;
  final BrowserManager _browserManager;

  Future<bool> get isExistInternet => _networkConnectionService.isExistInternet;

  Future<void> configure() async {
    await _bootstrapService.init(currentAppBuildType);
    _browserManager.init();
  }
}
