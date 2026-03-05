import 'package:app/app/service/bootstrap/bootstrap_service.dart';
import 'package:app/feature/connection_fail/connection_fail_screen.dart';
import 'package:app/generated/generated.dart';
import 'package:elementary/elementary.dart';
import 'package:injectable/injectable.dart';

/// [ElementaryModel] for [ConnectionFailScreen]
@injectable
class ConnectionFailModel extends ElementaryModel {
  ConnectionFailModel(ErrorHandler errorHandler, this._bootstrapService)
    : super(errorHandler: errorHandler);

  final BootstrapService _bootstrapService;

  Future<void> tryAgain() async {
    try {
      await _bootstrapService.rerunFailedSteps();
    } catch (e) {
      handleError(LocaleKeys.connectingNetworkFailed.tr());
    }
  }
}
