import 'package:app/app/router/compass/compass.dart';
import 'package:app/feature/wallet/staking/view/cancel_unstaking_page/route.dart';
import 'package:app/feature/wallet/staking/view/staking_page/staking_page_widget.dart';
import 'package:app/feature/wallet/token_wallet_send/route.dart';
import 'package:app/feature/wallet/ton_wallet_send/route.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:injectable/injectable.dart';
import 'package:nekoton_repository/nekoton_repository.dart';

part 'route.freezed.dart';

/// Query parameter name for the account address in the WalletStake route
const _addressQueryParam = 'walletStakeAddress';

@singleton
class StakingRoute extends CompassRoute<StakingRouteData> {
  StakingRoute(
    TonWalletSendRoute tonWalletSendRoute,
    TokenWalletSendRoute tokenWalletSendRoute,
    CancelUnstakingRoute cancelUnstakingRoute,
  ) : super(
          name: 'wallet-stake',
          builder: (context, data, _) => StakingPageWidget(
            accountAddress: data.accountAddress,
          ),
          compassBaseRoutes: [
            tonWalletSendRoute,
            tokenWalletSendRoute,
            cancelUnstakingRoute,
          ],
        );

  @override
  StakingRouteData fromQueryParams(Map<String, String> queryParams) {
    return StakingRouteData(
      accountAddress: Address(
        address: queryParams[_addressQueryParam]!,
      ),
    );
  }
}

/// Data model for WalletStake route
@freezed
class StakingRouteData
    with _$StakingRouteData
    implements CompassRouteDataQuery {
  const factory StakingRouteData({
    /// Address of the account to stake
    required Address accountAddress,
  }) = _StakingRouteData;

  const StakingRouteData._();

  @override
  Map<String, String> toQueryParams() {
    return {
      _addressQueryParam: accountAddress.address,
    };
  }
}
