import 'package:app/app/service/bootstrap/bootstrap_navigation_delegate.dart';
import 'package:app/feature/root_device_alert/domain/root_device_delegate.dart';
import 'package:app/feature/root_device_alert/view/root_device_alert_screen.dart';
import 'package:elementary/elementary.dart';
import 'package:injectable/injectable.dart';

/// [ElementaryModel] for [RootDeviceAlertScreen]
@injectable
class RootDeviceAlertScreenModel extends ElementaryModel {
  RootDeviceAlertScreenModel(
    ErrorHandler errorHandler,
    this._bootstrapNavigationDelegate,
    this._rootDeviceDelegate,
  ) : super(errorHandler: errorHandler);

  final BootstrapNavigationDelegate _bootstrapNavigationDelegate;
  final RootDeviceDelegate _rootDeviceDelegate;

  Future<void> next() async {
    await _rootDeviceDelegate.setUserKnowRoot();
    await _bootstrapNavigationDelegate.goToResultBootstrap();
  }
}
