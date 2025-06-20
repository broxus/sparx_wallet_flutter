import 'package:app/core/wm/custom_wm.dart';
import 'package:app/feature/wallet/view/wallet_page_wm.dart';
import 'package:app/feature/wallet/wallet.dart';
import 'package:elementary_helper/elementary_helper.dart';
import 'package:flutter/material.dart';

class WalletPageWidget extends InjectedElementaryWidget<WalletPageWidgetModel> {
  const WalletPageWidget({
    super.key,
  });

  @override
  Widget build(WalletPageWidgetModel wm) {
    return Scaffold(
      body: DoubleSourceBuilder(
        firstSource: wm.currentAccount,
        secondSource: wm.hasUnconfirmedTransactions,
        builder: (_, account, hasUnconfirmed) {
          if (account == null) return const SizedBox.shrink();

          return DoubleSourceBuilder(
            firstSource: wm.isShowingNewTokens,
            secondSource: wm.transportStrategy,
            builder: (_, isShowingNewTokens, transport) {
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
      ),
    );
  }
}
