import 'package:app/app/router/compass/compass.dart';
import 'package:app/feature/wallet/wallet_deploy/data/wallet_deploy_type.dart';
import 'package:app/feature/wallet/wallet_deploy/wallet_deploy_confirm/wallet_deploy_confirm_screen.dart';
import 'package:app/feature/wallet/wallet_deploy/wallet_deploy_status/route.dart';
import 'package:app/utils/utils.dart';
import 'package:injectable/injectable.dart';
import 'package:nekoton_repository/nekoton_repository.dart';

/// Constants for query parameter names
const _addressQueryParam = 'address';
const _publicKeyQueryParam = 'publicKey';
const _deployTypeQueryParam = 'deployType';
const _custodiansQueryParam = 'custodians';
const _requireConfirmationsQueryParam = 'requireConfirmations';
const _hoursQueryParam = 'hours';

@named
@Singleton(as: CompassBaseRoute)
class WalletDeployConfirmRoute
    extends CompassRoute<WalletDeployConfirmRouteData> {
  WalletDeployConfirmRoute(
    @Named.from(WalletDeployStatusRoute)
    CompassBaseRoute walletDeployStatusRoute,
  ) : super(
        path: '/wallet-deploy-confirm',
        builder: (context, data, _) =>
            WalletDeployConfirmScreen(deploymentData: data),
        compassBaseRoutes: [walletDeployStatusRoute],
      );

  @override
  WalletDeployConfirmRouteData fromQueryParams(
    Map<String, String> queryParams,
  ) {
    final deployTypeStr = queryParams[_deployTypeQueryParam];
    final deployType =
        WalletDeployType.values.byNameOrNull(deployTypeStr) ??
        WalletDeployType.standard;

    final custodiansStr = queryParams[_custodiansQueryParam];
    final custodians = custodiansStr != null && custodiansStr.isNotEmpty
        ? custodiansStr.split(',').map((e) => PublicKey(publicKey: e)).toList()
        : null;

    final requireConfirmationsStr =
        queryParams[_requireConfirmationsQueryParam];
    final requireConfirmations = requireConfirmationsStr != null
        ? int.tryParse(requireConfirmationsStr)
        : null;

    final hoursStr = queryParams[_hoursQueryParam];
    final hours = hoursStr != null ? int.tryParse(hoursStr) : null;

    return WalletDeployConfirmRouteData(
      address: Address(address: queryParams[_addressQueryParam]!),
      publicKey: PublicKey(publicKey: queryParams[_publicKeyQueryParam]!),
      deployType: deployType,
      custodians: custodians,
      requireConfirmations: requireConfirmations,
      hours: hours,
    );
  }
}

class WalletDeployConfirmRouteData implements CompassRouteDataQuery {
  const WalletDeployConfirmRouteData({
    required this.address,
    required this.publicKey,
    required this.deployType,
    this.custodians,
    this.requireConfirmations,
    this.hours,
  });

  final Address address;
  final PublicKey publicKey;
  final WalletDeployType deployType;
  final List<PublicKey>? custodians;
  final int? requireConfirmations;
  final int? hours;

  @override
  Map<String, String> toQueryParams() {
    return {
      _addressQueryParam: address.address,
      _publicKeyQueryParam: publicKey.publicKey,
      _deployTypeQueryParam: deployType.name,
      if (custodians != null && custodians!.isNotEmpty)
        _custodiansQueryParam: custodians!.map((e) => e.publicKey).join(','),
      if (requireConfirmations != null)
        _requireConfirmationsQueryParam: requireConfirmations!.toString(),
      if (hours != null) _hoursQueryParam: hours!.toString(),
    };
  }
}
