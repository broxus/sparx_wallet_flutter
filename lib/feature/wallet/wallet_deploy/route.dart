import 'package:app/app/router/compass/compass.dart';
import 'package:app/feature/wallet/wallet_deploy/view/wallet_deploy_page.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:injectable/injectable.dart';
import 'package:nekoton_repository/nekoton_repository.dart';

part 'route.freezed.dart';

// Define query parameter constants
const walletDeployAddressQueryParam = 'walletDeployAddress';
const walletDeployPublicKeyQueryParam = 'walletDeployPublicKey';

@lazySingleton
class WalletDeployRoute extends CompassRoute<WalletDeployRouteData, void> {
  WalletDeployRoute()
      : super(
          name: 'wallet-deploy',
          builder: (context, data, _) => WalletDeployPage(
            address: data.address,
            publicKey: data.publicKey,
          ),
        );

  @override
  WalletDeployRouteData fromQueryParams(Map<String, String> queryParams) {
    return WalletDeployRouteData(
      address: Address(
        address: queryParams[walletDeployAddressQueryParam]!,
      ),
      publicKey: PublicKey(
        publicKey: queryParams[walletDeployPublicKeyQueryParam]!,
      ),
    );
  }
}

/// Data model for WalletDeploy route
@freezed
class WalletDeployRouteData
    with _$WalletDeployRouteData
    implements CompassRouteDataQuery {
  const factory WalletDeployRouteData({
    /// Address of wallet to deploy
    required Address address,

    /// Public key of wallet owner
    required PublicKey publicKey,
  }) = _WalletDeployRouteData;

  const WalletDeployRouteData._();

  @override
  Map<String, String> toQueryParams() {
    return {
      walletDeployAddressQueryParam: address.address,
      walletDeployPublicKeyQueryParam: publicKey.publicKey,
    };
  }
}
