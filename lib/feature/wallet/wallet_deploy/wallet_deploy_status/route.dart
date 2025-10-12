import 'package:app/app/router/compass/compass.dart';
import 'package:app/feature/wallet/wallet_deploy/wallet_deploy_status/wallet_deploy_status_screen.dart';
import 'package:injectable/injectable.dart';
import 'package:nekoton_repository/nekoton_repository.dart';

@named
@Singleton(as: CompassBaseRoute)
class WalletDeployStatusRoute
    extends CompassRoute<WalletDeployStatusRouteData> {
  WalletDeployStatusRoute()
      : super(
          path: '/wallet-deploy-status',
          builder: (context, data, _) {
            return WalletDeployStatusScreen(
              routeData: data,
            );
          },
        );

  @override
  WalletDeployStatusRouteData fromQueryParams(Map<String, String> queryParams) {
    return WalletDeployStatusRouteData(
      messageHash: queryParams['messageHash'] ?? '',
      address: Address(address: queryParams['address'] ?? ''),
      amount: BigInt.tryParse(queryParams['amount'] ?? '') ?? BigInt.zero,
    );
  }
}

class WalletDeployStatusRouteData implements CompassRouteDataQuery {
  const WalletDeployStatusRouteData({
    required this.messageHash,
    required this.address,
    required this.amount,
  });

  final String messageHash;
  final Address address;
  final BigInt amount;

  @override
  Map<String, String> toQueryParams() {
    return {
      'messageHash': messageHash,
      'address': address.toString(),
      'amount': amount.toString(),
    };
  }
}
