import 'package:app/core/wm/custom_wm.dart';
import 'package:app/feature/wallet/widgets/account_transactions_tab/account_transactions_tab.dart';
import 'package:app/generated/generated.dart';
import 'package:app/utils/utils.dart';
import 'package:elementary_helper/elementary_helper.dart';
import 'package:flutter/material.dart';
import 'package:nekoton_repository/nekoton_repository.dart';
import 'package:ui_components_lib/ui_components_lib.dart';
import 'package:ui_components_lib/v2/ui_components_lib_v2.dart';

/// Tab from <WalletBottomPanel> that allows display list of transactions
/// related to TonWallet for [account].
///
/// !!! TokenWallet transactions should be displayed in a separate tab,
/// specified for asset.
class AccountTransactionsTab extends InjectedElementaryParametrizedWidget<
    AccountTransactionsTabWidgetModel, AccountTransactionsTabWmParams> {
  AccountTransactionsTab({
    required this.account,
    required this.scrollController,
    super.key,
  }) : super(wmFactoryParam: AccountTransactionsTabWmParams(account: account));

  final ScrollController scrollController;
  final KeyAccount account;

  @override
  Widget build(AccountTransactionsTabWidgetModel wm) {
    return StateNotifierBuilder<AccountTransactionsUiState>(
      listenableState: wm.state,
      builder: (context, state) {
        final theme = context.themeStyleV2;

        return switch (state) {
          AccountTransactionsUiLoading() => SliverToBoxAdapter(
              child: ProgressIndicatorWidget(
                size: DimensSizeV2.d32,
                color: theme.colors.content0,
              ),
            ),
          AccountTransactionsUiEmpty() => SliverToBoxAdapter(
              child: Padding(
                padding: const EdgeInsets.symmetric(vertical: DimensSizeV2.d24),
                child: SeparatedColumn(
                  spacing: DimensSizeV2.d12,
                  children: [
                    SvgPicture.asset(
                      Assets.images.lightning.path,
                      colorFilter: theme.colors.content3.colorFilter,
                      width: DimensSizeV2.d56,
                      height: DimensSizeV2.d56,
                    ),
                    Text(
                      LocaleKeys.emptyHistoryTitle.tr(),
                      style: theme.textStyles.paragraphSmall.copyWith(
                        color: theme.colors.content1,
                      ),
                    ),
                  ],
                ),
              ),
            ),
          AccountTransactionsUiData(
            :final transactions,
            :final isLoading,
            :final price,
          ) =>
            ScrollControllerPreloadListener(
              preloadAction: wm.tryPreloadTransactions,
              scrollController: scrollController,
              child: SliverList.builder(
                itemCount: transactions.length + (isLoading ? 1 : 0),
                itemBuilder: (context, index) {
                  if (index == transactions.length) {
                    return const Padding(
                      padding: EdgeInsets.all(DimensSize.d16),
                      child: Center(child: CommonCircularProgressIndicator()),
                    );
                  }

                  final prev = index == 0 ? null : transactions[index - 1];
                  final trans = transactions[index];
                  final next = index == transactions.length - 1
                      ? null
                      : transactions[index + 1];
                  final isFirst =
                      prev == null || !prev.date.isSameDay(trans.date);
                  final isLast =
                      next == null || !next.date.isSameDay(trans.date);

                  return _transactionItem(
                    trans,
                    isFirst,
                    isLast,
                    price,
                  );
                },
              ),
            ),
          _ => const SliverToBoxAdapter(child: SizedBox.shrink()),
        };
      },
    );
  }

  Widget _transactionItem(
    AccountTransactionItem<dynamic> trans,
    bool isFirst,
    bool isLast,
    Fixed price,
  ) {
    return switch (trans.type) {
      AccountTransactionType.ordinary => TonWalletOrdinaryTransactionWidget(
          transaction: trans.transaction as TonWalletOrdinaryTransaction,
          isFirst: isFirst,
          isLast: isLast,
          price: price,
        ),
      AccountTransactionType.pending => TonWalletPendingTransactionWidget(
          transaction: trans.transaction as TonWalletPendingTransaction,
          isFirst: isFirst,
          isLast: isLast,
        ),
      AccountTransactionType.expired => TonWalletExpiredTransactionWidget(
          transaction: trans.transaction as TonWalletExpiredTransaction,
          isFirst: isFirst,
          isLast: isLast,
        ),
      AccountTransactionType.multisigOrdinary =>
        TonWalletMultisigOrdinaryTransactionWidget(
          transaction:
              trans.transaction as TonWalletMultisigOrdinaryTransaction,
          isFirst: isFirst,
          isLast: isLast,
          price: price,
          account: account,
        ),
      AccountTransactionType.multisigPending =>
        TonWalletMultisigPendingTransactionWidget(
          transaction: trans.transaction as TonWalletMultisigPendingTransaction,
          isFirst: isFirst,
          isLast: isLast,
          price: price,
          account: account,
        ),
      AccountTransactionType.multisigExpired =>
        TonWalletMultisigExpiredTransactionWidget(
          transaction: trans.transaction as TonWalletMultisigExpiredTransaction,
          isFirst: isFirst,
          isLast: isLast,
          price: price,
          account: account,
        ),
    };
  }
}
