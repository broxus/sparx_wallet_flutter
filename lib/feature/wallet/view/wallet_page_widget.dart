import 'package:app/core/wm/custom_wm.dart';
import 'package:app/feature/wallet/view/wallet_page_wm.dart';
import 'package:app/feature/wallet/wallet.dart';
import 'package:elementary_helper/elementary_helper.dart';
import 'package:flutter/material.dart';

class WalletPageWidget extends InjectedElementaryWidget<WalletPageWidgetModel> {
  const WalletPageWidget({super.key});

  @override
  Widget build(WalletPageWidgetModel wm) {
    return StateNotifierBuilder(
      listenableState: wm.currentAccountState,
      builder: (_, account) {
        if (account == null) return const SizedBox.shrink();

        return TripleSourceBuilder(
          firstSource: wm.isShowingNewTokensState,
          secondSource: wm.transportStrategyState,
          thirdSource: wm.hasUnconfirmedTransactionsState,
          builder: (_, isShowingNewTokens, transport, hasUnconfirmed) {
            return WalletView(
              key: ValueKey(account),
              currentAccount: account,
              scrollController: wm.scrollController,
              isShowingNewTokens: isShowingNewTokens ?? false,
              confirmImportCallback: wm.hideNewTokensLabel,
              manifestUrl: transport?.manifestUrl ?? '',
              hasUnconfirmedTransactions: hasUnconfirmed ?? false,
            );
          },
        );
      },
    );
  }
}
