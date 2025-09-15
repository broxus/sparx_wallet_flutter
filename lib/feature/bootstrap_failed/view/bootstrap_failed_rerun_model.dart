import 'package:app/app/service/bootstrap/bootstrap_service.dart';
import 'package:app/feature/messenger/data/message.dart';
import 'package:app/feature/messenger/domain/service/messenger_service.dart';
import 'package:app/generated/generated.dart';
import 'package:elementary/elementary.dart';
import 'package:injectable/injectable.dart';

@injectable
class BootstrapFailedRerunModel extends ElementaryModel {
  BootstrapFailedRerunModel(
    ErrorHandler errorHandler,
    this._bootstrapService,
    this._messengerService,
  ) : super(errorHandler: errorHandler);

  final BootstrapService _bootstrapService;
  final MessengerService _messengerService;

  Future<void> rerunFailedSteps() async {
    try {
      await _bootstrapService.rerunFailedSteps();
    } catch (e) {
      _messengerService.show(
        Message.error(
          message: LocaleKeys.initializationRerunFailed.tr(),
        ),
      );
    }
  }
}
