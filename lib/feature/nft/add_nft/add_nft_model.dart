import 'package:app/app/service/current_accounts_service.dart';
import 'package:elementary/elementary.dart';
import 'package:nekoton_repository/nekoton_repository.dart';

class AddNftModel extends ElementaryModel {
  AddNftModel(
      ErrorHandler errorHandler,
      this._currentAccountService,
      ) : super(errorHandler: errorHandler);

  final CurrentAccountsService _currentAccountService;

  Stream<KeyAccount?> get currentAccount =>
      _currentAccountService.currentActiveAccountStream;
}
