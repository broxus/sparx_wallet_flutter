import 'package:app/app/service/storage_service/app_storage_service.dart';
import 'package:app/feature/nft/data/nft_display_mode.dart';
import 'package:injectable/injectable.dart';

@lazySingleton
class NftDisplayModeConfigurator {
  NftDisplayModeConfigurator(this._appStorageService);

  final AppStorageService _appStorageService;

  Stream<NftDisplayMode?> get displayModeStream => _appStorageService
      .getValueStream<String>(StorageKey.nftGridMode())
      .map((name) => name != null ? NftDisplayMode.byName(name) : null);

  void setDisplayMode(NftDisplayMode mode) {
    _appStorageService.addValue(StorageKey.nftGridMode(), mode.name);
  }
}
