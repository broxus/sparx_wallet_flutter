import 'package:app/app/router/compass/bottom_bar_state.dart';
import 'package:app/app/router/compass/compass.dart';
import 'package:app/feature/wallet/confirm_multisig_transaction/route.dart';
import 'package:app/feature/wallet/ton_wallet_details/view/ton_wallet_details_page.dart';
import 'package:app/feature/wallet/wallet_deploy/wallet_deploy_confirm/route.dart';
import 'package:app/feature/wallet/wallet_deploy/wallet_multisig_config/route.dart';
import 'package:app/feature/wallet/wallet_prepare_transfer/route.dart';
import 'package:injectable/injectable.dart';
import 'package:nekoton_repository/nekoton_repository.dart';

const _addressQueryParam = 'address';

@named
@Singleton(as: CompassBaseRoute)
class TonWalletDetailsRoute extends CompassRoute<TonWalletDetailsRouteData> {
  TonWalletDetailsRoute(
    @Named.from(WalletMultisigConfigRoute)
    CompassBaseRoute walletMultisigConfigRoute,
    @Named.from(WalletDeployConfirmRoute)
    CompassBaseRoute walletDeployConfirmRoute,
    @Named.from(WalletPrepareTransferRoute)
    CompassBaseRoute walletPrepareTransferRoute,
    @Named.from(WalletPrepareSpecifiedTransferRoute)
    CompassBaseRoute walletPrepareSpecifiedTransferRoute,
    @Named.from(ConfirmMultisigTransactionRoute)
    CompassBaseRoute confirmMultisigTransactionRoute,
  ) : super(
          path: '/ton-details',
          builder: (context, data, _) => TonWalletDetailsPage(
            address: data.address,
          ),
          bottomBarState: BottomBarState.hidden,
          compassBaseRoutes: [
            walletMultisigConfigRoute,
            walletDeployConfirmRoute,
            walletPrepareTransferRoute,
            walletPrepareSpecifiedTransferRoute,
            confirmMultisigTransactionRoute,
          ],
        );

  @override
  TonWalletDetailsRouteData fromQueryParams(Map<String, String> queryParams) {
    return TonWalletDetailsRouteData(
      address: Address(
        address: queryParams[_addressQueryParam]!,
      ),
    );
  }
}

class TonWalletDetailsRouteData implements CompassRouteDataQuery {
  const TonWalletDetailsRouteData({
    required this.address,
  });

  /// Address of TON wallet to display
  final Address address;

  @override
  Map<String, String> toQueryParams() {
    return {
      _addressQueryParam: address.address,
    };
  }
}
