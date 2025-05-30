import 'package:app/app/service/service.dart';
import 'package:app/feature/nft/nft.dart';
import 'package:elementary/elementary.dart';
import 'package:nekoton_repository/nekoton_repository.dart' hide Message;
import 'package:rxdart/rxdart.dart';

class NftItemPageModel extends ElementaryModel {
  NftItemPageModel(
    ErrorHandler errorHandler,
    this._nftService,
    this._currentAccountsService,
    this._nekotonRepository,
  ) : super(errorHandler: errorHandler);

  final NftService _nftService;
  final CurrentAccountsService _currentAccountsService;
  final NekotonRepository _nekotonRepository;

  Stream<KeyAccount?> get currentAccount =>
      _currentAccountsService.currentActiveAccountStream;

  Future<Address> get _owner =>
      currentAccount.mapNotNull((e) => e?.address).first;

  Future<NftCollection?> getCollection(Address address) =>
      _nftService.getCollection(address);

  Future<NftItem?> getNftItem(Address address) async => _nftService.getNftItem(
        address: address,
        owner: await _owner,
      );

  String getAccountExplorerLink(Address address) =>
      _nekotonRepository.currentTransport.accountExplorerLink(address);
}
