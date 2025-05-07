import 'package:app/app/router/compass/compass.dart';
import 'package:app/feature/biometry/view/route.dart';
import 'package:app/feature/network/configure_networks/route.dart';
import 'package:app/feature/wallet/confirm_multisig_transaction/route.dart';
import 'package:app/feature/wallet/custodians_settings/route.dart';
import 'package:app/feature/wallet/new_account/screen/route.dart';
import 'package:app/feature/wallet/staking/view/staking_page/route.dart';
import 'package:app/feature/wallet/token_wallet_details/route.dart';
import 'package:app/feature/wallet/ton_wallet_details/route.dart';
import 'package:app/feature/wallet/view/wallet_page_widget.dart';
import 'package:app/feature/wallet/wallet_deploy/route.dart';
import 'package:app/feature/wallet/wallet_prepare_transfer/route.dart';
import 'package:app/feature/wallet/widgets/account_asset_tab/select_new_asset/route.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:injectable/injectable.dart';

part 'route.freezed.dart';

@singleton
class WalletRoute extends CompassRouteParameterless<WalletRouteData> {
  WalletRoute({
    required this.enableBiometryRoute,
    required this.selectNewAssetRoute,
    required this.custodiansSettingsRoute,
    required this.walletNewAccountRoute,
    required this.tonWalletDetailsRoute,
    required this.tokenWalletDetailsRoute,
    required this.walletPrepareTransferRoute,
    required this.walletDeployRoute,
    required this.confirmMultisigTransactionRoute,
    required this.configureNetworksRoute,
    required this.walletStakeRoute,
  }) : super(
          name: 'wallet',
          isTopLevel: true, // Mark as top-level route
          builder: (context, _, __) => const WalletPageWidget(),
          compassBaseRoutes: [
            enableBiometryRoute,
            selectNewAssetRoute,
            custodiansSettingsRoute,
            walletNewAccountRoute,
            tonWalletDetailsRoute,
            tokenWalletDetailsRoute,
            walletPrepareTransferRoute,
            walletDeployRoute,
            confirmMultisigTransactionRoute,
            configureNetworksRoute,
            walletStakeRoute,
          ],
        );

  final EnableBiometryRoute enableBiometryRoute;
  final SelectNewAssetRoute selectNewAssetRoute;
  final CustodiansSettingsRoute custodiansSettingsRoute;
  final WalletNewAccountRoute walletNewAccountRoute;
  final TonWalletDetailsRoute tonWalletDetailsRoute;
  final TokenWalletDetailsRoute tokenWalletDetailsRoute;
  final WalletPrepareTransferRoute walletPrepareTransferRoute;
  final WalletDeployRoute walletDeployRoute;
  final ConfirmMultisigTransactionRoute confirmMultisigTransactionRoute;
  final ConfigureNetworksRoute configureNetworksRoute;
  final WalletStakeRoute walletStakeRoute;

  @override
  WalletRouteData dataFabric() {
    return const WalletRouteData();
  }
}

/// Data model for Wallet route
@freezed
class WalletRouteData with _$WalletRouteData implements CompassRouteData {
  const factory WalletRouteData() = _WalletRouteData;

  const WalletRouteData._();
}
