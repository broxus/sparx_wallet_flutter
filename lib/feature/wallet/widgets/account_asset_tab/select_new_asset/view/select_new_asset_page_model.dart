import 'package:app/app/service/service.dart';
import 'package:app/data/models/models.dart';
import 'package:app/feature/messenger/data/message.dart';
import 'package:app/feature/messenger/domain/service/messenger_service.dart';
import 'package:app/generated/generated.dart';
import 'package:elementary/elementary.dart';
import 'package:injectable/injectable.dart';
import 'package:nekoton_repository/nekoton_repository.dart' hide Message;

@injectable
class SelectNewAssetPageModel extends ElementaryModel {
  SelectNewAssetPageModel(
    ErrorHandler errorHandler,
    this._assetsService,
    this._nekotonRepository,
    this._messengerService,
  ) : super(errorHandler: errorHandler);

  final AssetsService _assetsService;
  final NekotonRepository _nekotonRepository;
  final MessengerService _messengerService;

  Stream<KeyAccount?> accountStreamForAddress(Address address) =>
      _nekotonRepository.seedListStream
          .map((list) => list.findAccountByAddress(address));

  Stream<List<(TokenContractAsset, bool)>> availableContractsSorted(
    Address address,
  ) {
    return _assetsService
        .allAvailableContractsForAccount(address)
        .map((allContracts) {
      final manifestAssets = _assetsService.currentSystemTokenContractAssets;
      final mappedAssets = {
        for (final entry in manifestAssets.indexed) entry.$2.address: entry.$1,
      };

      final items = [
        ...allContracts.$2.map((e) => (e, true)),
        ...allContracts.$1.map((e) => (e, false)),
      ]..sort((a, b) {
          final aIndex = mappedAssets[a.$1.address];
          final bIndex = mappedAssets[b.$1.address];

          if (aIndex == null) return 1;
          if (bIndex == null) return -1;

          return aIndex.compareTo(bIndex);
        });

      return items;
    });
  }

  Future<TokenContractAsset?> getTokenContractAsset(Address address) =>
      _assetsService.getTokenContractAsset(
        repackAddress(address),
        _nekotonRepository.currentTransport,
      );

  void showInvalidRootTokenContractError() {
    _messengerService.show(
      Message.error(message: LocaleKeys.invalidRootTokenContract.tr()),
    );
  }
}
