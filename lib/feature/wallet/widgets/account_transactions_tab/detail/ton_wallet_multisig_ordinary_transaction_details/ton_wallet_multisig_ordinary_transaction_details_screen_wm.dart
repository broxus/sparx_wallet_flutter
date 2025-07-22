import 'package:app/core/wm/custom_wm.dart';
import 'package:app/feature/browser_v1/utils.dart';
import 'package:app/feature/wallet/widgets/account_transactions_tab/detail/details.dart';
import 'package:app/feature/wallet/widgets/account_transactions_tab/detail/ton_wallet_multisig_ordinary_transaction_details/ton_wallet_multisig_ordinary_transaction_details_screen_model.dart';
import 'package:elementary/elementary.dart';
import 'package:flutter/widgets.dart';
import 'package:injectable/injectable.dart';
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
    extends InjectedWidgetModel<
        TonWalletMultisigOrdinaryTransactionDetailsScreen,
        TonWalletMultisigOrdinaryTransactionDetailsScreenModel,
        TonWalletMultisigOrdinaryTransactionDetailsWmParams> {
  TonWalletMultisigOrdinaryTransactionDetailsScreenWidgetModel(
    super.model,
  );

  late final account = createWmParamsNotifier<KeyAccount>(
    (it) => it.account,
  );

  late final price = createWmParamsNotifier<Fixed>(
    (it) => it.price,
  );

  late final date = createWmParamsNotifier<DateTime>(
    (it) => it.transaction.date,
  );

  late final isIncoming = createWmParamsNotifier<bool>(
    (it) => !it.transaction.isOutgoing,
  );

  late final transactionFee = createWmParamsNotifier<Money>(
    (it) => Money.fromBigIntWithCurrency(
      it.transaction.fees,
      Currencies()[model.ticker]!,
    ),
  );

  late final transactionValue = createWmParamsNotifier<Money>(
    (it) => Money.fromBigIntWithCurrency(
      it.transaction.value,
      Currencies()[model.ticker]!,
    ),
  );

  late final transactionHash = createWmParamsNotifier<String>(
    (it) => it.transaction.hash,
  );

  late final transactionAddress = createWmParamsNotifier<Address>(
    (it) => it.transaction.address,
  );

  late final transactionComment = createWmParamsNotifier<String?>(
    (it) => it.transaction.comment,
  );

  late final info = createWmParamsNotifier<String?>(
    (it) =>
        it.transaction.walletInteractionInfo?.method.toRepresentableData().$1,
  );

  late final tonIconPath = createNotifier<String>(model.tonIconPath);

  late final confirmations = createWmParamsNotifier<List<PublicKey>>(
    (it) => it.transaction.confirmations,
  );

  late final custodians = createWmParamsNotifier<List<PublicKey>>(
    (it) => it.transaction.custodians,
  );

  late final initiator = createWmParamsNotifier<PublicKey>(
    (it) => it.transaction.creator,
  );

  TextStylesV2 get textStyles => _theme.textStyles;

  ColorsPaletteV2 get colors => _theme.colors;

  ThemeStyleV2 get _theme => context.themeStyleV2;

  void onPressedSeeInExplorer() {
    Navigator.of(context).pop();
    openBrowserUrl(
      model.getTransactionExplorerLink(wmParams.value.transaction.hash),
    );
  }
}
