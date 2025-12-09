import 'package:app/app/service/service.dart';
import 'package:app/feature/messenger/messenger.dart';
import 'package:elementary/elementary.dart';
import 'package:injectable/injectable.dart';
import 'package:nekoton_repository/nekoton_repository.dart' hide Message;
import 'package:rxdart/rxdart.dart';

@injectable
class WalletAppBarModel extends ElementaryModel {
  WalletAppBarModel(
    ErrorHandler errorHandler,
    this._nekotonRepository,
    this._currentAccountsService,
    this._storageService,
    this._appLinksService,
    this._messengerService,
  ) : super(errorHandler: errorHandler);

  final NekotonRepository _nekotonRepository;
  final CurrentAccountsService _currentAccountsService;
  final ConnectionsStorageService _storageService;
  final AppLinksService _appLinksService;
  final MessengerService _messengerService;

  Stream<KeyAccount> get currentAccount =>
      _currentAccountsService.currentActiveAccountStream.whereNotNull();

  Stream<TonWalletState?> get walletState => CombineLatestStream.combine2(
    _nekotonRepository.walletsMapStream,
    currentAccount,
    (wallets, account) => wallets[account.address],
  );

  Stream<ConnectionData?> get connectionStream =>
      _storageService.currentConnectionStream;

  TransportStrategy get transport => _nekotonRepository.currentTransport;

  void handleUri(Uri uri) => _appLinksService.handleAppLink(uri);

  bool isValidAppLink(Uri uri) => _appLinksService.isValidAppLink(uri);

  void showError(String text) {
    _messengerService.show(Message.error(message: text));
  }
}
