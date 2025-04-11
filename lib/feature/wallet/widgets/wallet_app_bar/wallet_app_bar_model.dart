import 'package:app/app/service/service.dart';
import 'package:collection/collection.dart';
import 'package:elementary/elementary.dart';
import 'package:nekoton_repository/nekoton_repository.dart';
import 'package:rxdart/rxdart.dart';

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

  Stream<KeyAccount?> get currentActiveAccount =>
      _currentAccountsService.currentActiveAccountStream;

  Stream<TonWalletState?> get walletState => CombineLatestStream.combine2(
        _nekotonRepository.walletsStream,
        currentActiveAccount,
        (wallets, account) => wallets.firstWhereOrNull(
          (w) => w.address == account?.address,
        ),
      );

  Stream<ConnectionData?> get connectionStream =>
      _storageService.currentConnectionStream;

  TransportStrategy get transport => _nekotonRepository.currentTransport;

  void handleUri(Uri uri) => _appLinksService.handleAppLink(uri);
}
