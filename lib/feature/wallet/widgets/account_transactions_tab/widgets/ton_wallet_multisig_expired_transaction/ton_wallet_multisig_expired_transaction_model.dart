import 'package:app/feature/browser_v2/domain/browser_launcher.dart';
import 'package:app/feature/wallet/widgets/account_transactions_tab/widgets/ton_wallet_multisig_expired_transaction/ton_wallet_multisig_expired_transaction_widget.dart';
import 'package:elementary/elementary.dart';
import 'package:nekoton_repository/nekoton_repository.dart';

/// [ElementaryModel] for [TonWalletMultisigExpiredTransactionWidget]
class TonWalletMultisigExpiredTransactionModel extends ElementaryModel {
  TonWalletMultisigExpiredTransactionModel(
    ErrorHandler errorHandler,
    this._nekotonRepository,
    this._browserLauncher,
  ) : super(errorHandler: errorHandler);

  final NekotonRepository _nekotonRepository;

  final BrowserLauncher _browserLauncher;

  late final nativeTokenTicker =
      _nekotonRepository.currentTransport.nativeTokenTicker;

  late final tonIconPath = _nekotonRepository.currentTransport.nativeTokenIcon;

  void openBrowserUrl(String hash) {
    _browserLauncher.openBrowserByString(
      _nekotonRepository.currentTransport.transactionExplorerLink(hash),
    );
  }
}
