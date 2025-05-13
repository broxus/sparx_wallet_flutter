import 'package:app/app/router/compass/compass.dart';
import 'package:app/feature/biometry/view/route.dart';
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
import 'package:app/v1/feature/add_seed/enter_seed_name/route.dart';
import 'package:injectable/injectable.dart';

@singleton
class WalletRoute extends CompassRouteParameterless<WalletRouteData> {
  WalletRoute(
    EnableBiometryRoute enableBiometryRoute,
    SelectNewAssetRoute selectNewAssetRoute,
    CustodiansSettingsRoute custodiansSettingsRoute,
    AddAccountRoute addAccountRoute,
    TonWalletDetailsRoute tonWalletDetailsRoute,
    TokenWalletDetailsRoute tokenWalletDetailsRoute,
    WalletPrepareTransferRoute walletPrepareTransferRoute,
    WalletDeployRoute walletDeployRoute,
    ConfirmMultisigTransactionRoute confirmMultisigTransactionRoute,
    ConfigureNetworksRoute configureNetworksRoute,
    StakingRoute walletStakeRoute,
    // ignore: deprecated_member_use_from_same_package
    EnterSeedNameRoute enterSeedNameRoute,
  ) : super(
          name: 'wallet',
          builder: (context, _, __) => const WalletPageWidget(),
          compassBaseRoutes: [
            enableBiometryRoute,
            selectNewAssetRoute,
            custodiansSettingsRoute,
            addAccountRoute,
            tonWalletDetailsRoute,
            tokenWalletDetailsRoute,
            walletPrepareTransferRoute,
            walletDeployRoute,
            confirmMultisigTransactionRoute,
            configureNetworksRoute,
            walletStakeRoute,
            enterSeedNameRoute,
          ],
        );

  @override
  WalletRouteData dataFabric() {
    return const WalletRouteData();
  }
}

class WalletRouteData implements CompassRouteData {
  const WalletRouteData();
}
