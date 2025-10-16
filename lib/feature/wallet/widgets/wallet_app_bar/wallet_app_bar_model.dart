import 'package:app/app/service/connection/data/connection/connection.dart';
import 'package:app/app/service/service.dart';
import 'package:elementary/elementary.dart';
import 'package:injectable/injectable.dart';
import 'package:nekoton_repository/nekoton_repository.dart';
import 'package:rxdart/rxdart.dart';

@injectable
class WalletAppBarModel extends ElementaryModel {
  WalletAppBarModel(
    ErrorHandler errorHandler,
    this._nekotonRepository,
    this._currentAccountsService,
    this._storageService,
    this._appLinksService,
  ) : super(errorHandler: errorHandler);

  final NekotonRepository _nekotonRepository;
  final CurrentAccountsService _currentAccountsService;
  final ConnectionsStorageService _storageService;
  final AppLinksService _appLinksService;

  Stream<KeyAccount> get currentAccount =>
      _currentAccountsService.currentActiveAccountStream.whereNotNull();

  Stream<TonWalletState?> get walletState => CombineLatestStream.combine2(
        _nekotonRepository.walletsMapStream,
        currentAccount,
        (wallets, account) => wallets[account.address],
      );

  Stream<Connection?> get connectionStream =>
      _storageService.currentConnectionStream;

  TransportStrategy get transport => _nekotonRepository.currentTransport;

  void handleUri(Uri uri) => _appLinksService.handleAppLink(uri);
}
