import 'package:app/app/router/router.dart';
import 'package:app/data/models/models.dart';
import 'package:app/di/di.dart';
import 'package:app/feature/wallet/staking/view/cancel_unstaking_page/route.dart';
import 'package:app/feature/wallet/widgets/account_transactions_tab/widgets/ton_wallet_transaction_status_body.dart';
import 'package:app/feature/wallet/widgets/account_transactions_tab/widgets/ton_wallet_transaction_widget.dart';
import 'package:app/utils/utils.dart';
import 'package:collection/collection.dart';
import 'package:flutter/material.dart';
import 'package:lucide_icons_flutter/lucide_icons.dart';
import 'package:nekoton_repository/nekoton_repository.dart';
import 'package:ui_components_lib/ui_components_lib.dart';

/// Widget that shows withdraw requests
class StakingInProgress extends StatelessWidget {
  const StakingInProgress({
    required this.requests,
    required this.accountKey,
    required this.exchangeRate,
    required this.withdrawHours,
    required this.stakeCurrency,
    required this.attachedFee,
    required this.tokenPrice,
    required this.everPrice,
    super.key,
  });

  /// Pending withdraw requests
  final List<StEverWithdrawRequest> requests;
  final PublicKey accountKey;
  final double exchangeRate;
  final int withdrawHours;
  final Currency stakeCurrency;
  final BigInt attachedFee;
  final String tokenPrice;
  final String everPrice;

  @override
  Widget build(BuildContext context) {
    return SeparatedColumn(
      children: requests.mapIndexed(
        (index, e) {
          final prev = index == 0 ? null : requests[index - 1];
          final next =
              index == requests.length - 1 ? null : requests[index + 1];
          final isFirst =
              prev == null || !prev.data.timestamp.isSameDay(e.data.timestamp);
          final isLast =
              next == null || !next.data.timestamp.isSameDay(e.data.timestamp);

          return TonWalletTransactionWidget(
            icon: LucideIcons.loader,
            address: e.accountAddress,
            isIncoming: true,
            isFirst: isFirst,
            isLast: isLast,
            onPressed: () => context.compassContinue(
              CancelUnstakingRouteData(
                request: e,
                accountKey: accountKey,
                exchangeRate: exchangeRate,
                withdrawHours: withdrawHours,
                stakeCurrency: stakeCurrency,
                attachedFee: attachedFee,
                tokenPrice: Fixed.tryParse(tokenPrice),
              ),
            ),
            status: TonWalletTransactionStatus.unstakingInProgress,
            transactionDateTime: e.data.timestamp,
            transactionValue: Money.fromBigIntWithCurrency(
              e.data.amount,
              Currencies()[inject<NekotonRepository>()
                  .currentTransport
                  .nativeTokenTicker]!,
            ),
            transactionFee: null,
          );
        },
      ).toList(),
    );
  }
}
