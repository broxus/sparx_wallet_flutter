import 'package:app/app/router/compass/compass.dart';
import 'package:app/feature/wallet/staking/view/staking_page/staking_page_widget.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:injectable/injectable.dart';
import 'package:nekoton_repository/nekoton_repository.dart';

part 'route.freezed.dart';

/// Query parameter name for the account address in the WalletStake route
const walletStakeAddressQueryParam = 'walletStakeAddress';

@singleton
class WalletStakeRoute extends CompassRoute<WalletStakeRouteData, void> {
  WalletStakeRoute()
      : super(
          name: 'wallet-stake',
          builder: (context, data, _) => StakingPageWidget(
            accountAddress: data.accountAddress,
          ),
        );

  @override
  WalletStakeRouteData fromQueryParams(Map<String, String> queryParams) {
    return WalletStakeRouteData(
      accountAddress: Address(
        address: queryParams[walletStakeAddressQueryParam]!,
      ),
    );
  }
}

/// Data model for WalletStake route
@freezed
class WalletStakeRouteData
    with _$WalletStakeRouteData
    implements CompassRouteDataQuery {
  const factory WalletStakeRouteData({
    /// Address of the account to stake
    required Address accountAddress,
  }) = _WalletStakeRouteData;

  const WalletStakeRouteData._();

  @override
  Map<String, String> toQueryParams() {
    return {
      walletStakeAddressQueryParam: accountAddress.address,
    };
  }
}
