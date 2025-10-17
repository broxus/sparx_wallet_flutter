import 'package:app/app/service/bootstrap/bootstrap_service.dart';
import 'package:app/feature/connection_fail/connection_fail_screen.dart';
import 'package:app/feature/messenger/data/message.dart';
import 'package:app/feature/messenger/domain/service/messenger_service.dart';
import 'package:app/generated/generated.dart';
import 'package:elementary/elementary.dart';
import 'package:injectable/injectable.dart';

/// [ElementaryModel] for [ConnectionFailScreen]
@injectable
class ConnectionFailModel extends ElementaryModel {
  ConnectionFailModel(
    ErrorHandler errorHandler,
    this.bootstrapService,
    this.messengerService,
  ) : super(errorHandler: errorHandler);

  final BootstrapService bootstrapService;
  final MessengerService messengerService;

  Future<void> tryAgain() async {
    try {
      await bootstrapService.rerunFailedSteps();
    } catch (e) {
      messengerService.show(
        Message.error(message: LocaleKeys.initializationRerunFailed.tr()),
      );
    }
  }
}
