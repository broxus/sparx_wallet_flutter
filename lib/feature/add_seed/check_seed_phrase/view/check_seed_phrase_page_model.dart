import 'package:app/feature/messenger/data/message.dart';
import 'package:app/feature/messenger/domain/service/messenger_service.dart';
import 'package:elementary/elementary.dart';
import 'package:injectable/injectable.dart';

@injectable
class CheckSeedPhrasePageModel extends ElementaryModel {
  CheckSeedPhrasePageModel(ErrorHandler errorHandler, this._messengerService)
    : super(errorHandler: errorHandler);

  final MessengerService _messengerService;

  void showValidateError(String message) {
    _messengerService.show(Message.error(message: message));
  }
}
