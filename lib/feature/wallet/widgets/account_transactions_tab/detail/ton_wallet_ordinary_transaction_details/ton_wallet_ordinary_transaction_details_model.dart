import 'package:app/feature/wallet/widgets/account_transactions_tab/detail/ton_wallet_ordinary_transaction_details/ton_wallet_ordinary_transaction_details.dart';
import 'package:elementary/elementary.dart';
import 'package:injectable/injectable.dart';
import 'package:nekoton_repository/nekoton_repository.dart';

/// [ElementaryModel] for [TonWalletOrdinaryTransactionDetails]
@injectable
class TonWalletOrdinaryTransactionDetailsModel extends ElementaryModel {
  TonWalletOrdinaryTransactionDetailsModel(
    ErrorHandler errorHandler,
    this._nekotonRepository,
  ) : super(errorHandler: errorHandler);

  final NekotonRepository _nekotonRepository;

  late final ticker = _nekotonRepository.currentTransport.nativeTokenTicker;

  late final tonIconPath = _nekotonRepository.currentTransport.nativeTokenIcon;

  String getTransactionExplorerLink(String hash) =>
      _nekotonRepository.currentTransport.transactionExplorerLink(hash);
}
