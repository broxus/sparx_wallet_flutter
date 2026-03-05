import 'package:app/app/service/bootstrap/bootstrap_service.dart';
import 'package:app/generated/generated.dart';
import 'package:elementary/elementary.dart';
import 'package:injectable/injectable.dart';

@injectable
class BootstrapFailedRerunModel extends ElementaryModel {
  BootstrapFailedRerunModel(ErrorHandler errorHandler, this._bootstrapService)
    : super(errorHandler: errorHandler);

  final BootstrapService _bootstrapService;

  Future<void> rerunFailedSteps() async {
    try {
      await _bootstrapService.rerunFailedSteps();
    } catch (e) {
      handleError(LocaleKeys.initializationRerunFailed.tr());
    }
  }
}
