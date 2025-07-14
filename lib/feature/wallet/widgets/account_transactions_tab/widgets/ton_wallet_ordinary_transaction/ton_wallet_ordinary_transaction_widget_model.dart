import 'package:app/feature/wallet/widgets/account_transactions_tab/widgets/ton_wallet_ordinary_transaction/ton_wallet_ordinary_transaction_widget.dart';
import 'package:elementary/elementary.dart';
import 'package:nekoton_repository/nekoton_repository.dart';

/// [ElementaryModel] for [TonWalletOrdinaryTransactionWidget]
class TonWalletOrdinaryTransactionWidgetModel extends ElementaryModel {
  TonWalletOrdinaryTransactionWidgetModel(
    ErrorHandler errorHandler,
    this._nekotonRepository,
  ) : super(errorHandler: errorHandler);

  final NekotonRepository _nekotonRepository;

  late final ticker = _nekotonRepository.currentTransport.nativeTokenTicker;
}
