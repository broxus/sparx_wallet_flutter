import 'package:app/core/wm/custom_wm.dart';
import 'package:app/feature/wallet/wallet.dart';
import 'package:app/feature/wallet/widgets/account_card/account_card_wm.dart';
import 'package:app/utils/utils.dart';
import 'package:elementary_helper/elementary_helper.dart';
import 'package:flutter/material.dart';
import 'package:lucide_icons_flutter/lucide_icons.dart';
import 'package:nekoton_repository/nekoton_repository.dart';
import 'package:ui_components_lib/ui_components_lib.dart';
import 'package:ui_components_lib/v2/ui_components_lib_v2.dart';

/// Card widget that displays information about account.
class AccountCard
    extends
        InjectedElementaryParametrizedWidget<
          AccountCardWidgetModel,
          KeyAccount
        > {
  const AccountCard({required KeyAccount account, super.key})
    : super(wmFactoryParam: account);

  @override
  Widget build(AccountCardWidgetModel wm) {
    return MultiListenerRebuilder(
      listenableList: [
        wm.errorState,
        wm.isLoadingState,
        wm.currentAccountState,
      ],
      builder: (_) {
        final error = wm.errorState.value;
        final isLoading = wm.isLoadingState.value;
        final currentAccount = wm.currentAccountState.value;

        if (error != null) {
          return WalletSubscribeErrorWidget(
            error: error,
            isLoadingError: isLoading,
            onRetryPressed: wm.retry,
          );
        }

        return _AccountCard(
          account: currentAccount,
          balance: wm.balanceState,
          onCopy: wm.onCopy,
        );
      },
    );
  }
}

class _AccountCard extends StatelessWidget {
  const _AccountCard({
    required this.account,
    required this.balance,
    required this.onCopy,
  });

  final KeyAccount account;
  final ListenableState<Money> balance;
  final VoidCallback onCopy;

  @override
  Widget build(BuildContext context) {
    final theme = context.themeStyleV2;

    return Column(
      children: [
        GestureDetector(
          behavior: HitTestBehavior.translucent,
          onTap: onCopy,
          child: Padding(
            padding: const EdgeInsets.symmetric(
              vertical: DimensSizeV2.d12,
              horizontal: DimensSizeV2.d24,
            ),
            child: SeparatedRow(
              mainAxisAlignment: MainAxisAlignment.center,
              mainAxisSize: MainAxisSize.min,
              children: [
                Text(
                  account.address.toEllipseString(),
                  style: theme.textStyles.labelSmall,
                ),
                const Icon(LucideIcons.copy, size: DimensSizeV2.d16),
              ],
            ),
          ),
        ),
        StateNotifierBuilder(
          listenableState: balance,
          builder: (_, balance) =>
              balance?.let(
                (balance) => AmountWidget.dollars(
                  amount: balance,
                  style: theme.textStyles.displayMedium,
                ),
              ) ??
              const ProgressIndicatorWidget(size: DimensSizeV2.d52),
        ),
      ],
    );
  }
}
