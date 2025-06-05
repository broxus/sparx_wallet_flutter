import 'package:app/data/models/models.dart';
import 'package:app/feature/wallet/staking/staking.dart';
import 'package:nekoton_repository/nekoton_repository.dart';

final class StakingInfo {
  const StakingInfo({
    required this.wallet,
    required this.tokenWallet,
    required this.currency,
    required this.tokenCurrency,
    required this.details,
    required this.apy,
    required this.withdrawHours,
    required this.tokenContractAsset,
    required this.fees,
  });

  final TonWallet wallet;
  final GenericTokenWallet tokenWallet;
  final CustomCurrency currency;
  final CustomCurrency tokenCurrency;
  final StEverDetails details;
  final double apy;
  final int withdrawHours;
  final TokenContractAsset? tokenContractAsset;
  final StakingFees fees;
}
