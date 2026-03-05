import 'package:app/app/service/current_accounts_service.dart';
import 'package:elementary/elementary.dart';
import 'package:injectable/injectable.dart';
import 'package:nekoton_repository/nekoton_repository.dart' hide Message;
import 'package:rxdart/transformers.dart';

@injectable
class AddNftModel extends ElementaryModel {
  AddNftModel(
    ErrorHandler errorHandler,
    this._currentAccountService,
    this._nekotonRepository,
  ) : super(errorHandler: errorHandler);

  final CurrentAccountsService _currentAccountService;
  final NekotonRepository _nekotonRepository;

  Stream<KeyAccount?> get currentAccount =>
      _currentAccountService.currentActiveAccountStream;

  void showError(String message) => handleError(message);

  Future<NftCollection?> tryGetNftCollection(Address address) async =>
      _nekotonRepository.tryGetNftCollection(
        address: address,
        owner: (await currentAccount.whereNotNull().first).address,
      );
}
