import 'package:app/core/wm/custom_wm.dart';
import 'package:app/feature/wallet/widgets/account_transactions_tab/detail/details.dart';
import 'package:app/feature/wallet/widgets/account_transactions_tab/detail/ton_wallet_multisig_ordinary_transaction_details/ton_wallet_multisig_ordinary_transaction_details_screen_model.dart';
import 'package:elementary/elementary.dart';
import 'package:flutter/widgets.dart';
import 'package:injectable/injectable.dart';
import 'package:money2/money2.dart';
import 'package:nekoton_repository/nekoton_repository.dart';
import 'package:ui_components_lib/v2/colors_v2.dart';
import 'package:ui_components_lib/v2/text_styles_v2.dart';
import 'package:ui_components_lib/v2/theme_style_v2.dart';

class TonWalletMultisigOrdinaryTransactionDetailsWmParams {
  TonWalletMultisigOrdinaryTransactionDetailsWmParams({
    required this.price,
    required this.account,
    required this.transaction,
  });

  final Fixed price;
  final KeyAccount account;
  final TonWalletMultisigOrdinaryTransaction transaction;
}

/// [WidgetModel] для [TonWalletMultisigOrdinaryTransactionDetailsScreen]
@injectable
class TonWalletMultisigOrdinaryTransactionDetailsScreenWidgetModel
    extends
        CustomWidgetModelParametrized<
          TonWalletMultisigOrdinaryTransactionDetailsScreen,
          TonWalletMultisigOrdinaryTransactionDetailsScreenModel,
          TonWalletMultisigOrdinaryTransactionDetailsWmParams
        > {
  TonWalletMultisigOrdinaryTransactionDetailsScreenWidgetModel(super.model);

  late final accountState = createWmParamsNotifier<KeyAccount>(
    (it) => it.account,
  );

  late final priceState = createWmParamsNotifier<Fixed>((it) => it.price);

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

  late final tonIconPathState = createNotifier<String>(model.tonIconPath);

  late final confirmationsState = createWmParamsNotifier<List<PublicKey>>(
    (it) => it.transaction.confirmations,
  );

  late final custodiansState = createWmParamsNotifier<List<PublicKey>>(
    (it) => it.transaction.custodians,
  );

  late final initiatorState = createWmParamsNotifier<PublicKey>(
    (it) => it.transaction.creator,
  );

  TextStylesV2 get textStyles => _theme.textStyles;

  ColorsPaletteV2 get colors => _theme.colors;

  ThemeStyleV2 get _theme => context.themeStyleV2;

  double get bottomPadding => MediaQuery.of(context).padding.bottom;

  void onPressedSeeInExplorer() {
    Navigator.of(context).pop();
    model.openBrowserUrl(
      model.getTransactionExplorerLink(wmParams.value.transaction.hash),
    );
  }
}
