import 'package:app/app/router/router.dart';
import 'package:app/core/error_handler_factory.dart';
import 'package:app/core/wm/custom_wm.dart';
import 'package:app/di/di.dart';
import 'package:app/feature/wallet/confirm_multisig_transaction/route.dart';
import 'package:app/feature/wallet/widgets/account_transactions_tab/detail/details.dart';
import 'package:app/feature/wallet/widgets/account_transactions_tab/detail/ton_wallet_multisig_pending_transaction_details/ton_wallet_multisig_pending_transaction_details_screen.dart';
import 'package:app/feature/wallet/widgets/account_transactions_tab/detail/ton_wallet_multisig_pending_transaction_details/ton_wallet_multisig_pending_transaction_details_screen_model.dart';
import 'package:elementary/elementary.dart';
import 'package:flutter/widgets.dart';
import 'package:nekoton_repository/nekoton_repository.dart';
import 'package:ui_components_lib/ui_components_lib.dart';
import 'package:ui_components_lib/v2/text_styles_v2.dart';

TonWalletMultisigPendingTransactionDetailsScreenWidgetModel
    tonWalletMultisigPendingTransactionDetailsWidgetModelFactory(
  BuildContext context, {
  required TonWalletMultisigPendingTransaction transaction,
  required Fixed price,
  required KeyAccount account,
}) {
  return TonWalletMultisigPendingTransactionDetailsScreenWidgetModel(
    TonWalletMultisigPendingTransactionDetailsScreenModel(
      createPrimaryErrorHandler(context),
      inject(),
    ),
    transaction,
    price,
    account,
  );
}

/// [WidgetModel] для [TonWalletMultisigPendingTransactionDetailsScreen]
class TonWalletMultisigPendingTransactionDetailsScreenWidgetModel
    extends CustomWidgetModel<TonWalletMultisigPendingTransactionDetailsScreen,
        TonWalletMultisigPendingTransactionDetailsScreenModel> {
  TonWalletMultisigPendingTransactionDetailsScreenWidgetModel(
    super.model,
    this._transaction,
    this.price,
    this.account,
  );

  final TonWalletMultisigPendingTransaction _transaction;
  final Fixed price;
  final KeyAccount account;

  late final safeHexString =
      int.tryParse(_transaction.transactionId)?.toRadixString(16);

  late final date = _transaction.date;
  late final isIncoming = !_transaction.isOutgoing;
  late final transactionFee = Money.fromBigIntWithCurrency(
    _transaction.fees,
    Currencies()[model.ticker]!,
  );
  late final transactionValue = Money.fromBigIntWithCurrency(
    _transaction.value,
    Currencies()[model.ticker]!,
  );
  late final transactionHash = _transaction.hash;
  late final transactionAddress = _transaction.address;
  late final transactionComment = _transaction.comment;
  late final info = _methodData?.$1;
  late final expiresAt = _transaction.expireAt;
  late final transactionId = safeHexString;
  late final confirmations = _transaction.confirmations;
  late final requiredConfirmations = _transaction.signsRequired;
  late final custodians = _transaction.custodians;
  late final initiator = _transaction.creator;
  late final isCanConfirm = _transaction.canConfirm;

  late final _methodData =
      _transaction.walletInteractionInfo?.method.toRepresentableData();

  late final tonIconPath = model.tonIconPath;

  TextStylesV2 get textStyles => _theme.textStyles;

  ColorsPaletteV2 get colors => _theme.colors;

  ThemeStyleV2 get _theme => context.themeStyleV2;

  void onPressedConfirm() {
    Navigator.of(context).pop();
    context.compassContinue(
      ConfirmMultisigTransactionRouteData(
        walletAddress: _transaction.walletAddress,
        localCustodians: _transaction.nonConfirmedLocalCustodians,
        transactionId: _transaction.transactionId,
        transactionIdHash: safeHexString,
        destination: _transaction.address,
        amount: _transaction.value,
        comment: _transaction.comment,
      ),
    );
  }
}
