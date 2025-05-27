import 'package:app/feature/messenger/data/message.dart';
import 'package:app/feature/messenger/domain/service/messenger_service.dart';
import 'package:elementary/elementary.dart';
import 'package:nekoton_repository/nekoton_repository.dart' hide Message;

class AddExternalAccountModel extends ElementaryModel {
  AddExternalAccountModel(
    ErrorHandler errorHandler,
    this._nekotonRepository,
    this._messengerService,
  ) : super(errorHandler: errorHandler);

  final NekotonRepository _nekotonRepository;
  final MessengerService _messengerService;

  Future<void> addExternalAccount({
    required Address address,
    String? name,
  }) =>
      _nekotonRepository.addExternalAccount(
        address: address,
        name: name,
      );

  void showMessage(Message message) => _messengerService.show(message);
}
