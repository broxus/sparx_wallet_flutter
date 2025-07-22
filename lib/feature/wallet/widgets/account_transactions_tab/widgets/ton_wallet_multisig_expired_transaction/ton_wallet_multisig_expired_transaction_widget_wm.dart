import 'package:app/core/wm/custom_wm.dart';
import 'package:app/feature/browser_v1/browser.dart';
import 'package:app/feature/wallet/widgets/account_transactions_tab/detail/details.dart';
import 'package:app/feature/wallet/widgets/account_transactions_tab/widgets/ton_wallet_multisig_expired_transaction/ton_wallet_multisig_expired_transaction_model.dart';
import 'package:app/feature/wallet/widgets/account_transactions_tab/widgets/ton_wallet_multisig_expired_transaction/ton_wallet_multisig_expired_transaction_widget.dart';
import 'package:app/feature/wallet/widgets/account_transactions_tab/widgets/ton_wallet_multisig_expired_transaction/widgets/transaction_details.dart';
import 'package:app/generated/generated.dart';
import 'package:elementary/elementary.dart';
import 'package:flutter/material.dart';
import 'package:injectable/injectable.dart';
import 'package:nekoton_repository/nekoton_repository.dart';
import 'package:ui_components_lib/ui_components_lib.dart';
import 'package:ui_components_lib/v2/ui_components_lib_v2.dart';

class TonWalletMultisigExpiredTransactionWmParams {
  TonWalletMultisigExpiredTransactionWmParams({
    required this.transaction,
    required this.price,
    required this.isFirst,
    required this.isLast,
    required this.account,
  });

  final TonWalletMultisigExpiredTransaction transaction;
  final Fixed price;
  final bool isFirst;
  final bool isLast;
  final KeyAccount account;
}

/// [WidgetModel] для [TonWalletMultisigExpiredTransactionWidget]
@injectable
class TonWalletMultisigExpiredTransactionWidgetModel
    extends InjectedWidgetModel<
        TonWalletMultisigExpiredTransactionWidget,
        TonWalletMultisigExpiredTransactionModel,
        TonWalletMultisigExpiredTransactionWmParams> {
  TonWalletMultisigExpiredTransactionWidgetModel(
    super.model,
  );

  late final transaction =
      createWmParamsNotifier<TonWalletMultisigExpiredTransaction>(
    (it) => it.transaction,
  );
  late final isFirst = createWmParamsNotifier<bool>(
    (it) => it.isFirst,
  );
  late final isLast = createWmParamsNotifier<bool>(
    (it) => it.isLast,
  );

  late final transactionTimeFormatter = DateFormat(
    'HH:mm',
    context.locale.languageCode,
  );

  late final transactionText = createWmParamsNotifier<String>(
    (it) => transactionTimeFormatter.format(it.transaction.date),
  );

  late final transactionFee = createWmParamsNotifier<Money>(
    (it) => Money.fromBigIntWithCurrency(
      it.transaction.fees,
      Currencies()[_nativeTokenTicker]!,
    ),
  );

  late final transactionValue = createWmParamsNotifier<Money>(
    (it) => Money.fromBigIntWithCurrency(
      it.transaction.value,
      Currencies()[_nativeTokenTicker]!,
    ),
  );

  TextStylesV2 get textStyles => _theme.textStyles;

  ColorsPaletteV2 get colors => _theme.colors;

  ThemeStyleV2 get _theme => context.themeStyleV2;

  String get _nativeTokenTicker => model.nativeTokenTicker;

  String get _tonIconPath => model.tonIconPath;

  void onPressedDetailed() {
    final params = wmParams.value;
    final fee = transactionFee.value;
    final value = transactionValue.value;

    Navigator.of(context, rootNavigator: true).push(
      MaterialPageRoute<void>(
        builder: (_) => TonWalletMultisigExpiredTransactionDetailsPage(
          transaction: params.transaction,
          price: params.price,
          account: params.account,
          transactionFee: fee,
          transactionValue: value,
          tonIconPath: _tonIconPath,
          methodData: params.transaction.walletInteractionInfo?.method
              .toRepresentableData(),
          onPressedSeeInExplorer: _openBrowserNewTab,
        ),
      ),
    );
  }

  void _openBrowserNewTab() {
    openBrowserUrl(
      model.getTransactionExplorerLink(wmParams.value.transaction.hash),
    );
  }
}
