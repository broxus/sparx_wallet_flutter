import 'package:app/app/service/service.dart';
import 'package:app/feature/browser_v2/domain/browser_launcher.dart';
import 'package:app/feature/messenger/messenger.dart';
import 'package:app/feature/nft/domain/nft_display_mode_configurator.dart';
import 'package:app/feature/nft/nft.dart';
import 'package:app/generated/generated.dart';
import 'package:elementary/elementary.dart';
import 'package:injectable/injectable.dart';
import 'package:nekoton_repository/nekoton_repository.dart' hide Message;
import 'package:rxdart/rxdart.dart';

const _limit = 8;

@injectable
class NftCollectionPageModel extends ElementaryModel {
  NftCollectionPageModel(
    ErrorHandler errorHandler,
    this._nftService,
    this._nftStorageService,
    this._currentAccountsService,
    this._nekotonRepository,
    this._messengerService,
    this._browserLauncher,
    this._nftDisplayModeConfigurator,
  ) : super(errorHandler: errorHandler);

  final NftService _nftService;
  final NftStorageService _nftStorageService;
  final CurrentAccountsService _currentAccountsService;
  final NekotonRepository _nekotonRepository;
  final MessengerService _messengerService;
  final BrowserLauncher _browserLauncher;
  final NftDisplayModeConfigurator _nftDisplayModeConfigurator;

  Stream<KeyAccount?> get currentAccountStream =>
      _currentAccountsService.currentActiveAccountStream;

  Stream<NftDisplayMode?> get displayModeStream =>
      _nftDisplayModeConfigurator.displayModeStream;

  Future<Address> get _owner =>
      currentAccountStream.mapNotNull((e) => e?.address).first;

  Stream<NftTransferEvent> getNftTransferEventStream(Address collection) =>
      currentAccountStream
          .mapNotNull((e) => e?.address)
          .switchMap(
            (owner) => _nftService.getNftTransferEventStream(
              owner: owner,
              collection: collection,
            ),
          );

  Future<NftCollection?> getCollection(Address address) =>
      _nftService.getCollection(address);

  Future<NftList> getNtfList({
    required Address collection,
    String? continuation,
  }) async => _nekotonRepository.getNftList(
    owner: await _owner,
    collection: collection,
    limit: _limit,
    continuation: continuation,
  );

  void setDisplayMode(NftDisplayMode mode) =>
      _nftDisplayModeConfigurator.setDisplayMode(mode);

  Future<void> hideCollection(Address collection) async {
    _nftService.hideCollection(
      accountAddress: await _owner,
      collectionAddress: collection,
    );

    _messengerService.show(
      Message.successful(message: LocaleKeys.nftCollectionHidden.tr()),
    );
  }

  Future<List<PendingNft>> removePendingNft(Address collection) async {
    return _nftStorageService.removePendingNftByCollection(
      owner: await _owner,
      collection: collection,
      networkGroup: _nekotonRepository.currentTransport.networkGroup,
    );
  }

  void openExplorerLinkByBrowser(Address address) {
    _browserLauncher.openBrowserByString(
      _nekotonRepository.currentTransport.accountExplorerLink(address),
    );
  }
}
