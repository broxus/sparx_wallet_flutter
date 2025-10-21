import 'package:app/feature/wallet/widgets/account_transactions_tab/widgets/ton_wallet_expired_transaction_widget/ton_wallet_expired_transaction_widget.dart';
import 'package:elementary/elementary.dart';
import 'package:injectable/injectable.dart';
import 'package:money2/money2.dart';
import 'package:nekoton_repository/nekoton_repository.dart';

/// [ElementaryModel] for [TonWalletExpiredTransactionWidget]
@injectable
class TonWalletExpiredTransactionWidgetModel extends ElementaryModel {
  TonWalletExpiredTransactionWidgetModel(
    ErrorHandler errorHandler,
    this._nekotonRepository,
  ) : super(errorHandler: errorHandler);

  final NekotonRepository _nekotonRepository;

  late final _ticker = _nekotonRepository.currentTransport.nativeTokenTicker;

  Money getTransactionValue(BigInt amount) =>
      Money.fromBigIntWithCurrency(amount, Currencies()[_ticker]!);
}
