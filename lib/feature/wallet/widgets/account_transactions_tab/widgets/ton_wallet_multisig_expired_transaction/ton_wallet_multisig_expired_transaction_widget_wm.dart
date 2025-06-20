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
class TonWalletMultisigExpiredTransactionWidgetModel extends CustomWidgetModel<
    TonWalletMultisigExpiredTransactionWidget,
    TonWalletMultisigExpiredTransactionModel> {
  TonWalletMultisigExpiredTransactionWidgetModel(
    super.model,
    @factoryParam this._wmParams,
  );

  final TonWalletMultisigExpiredTransactionWmParams _wmParams;

  TonWalletMultisigExpiredTransaction get transaction => _wmParams.transaction;
  bool get isFirst => _wmParams.isFirst;
  bool get isLast => _wmParams.isLast;

  late final transactionTimeFormatter = DateFormat(
    'HH:mm',
    context.locale.languageCode,
  );

  late final transactionText =
      transactionTimeFormatter.format(_wmParams.transaction.date);

  late final transactionFee = Money.fromBigIntWithCurrency(
    _wmParams.transaction.fees,
    Currencies()[_nativeTokenTicker]!,
  );

  late final transactionValue = Money.fromBigIntWithCurrency(
    _wmParams.transaction.value,
    Currencies()[_nativeTokenTicker]!,
  );

  TextStylesV2 get textStyles => _theme.textStyles;

  ColorsPaletteV2 get colors => _theme.colors;

  ThemeStyleV2 get _theme => context.themeStyleV2;

  String get _nativeTokenTicker => model.nativeTokenTicker;

  String get _tonIconPath => model.tonIconPath;

  void onPressedDetailed() {
    Navigator.of(context, rootNavigator: true).push(
      MaterialPageRoute<void>(
        builder: (_) => TonWalletMultisigExpiredTransactionDetailsPage(
          transaction: _wmParams.transaction,
          price: _wmParams.price,
          account: _wmParams.account,
          transactionFee: transactionFee,
          transactionValue: transactionValue,
          tonIconPath: _tonIconPath,
          methodData: _wmParams.transaction.walletInteractionInfo?.method
              .toRepresentableData(),
          onPressedSeeInExplorer: _openBrowserNewTab,
        ),
      ),
    );
  }

  void _openBrowserNewTab() {
    openBrowserUrl(
      model.getTransactionExplorerLink(_wmParams.transaction.hash),
    );
  }
}
