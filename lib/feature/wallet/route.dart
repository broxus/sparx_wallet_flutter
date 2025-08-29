import 'package:app/app/router/compass/bottom_bar_state.dart';
import 'package:app/app/router/compass/compass.dart';
import 'package:app/feature/add_seed/enter_seed_name/route.dart';
import 'package:app/feature/biometry/route.dart';
import 'package:app/feature/network/configure_networks/route.dart';
import 'package:app/feature/wallet/confirm_multisig_transaction/route.dart';
import 'package:app/feature/wallet/custodians_settings/route.dart';
import 'package:app/feature/wallet/new_account/route.dart';
import 'package:app/feature/wallet/staking/view/staking_page/route.dart';
import 'package:app/feature/wallet/token_wallet_details/route.dart';
import 'package:app/feature/wallet/ton_wallet_details/route.dart';
import 'package:app/feature/wallet/view/wallet_page_widget.dart';
import 'package:app/feature/wallet/wallet_deploy/route.dart';
import 'package:app/feature/wallet/wallet_prepare_transfer/route.dart';
import 'package:app/feature/wallet/widgets/account_asset_tab/select_new_asset/route.dart';
import 'package:injectable/injectable.dart';

@named
@Singleton(as: CompassBaseRoute)
class WalletRoute extends CompassRouteParameterless<WalletRouteData> {
  WalletRoute(
    @Named.from(EnableBiometryRoute) CompassBaseRoute enableBiometryRoute,
    @Named.from(SelectNewAssetRoute) CompassBaseRoute selectNewAssetRoute,
    @Named.from(CustodiansSettingsRoute)
    CompassBaseRoute custodiansSettingsRoute,
    @Named.from(AddAccountRoute) CompassBaseRoute addAccountRoute,
    @Named.from(TonWalletDetailsRoute) CompassBaseRoute tonWalletDetailsRoute,
    @Named.from(TokenWalletDetailsRoute)
    CompassBaseRoute tokenWalletDetailsRoute,
    @Named.from(WalletPrepareTransferRoute)
    CompassBaseRoute walletPrepareTransferRoute,
    @Named.from(WalletPrepareSpecifiedTransferRoute)
    CompassBaseRoute walletPrepareSpecifiedTransferRoute,
    @Named.from(WalletDeployRoute) CompassBaseRoute walletDeployRoute,
    @Named.from(ConfirmMultisigTransactionRoute)
    CompassBaseRoute confirmMultisigTransactionRoute,
    @Named.from(ConfigureNetworksRoute) CompassBaseRoute configureNetworksRoute,
    @Named.from(StakingRoute) CompassBaseRoute walletStakeRoute,
    @Named.from(EnterSeedNameRoute) CompassBaseRoute enterSeedNameRoute,
  ) : super(
          name: 'wallet',
          path: '/wallet',
          isSaveLocation: true,
          bottomBarState: BottomBarState.expanded,
          builder: (context, _, __) => const WalletPageWidget(),
          compassBaseRoutes: [
            enableBiometryRoute,
            selectNewAssetRoute,
            custodiansSettingsRoute,
            addAccountRoute,
            tonWalletDetailsRoute,
            tokenWalletDetailsRoute,
            walletPrepareTransferRoute,
            walletPrepareSpecifiedTransferRoute,
            walletDeployRoute,
            confirmMultisigTransactionRoute,
            configureNetworksRoute,
            walletStakeRoute,
            enterSeedNameRoute,
          ],
        );

  @override
  WalletRouteData createData() {
    return const WalletRouteData();
  }
}

class WalletRouteData implements CompassRouteData {
  const WalletRouteData();
}
