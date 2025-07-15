import 'package:app/app/service/current_accounts_service.dart';
import 'package:app/feature/messenger/data/message.dart';
import 'package:app/feature/messenger/domain/service/messenger_service.dart';
import 'package:elementary/elementary.dart';
import 'package:nekoton_repository/nekoton_repository.dart' hide Message;
import 'package:rxdart/transformers.dart';

class AddNftModel extends ElementaryModel {
  AddNftModel(
    ErrorHandler errorHandler,
    this._currentAccountService,
    this._messengerService,
    this._nekotonRepository,
  ) : super(errorHandler: errorHandler);

  final CurrentAccountsService _currentAccountService;
  final MessengerService _messengerService;
  final NekotonRepository _nekotonRepository;

  Stream<KeyAccount?> get currentAccount =>
      _currentAccountService.currentActiveAccountStream;

  void showError(String message) {
    _messengerService.show(
      Message.error(message: message),
    );
  }

  Future<NftCollection?> tryGetNftCollection(Address address) async =>
      _nekotonRepository.tryGetNftCollection(
        address: address,
        owner: (await currentAccount.whereNotNull().first).address,
      );
}
