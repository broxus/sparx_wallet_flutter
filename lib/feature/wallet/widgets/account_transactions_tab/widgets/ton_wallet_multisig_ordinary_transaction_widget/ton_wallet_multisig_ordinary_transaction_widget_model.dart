import 'package:app/feature/wallet/widgets/account_transactions_tab/widgets/ton_wallet_multisig_ordinary_transaction_widget/ton_wallet_multisig_ordinary_transaction_widget.dart';
import 'package:elementary/elementary.dart';
import 'package:injectable/injectable.dart';
import 'package:money2/money2.dart';
import 'package:nekoton_repository/nekoton_repository.dart';

/// [ElementaryModel] for [TonWalletMultisigOrdinaryTransactionWidget]
@injectable
class TonWalletMultisigOrdinaryTransactionWidgetModel extends ElementaryModel {
  TonWalletMultisigOrdinaryTransactionWidgetModel(
    ErrorHandler errorHandler,
    this._nekotonRepository,
  ) : super(errorHandler: errorHandler);

  final NekotonRepository _nekotonRepository;

  Money getTransactionFee(BigInt fees) =>
      Money.fromBigIntWithCurrency(fees, Currencies()[_ticker]!);

  Money getTransactionValue(BigInt transactionValue) =>
      Money.fromBigIntWithCurrency(transactionValue, Currencies()[_ticker]!);

  late final _ticker = _nekotonRepository.currentTransport.nativeTokenTicker;
}
