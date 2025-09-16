import 'package:app/app/router/compass/bottom_bar_state.dart';
import 'package:app/app/router/compass/compass.dart';
import 'package:app/feature/wallet/wallet_deploy/data/wallet_deploy_type.dart';
import 'package:app/feature/wallet/wallet_deploy/wallet_deploy_status/wallet_deploy_status_screen.dart';
import 'package:app/utils/common_utils.dart';
import 'package:injectable/injectable.dart';

@named
@Singleton(as: CompassBaseRoute)
class WalletDeployStatusRoute
    extends CompassRoute<WalletDeployStatusRouteData> {
  WalletDeployStatusRoute()
      : super(
          bottomBarState: BottomBarState.hidden,
          path: '/wallet-deploy-status',
          builder: (context, data, _) {
            return WalletDeployStatusScreen(
              routeData: data,
            );
          },
        );

  @override
  WalletDeployStatusRouteData fromQueryParams(Map<String, String> queryParams) {
    final requireConfirmationsStr = queryParams['requireConfirmations'];
    final requireConfirmations = requireConfirmationsStr != null
        ? int.tryParse(requireConfirmationsStr)
        : null;

    final hoursStr = queryParams['hours'];
    final hours = hoursStr != null ? int.tryParse(hoursStr) : null;

    return WalletDeployStatusRouteData(
      address: queryParams['address'] ?? '',
      publicKey: queryParams['publicKey'] ?? '',
      deployType:
          WalletDeployType.values.byNameOrNull(queryParams['deployType']) ??
              WalletDeployType.standard,
      custodians: queryParams['custodians'],
      requireConfirmations: requireConfirmations,
      hours: hours,
    );
  }
}

class WalletDeployStatusRouteData implements CompassRouteDataQuery {
  const WalletDeployStatusRouteData({
    required this.address,
    required this.publicKey,
    required this.deployType,
    this.custodians,
    this.requireConfirmations,
    this.hours,
  });

  final String address;
  final String publicKey;
  final WalletDeployType deployType;
  final String? custodians;
  final int? requireConfirmations;
  final int? hours;

  @override
  Map<String, String> toQueryParams() {
    return {
      'address': address,
      'publicKey': publicKey,
      'deployType': deployType.name,
      if (custodians != null && custodians!.isNotEmpty)
        'custodians': custodians!,
      if (requireConfirmations != null)
        'requireConfirmations': requireConfirmations!.toString(),
      if (hours != null) 'hours': hours!.toString(),
    };
  }
}
