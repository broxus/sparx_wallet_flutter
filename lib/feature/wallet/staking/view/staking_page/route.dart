import 'package:app/app/router/compass/compass.dart';
import 'package:app/feature/wallet/staking/view/cancel_unstaking_page/route.dart';
import 'package:app/feature/wallet/staking/view/staking_page/staking_page_widget.dart';
import 'package:app/feature/wallet/token_wallet_send/route.dart';
import 'package:app/feature/wallet/ton_wallet_send/route.dart';
import 'package:injectable/injectable.dart';
import 'package:nekoton_repository/nekoton_repository.dart';

/// Query parameter name for the account address in the WalletStake route
const _addressQueryParam = 'walletStakeAddress';

@named
@Singleton(as: CompassBaseRoute)
class StakingRoute extends CompassRoute<StakingRouteData> {
  StakingRoute(
    @Named.from(TonWalletSendRoute) CompassBaseRoute tonWalletSendRoute,
    @Named.from(TokenWalletSendRoute) CompassBaseRoute tokenWalletSendRoute,
    @Named.from(CancelUnstakingRoute) CompassBaseRoute cancelUnstakingRoute,
  ) : super(
        path: '/wallet-stake',
        builder: (context, data, _) =>
            StakingPageWidget(accountAddress: data.accountAddress),
        compassBaseRoutes: [
          tonWalletSendRoute,
          tokenWalletSendRoute,
          cancelUnstakingRoute,
        ],
      );

  @override
  StakingRouteData fromQueryParams(Map<String, String> queryParams) {
    return StakingRouteData(
      accountAddress: Address(address: queryParams[_addressQueryParam]!),
    );
  }
}

class StakingRouteData implements CompassRouteDataQuery {
  const StakingRouteData({required this.accountAddress});

  /// Address of the account to stake
  final Address accountAddress;

  @override
  Map<String, String> toQueryParams() {
    return {_addressQueryParam: accountAddress.address};
  }
}
