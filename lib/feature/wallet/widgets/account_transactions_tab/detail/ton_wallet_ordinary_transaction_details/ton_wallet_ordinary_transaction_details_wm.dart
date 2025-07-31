import 'package:app/core/wm/custom_wm.dart';
import 'package:app/feature/browser_v1/utils.dart';
import 'package:app/feature/wallet/widgets/account_transactions_tab/detail/details.dart';
import 'package:app/feature/wallet/widgets/account_transactions_tab/detail/ton_wallet_ordinary_transaction_details/ton_wallet_ordinary_transaction_details.dart';
import 'package:app/feature/wallet/widgets/account_transactions_tab/detail/ton_wallet_ordinary_transaction_details/ton_wallet_ordinary_transaction_details_model.dart';
import 'package:elementary/elementary.dart';
import 'package:flutter/widgets.dart';
import 'package:injectable/injectable.dart';
import 'package:nekoton_repository/nekoton_repository.dart';
import 'package:ui_components_lib/ui_components_lib.dart';
import 'package:ui_components_lib/v2/text_styles_v2.dart';

class TonWalletOrdinaryTransactionDetailsWmParams {
  TonWalletOrdinaryTransactionDetailsWmParams({
    required this.transaction,
    required this.price,
  });

  final TonWalletOrdinaryTransaction transaction;
  final Fixed price;
}

/// [WidgetModel] для [TonWalletOrdinaryTransactionDetails]
@injectable
class TonWalletOrdinaryTransactionDetailsWidgetModel
    extends CustomWidgetModelParametrized<
        TonWalletOrdinaryTransactionDetails,
        TonWalletOrdinaryTransactionDetailsModel,
        TonWalletOrdinaryTransactionDetailsWmParams> {
  TonWalletOrdinaryTransactionDetailsWidgetModel(
    super.model,
  );

  late final priceState = createWmParamsNotifier<Fixed>(
    (it) => it.price,
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

  late final transactionInfoState = createWmParamsNotifier<String?>(
    (it) =>
        it.transaction.walletInteractionInfo?.method.toRepresentableData().$1,
  );

  late final tonIconPathState = createNotifier<String>(model.tonIconPath);

  ColorsPaletteV2 get colors => _theme.colors;

  TextStylesV2 get textStyles => _theme.textStyles;

  ThemeStyleV2 get _theme => context.themeStyleV2;

  double get bottomPadding => MediaQuery.of(context).padding.bottom;

  void onPressedSeeInExplorer() {
    Navigator.of(context).pop();
    openBrowserUrl(
      model.getTransactionExplorerLink(wmParams.value.transaction.hash),
    );
  }
}
