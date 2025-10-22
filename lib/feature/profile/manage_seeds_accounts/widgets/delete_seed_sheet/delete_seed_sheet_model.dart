import 'package:app/feature/profile/manage_seeds_accounts/widgets/delete_seed_sheet/delete_seed_sheet.dart';
import 'package:elementary/elementary.dart';
import 'package:injectable/injectable.dart';
import 'package:nekoton_repository/nekoton_repository.dart';

/// [ElementaryModel] for [DeleteSeedSheet]
@injectable
class DeleteSeedSheetModel extends ElementaryModel {
  DeleteSeedSheetModel(ErrorHandler errorHandler, this._nekotonRepository)
    : super(errorHandler: errorHandler);

  final NekotonRepository _nekotonRepository;

  Seed? getSeedByKey(PublicKey publicKey) =>
      _nekotonRepository.seedList.findSeed(publicKey);

  void removeSeed(PublicKey publicKey) {
    _nekotonRepository.seedList.findSeed(publicKey)?.remove();
  }
}
