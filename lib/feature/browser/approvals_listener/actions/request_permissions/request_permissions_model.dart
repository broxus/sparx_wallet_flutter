import 'package:app/app/service/service.dart';
import 'package:app/data/models/models.dart';
import 'package:app/utils/utils.dart';
import 'package:elementary/elementary.dart';
import 'package:injectable/injectable.dart';
import 'package:nekoton_repository/nekoton_repository.dart';

@injectable
class RequestPermissionsModel extends ElementaryModel {
  RequestPermissionsModel(
    ErrorHandler errorHandler,
    this._nekotonRepository,
    this._permissionsService,
    this._currentAccountsService,
  ) : super(errorHandler: errorHandler);

  final NekotonRepository _nekotonRepository;
  final PermissionsService _permissionsService;
  final CurrentAccountsService _currentAccountsService;

  KeyAccount? get currentAccount =>
      _currentAccountsService.currentActiveAccount;

  Iterable<KeyAccount> get accounts => _nekotonRepository.allVisibleAccounts;

  TransportStrategy get currentTransport => _nekotonRepository.currentTransport;

  void setPermissions(Uri origin, Permissions permissions) =>
      _permissionsService.setPermissions(url: origin, permissions: permissions);
}
