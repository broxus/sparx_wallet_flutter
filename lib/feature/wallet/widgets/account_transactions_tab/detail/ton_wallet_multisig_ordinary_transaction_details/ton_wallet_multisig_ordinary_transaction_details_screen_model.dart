import 'package:app/feature/wallet/widgets/account_transactions_tab/detail/ton_wallet_multisig_ordinary_transaction_details/ton_wallet_multisig_ordinary_transaction_details_screen.dart';
import 'package:elementary/elementary.dart';
import 'package:injectable/injectable.dart';
import 'package:nekoton_repository/nekoton_repository.dart';

/// [ElementaryModel] for [TonWalletMultisigOrdinaryTransactionDetailsScreen]
@injectable
class TonWalletMultisigOrdinaryTransactionDetailsScreenModel
    extends ElementaryModel {
  TonWalletMultisigOrdinaryTransactionDetailsScreenModel(
    ErrorHandler errorHandler,
    this._nekotonRepository,
  ) : super(errorHandler: errorHandler);

  final NekotonRepository _nekotonRepository;

  late final ticker = _nekotonRepository.currentTransport.nativeTokenTicker;
  late final tonIconPath = _nekotonRepository.currentTransport.nativeTokenIcon;

  String getTransactionExplorerLink(String hash) =>
      _nekotonRepository.currentTransport.transactionExplorerLink(hash);
}
