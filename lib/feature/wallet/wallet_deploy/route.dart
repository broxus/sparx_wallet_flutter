import 'package:app/app/router/compass/compass.dart';
import 'package:app/feature/wallet/wallet_deploy/view/wallet_deploy_page.dart';
import 'package:injectable/injectable.dart';
import 'package:nekoton_repository/nekoton_repository.dart';

// Define query parameter constants
const _addressQueryParam = 'address';
const _publicKeyQueryParam = 'publicKey';

@named
@Singleton(as: CompassBaseRoute)
class WalletDeployRoute extends CompassRoute<WalletDeployRouteData> {
  WalletDeployRoute()
      : super(
          path: '/wallet-deploy',
          builder: (context, data, _) => WalletDeployPage(
            address: data.address,
            publicKey: data.publicKey,
          ),
        );

  @override
  WalletDeployRouteData fromQueryParams(Map<String, String> queryParams) {
    return WalletDeployRouteData(
      address: Address(
        address: queryParams[_addressQueryParam]!,
      ),
      publicKey: PublicKey(
        publicKey: queryParams[_publicKeyQueryParam]!,
      ),
    );
  }
}

class WalletDeployRouteData implements CompassRouteDataQuery {
  const WalletDeployRouteData({
    required this.address,
    required this.publicKey,
  });

  /// Address of wallet to deploy
  final Address address;

  /// Public key of wallet owner
  final PublicKey publicKey;

  @override
  Map<String, String> toQueryParams() {
    return {
      _addressQueryParam: address.address,
      _publicKeyQueryParam: publicKey.publicKey,
    };
  }
}
