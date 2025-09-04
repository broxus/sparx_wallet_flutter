import 'package:app/app/service/service.dart';
import 'package:app/data/models/models.dart';
import 'package:app/feature/browser_v2/domain/browser_launcher.dart';
import 'package:app/feature/wallet/token_wallet_details/widgets/detail/token_wallet_ordinary_transaction_details_screen.dart';
import 'package:elementary/elementary.dart';
import 'package:injectable/injectable.dart';
import 'package:nekoton_repository/nekoton_repository.dart';

/// [ElementaryModel] for [TokenWalletOrdinaryTransactionDetailsScreen]
@injectable
class TokenWalletOrdinaryTransactionDetailsScreenModel extends ElementaryModel {
  TokenWalletOrdinaryTransactionDetailsScreenModel(
    ErrorHandler errorHandler,
    this._assetsService,
    this._nekotonRepository,
    this._browserLauncher,
  ) : super(errorHandler: errorHandler);

  final AssetsService _assetsService;
  final NekotonRepository _nekotonRepository;
  final BrowserLauncher _browserLauncher;

  late final nativeTokenTicker =
      _nekotonRepository.currentTransport.nativeTokenTicker;

  late final nativeTokenIcon =
      _nekotonRepository.currentTransport.nativeTokenIcon;

  TokenContractAsset? getMaybeGetTokenContract(Address rootTokenContract) {
    return _assetsService.maybeGetTokenContract(
      rootTokenContract,
      _nekotonRepository.currentTransport,
    );
  }

  void openUrlByExplorerLink(String hash) {
    _browserLauncher.openBrowserByString(
      _nekotonRepository.currentTransport.transactionExplorerLink(hash),
    );
  }
}
