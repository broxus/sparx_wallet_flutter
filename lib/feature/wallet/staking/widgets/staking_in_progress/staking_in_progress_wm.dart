import 'package:app/app/router/router.dart';
import 'package:app/core/wm/custom_wm.dart';
import 'package:app/data/models/stever/stever_withdraw_request.dart';
import 'package:app/feature/wallet/staking/view/cancel_unstaking_page/route.dart';
import 'package:app/feature/wallet/staking/widgets/staking_in_progress/staking_in_progress.dart';
import 'package:app/feature/wallet/staking/widgets/staking_in_progress/staking_in_progress_model.dart';
import 'package:elementary/elementary.dart';
import 'package:injectable/injectable.dart';
import 'package:money2/money2.dart';
import 'package:nekoton_repository/nekoton_repository.dart';

/// [WidgetModel] for [StakingInProgress]
@injectable
class StakingInProgressWidgetModel
    extends
        CustomWidgetModelParametrized<
          StakingInProgress,
          StakingInProgressModel,
          StakingInProgressParams
        > {
  StakingInProgressWidgetModel(super.model);

  List<StEverWithdrawRequest> get requests => wmParams.value.requests;

  Money getTransactionValueByAmount(BigInt amount) =>
      model.getTransactionValueByAmount(amount);

  void onPressedAccountAddress(StEverWithdrawRequest request) =>
      context.compassContinue(
        CancelUnstakingRouteData(
          request: request,
          accountKey: wmParams.value.accountKey,
          exchangeRate: wmParams.value.exchangeRate,
          withdrawHours: wmParams.value.withdrawHours,
          stakeCurrency: wmParams.value.stakeCurrency,
          attachedFee: wmParams.value.attachedFee,
          tokenPrice: Fixed.tryParse(wmParams.value.tokenPrice),
        ),
      );
}

class StakingInProgressParams {
  StakingInProgressParams({
    required this.requests,
    required this.accountKey,
    required this.exchangeRate,
    required this.withdrawHours,
    required this.stakeCurrency,
    required this.attachedFee,
    required this.tokenPrice,
    required this.everPrice,
  });

  final List<StEverWithdrawRequest> requests;
  final PublicKey accountKey;
  final double exchangeRate;
  final int withdrawHours;
  final Currency stakeCurrency;
  final BigInt attachedFee;
  final String tokenPrice;
  final String everPrice;
}
