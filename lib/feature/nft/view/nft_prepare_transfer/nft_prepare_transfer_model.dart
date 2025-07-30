import 'dart:async';

import 'package:app/feature/messenger/data/message.dart';
import 'package:app/feature/messenger/domain/service/messenger_service.dart';
import 'package:app/feature/nft/nft.dart';
import 'package:elementary/elementary.dart';
import 'package:injectable/injectable.dart';
import 'package:logging/logging.dart';
import 'package:nekoton_repository/nekoton_repository.dart' hide Message;

@injectable
class NftPrepareTransferModel extends ElementaryModel {
  NftPrepareTransferModel(
    ErrorHandler errorHandler,
    this._nekotonRepository,
    this._messengerService,
    this._nftService,
  ) : super(errorHandler: errorHandler);

  static final _logger = Logger('NftPrepareTransferModel');

  final NekotonRepository _nekotonRepository;
  final MessengerService _messengerService;
  final NftService _nftService;

  Future<NftCollection?> getCollection(Address address) =>
      _nftService.getCollection(address);

  Future<NftItem?> getNftItem({
    required Address address,
    required Address owner,
  }) =>
      _nftService.getNftItem(address: address, owner: owner);

  Future<List<PublicKey>?> getLocalCustodiansAsync(Address address) async {
    try {
      return await _nekotonRepository.getLocalCustodiansAsync(address);
    } on Object catch (e, t) {
      _logger.severe('getLocalCustodiansAsync', e, t);
    }

    return null;
  }

  KeyAccount? findAccountByAddress(Address address) {
    return _nekotonRepository.seedList.findAccountByAddress(address);
  }

  String? getSeedName(PublicKey custodian) {
    return _nekotonRepository.seedList.findSeedKey(custodian)?.name;
  }

  void showError(String text) {
    _messengerService.show(
      Message.error(message: text),
    );
  }
}
