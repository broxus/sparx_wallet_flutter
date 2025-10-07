import 'package:app/feature/wallet/widgets/account_transactions_tab/widgets/ton_wallet_pending_transaction_widget/ton_wallet_pending_transaction_widget.dart';
import 'package:elementary/elementary.dart';
import 'package:injectable/injectable.dart';
import 'package:nekoton_repository/nekoton_repository.dart';

/// [ElementaryModel] for [TonWalletPendingTransactionWidget]
@injectable
class TonWalletPendingTransactionWidgetModel extends ElementaryModel {
  TonWalletPendingTransactionWidgetModel(
    ErrorHandler errorHandler,
    this._nekotonRepository,
  ) : super(errorHandler: errorHandler);

  final NekotonRepository _nekotonRepository;

  late final ticker = _nekotonRepository.currentTransport.nativeTokenTicker;

  Money getTransactionValueByAmount(BigInt amount) =>
      Money.fromBigIntWithCurrency(
        amount,
        Currencies()[ticker]!,
      );
}
