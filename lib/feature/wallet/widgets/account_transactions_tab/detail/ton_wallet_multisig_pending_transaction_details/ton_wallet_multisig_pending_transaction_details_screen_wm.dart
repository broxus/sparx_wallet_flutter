import 'package:app/app/router/router.dart';
import 'package:app/core/wm/custom_wm.dart';
import 'package:app/feature/wallet/confirm_multisig_transaction/route.dart';
import 'package:app/feature/wallet/widgets/account_transactions_tab/detail/details.dart';
import 'package:app/feature/wallet/widgets/account_transactions_tab/detail/ton_wallet_multisig_pending_transaction_details/ton_wallet_multisig_pending_transaction_details_screen.dart';
import 'package:app/feature/wallet/widgets/account_transactions_tab/detail/ton_wallet_multisig_pending_transaction_details/ton_wallet_multisig_pending_transaction_details_screen_model.dart';
import 'package:elementary/elementary.dart';
import 'package:flutter/widgets.dart';
import 'package:injectable/injectable.dart';
import 'package:nekoton_repository/nekoton_repository.dart';
import 'package:ui_components_lib/ui_components_lib.dart';
import 'package:ui_components_lib/v2/text_styles_v2.dart';

class TonWalletMultisigPendingTransactionDetailsWmParams {
  TonWalletMultisigPendingTransactionDetailsWmParams({
    required this.transaction,
    required this.price,
    required this.account,
  });

  final TonWalletMultisigPendingTransaction transaction;
  final Fixed price;
  final KeyAccount account;
}

/// [WidgetModel] для [TonWalletMultisigPendingTransactionDetailsScreen]
@injectable
class TonWalletMultisigPendingTransactionDetailsScreenWidgetModel
    extends CustomWidgetModelParametrized<
        TonWalletMultisigPendingTransactionDetailsScreen,
        TonWalletMultisigPendingTransactionDetailsScreenModel,
        TonWalletMultisigPendingTransactionDetailsWmParams> {
  TonWalletMultisigPendingTransactionDetailsScreenWidgetModel(
    super.model,
  );

  late final accountState = createWmParamsNotifier<KeyAccount>(
    (it) => it.account,
  );

  late final priceState = createWmParamsNotifier<Fixed>(
    (it) => it.price,
  );

  late final safeHexStringState = createWmParamsNotifier<String?>(
    (it) => int.tryParse(it.transaction.transactionId)?.toRadixString(16),
  );

  late final dateState = createWmParamsNotifier<DateTime>(
    (it) => it.transaction.date,
  );

  late final isIncomingState = createWmParamsNotifier<bool>(
    (it) => !it.transaction.isOutgoing,
  );

  late final transactionFeeState = createWmParamsNotifier<Money>(
    (it) => Money.fromBigIntWithCurrency(
      it.transaction.fees,
      Currencies()[model.ticker]!,
    ),
  );

  late final transactionValueState = createWmParamsNotifier<Money>(
    (it) => Money.fromBigIntWithCurrency(
      it.transaction.value,
      Currencies()[model.ticker]!,
    ),
  );

  late final transactionHashState = createWmParamsNotifier<String>(
    (it) => it.transaction.hash,
  );

  late final transactionAddressState = createWmParamsNotifier<Address>(
    (it) => it.transaction.address,
  );

  late final transactionCommentState = createWmParamsNotifier<String?>(
    (it) => it.transaction.comment,
  );

  late final infoState = createWmParamsNotifier<String?>(
    (it) =>
        it.transaction.walletInteractionInfo?.method.toRepresentableData().$1,
  );

  late final expiresAtState = createWmParamsNotifier<DateTime>(
    (it) => it.transaction.expireAt,
  );

  late final confirmationsState = createWmParamsNotifier<List<PublicKey>>(
    (it) => it.transaction.confirmations,
  );

  late final requiredConfirmationsState = createWmParamsNotifier<int>(
    (it) => it.transaction.signsRequired,
  );

  late final custodiansState = createWmParamsNotifier<List<PublicKey>>(
    (it) => it.transaction.custodians,
  );

  late final initiatorState = createWmParamsNotifier<PublicKey>(
    (it) => it.transaction.creator,
  );

  late final isCanConfirmState = createWmParamsNotifier<bool>(
    (it) => it.transaction.canConfirm,
  );

  late final tonIconPathState = createNotifier<String>(model.tonIconPath);

  TextStylesV2 get textStyles => _theme.textStyles;

  ColorsPaletteV2 get colors => _theme.colors;

  ThemeStyleV2 get _theme => context.themeStyleV2;

  void onPressedConfirm() {
    final params = wmParams.value;
    final transaction = params.transaction;
    final hexString = safeHexStringState.value;

    Navigator.of(context).pop();
    context.compassContinue(
      ConfirmMultisigTransactionRouteData(
        walletAddress: transaction.walletAddress,
        localCustodians: transaction.nonConfirmedLocalCustodians,
        transactionId: transaction.transactionId,
        transactionIdHash: hexString,
        destination: transaction.address,
        amount: transaction.value,
        comment: transaction.comment,
      ),
    );
  }
}
