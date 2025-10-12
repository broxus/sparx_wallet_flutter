import 'dart:async';

import 'package:app/app/service/service.dart';
import 'package:app/data/models/models.dart';
import 'package:elementary/elementary.dart';
import 'package:injectable/injectable.dart';
import 'package:nekoton_repository/nekoton_repository.dart';

@injectable
class AccountAssetsTabModel extends ElementaryModel {
  AccountAssetsTabModel(
    ErrorHandler errorHandler,
    this._assetsService,
    this._tokenWalletsService,
    this._nekotonRepository,
  ) : super(errorHandler: errorHandler);

  final AssetsService _assetsService;
  final TokenWalletsService _tokenWalletsService;
  final NekotonRepository _nekotonRepository;

  Stream<TransportStrategy> get transportStrategy =>
      _nekotonRepository.currentTransportStream;

  /// Stream of token contract assets added to the account
  Stream<List<TokenContractAsset>> contractsForAccount(Address address) =>
      _assetsService.contractsForAccount(address);

  /// Stream of search results for token wallets for the address
  Stream<SearchStreamValue> searchTokenWallets(Address address) =>
      _tokenWalletsService.searchTokenWalletsForAddress(address);
}
