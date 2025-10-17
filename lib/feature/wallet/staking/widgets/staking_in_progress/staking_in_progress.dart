import 'package:app/core/wm/custom_wm.dart';
import 'package:app/data/models/stever/stever_withdraw_request.dart';
import 'package:app/feature/wallet/staking/widgets/staking_in_progress/staking_in_progress_wm.dart';
import 'package:app/feature/wallet/widgets/account_transactions_tab/widgets/ton_wallet_transaction_status_body.dart';
import 'package:app/feature/wallet/widgets/account_transactions_tab/widgets/ton_wallet_transaction_widget.dart';
import 'package:app/utils/common_utils.dart';
import 'package:collection/collection.dart';
import 'package:flutter/material.dart';
import 'package:lucide_icons_flutter/lucide_icons.dart';
import 'package:money2/money2.dart';
import 'package:nekoton_repository/nekoton_repository.dart';
import 'package:ui_components_lib/components/common/container/separated_column.dart';

class StakingInProgress
    extends
        InjectedElementaryParametrizedWidget<
          StakingInProgressWidgetModel,
          StakingInProgressParams
        > {
  StakingInProgress({
    /// Pending withdraw requests
    required List<StEverWithdrawRequest> requests,
    required PublicKey accountKey,
    required double exchangeRate,
    required int withdrawHours,
    required Currency stakeCurrency,
    required BigInt attachedFee,
    required String tokenPrice,
    required String everPrice,
    super.key,
  }) : super(
         wmFactoryParam: StakingInProgressParams(
           requests: requests,
           accountKey: accountKey,
           exchangeRate: exchangeRate,
           withdrawHours: withdrawHours,
           stakeCurrency: stakeCurrency,
           attachedFee: attachedFee,
           tokenPrice: tokenPrice,
           everPrice: everPrice,
         ),
       );

  @override
  Widget build(StakingInProgressWidgetModel wm) {
    return SeparatedColumn(
      children: wm.requests.mapIndexed((index, e) {
        final prev = index == 0 ? null : wm.requests[index - 1];
        final next = index == wm.requests.length - 1
            ? null
            : wm.requests[index + 1];
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
          onPressed: () => wm.onPressedAccountAddress(e),
          status: TonWalletTransactionStatus.unstakingInProgress,
          transactionDateTime: e.data.timestamp,
          transactionValue: wm.getTransactionValueByAmount(e.data.amount),
          transactionFee: null,
        );
      }).toList(),
    );
  }
}
