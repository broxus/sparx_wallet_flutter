import 'package:app/app/router/compass/bottom_bar_state.dart';
import 'package:app/app/router/compass/compass.dart';
import 'package:app/feature/wallet/wallet_deploy/wallet_deploy_confirm/route.dart';
import 'package:app/feature/wallet/wallet_deploy/wallet_multisig_config/wallet_multisig_config_screen.dart';
import 'package:injectable/injectable.dart';
import 'package:nekoton_repository/nekoton_repository.dart';

/// Constants for query parameter names
const _addressQueryParam = 'address';
const _publicKeyQueryParam = 'publicKey';
const _custodiansQueryParam = 'custodians';
const _requireConfirmationsQueryParam = 'requireConfirmations';
const _hoursQueryParam = 'hours';

@named
@Singleton(as: CompassBaseRoute)
class WalletMultisigConfigRoute
    extends CompassRoute<WalletMultisigConfigRouteData> {
  WalletMultisigConfigRoute(
    @Named.from(WalletDeployConfirmRoute)
    CompassBaseRoute walletDeployConfirmRoute,
  ) : super(
          path: '/wallet-deploy-multisig-config',
          bottomBarState: BottomBarState.hidden,
          builder: (context, data, _) => WalletMultisigConfigScreen(
            address: data.address,
            publicKey: data.publicKey,
            initialCustodians: data.custodians,
            initialRequireConfirmations: data.requireConfirmations,
            initialHours: data.hours,
          ),
          compassBaseRoutes: [
            walletDeployConfirmRoute,
          ],
        );

  @override
  WalletMultisigConfigRouteData fromQueryParams(
    Map<String, String> queryParams,
  ) {
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

    return WalletMultisigConfigRouteData(
      address: Address(address: queryParams[_addressQueryParam]!),
      publicKey: PublicKey(publicKey: queryParams[_publicKeyQueryParam]!),
      custodians: custodians,
      requireConfirmations: requireConfirmations,
      hours: hours,
    );
  }
}

class WalletMultisigConfigRouteData implements CompassRouteDataQuery {
  const WalletMultisigConfigRouteData({
    required this.address,
    required this.publicKey,
    this.custodians,
    this.requireConfirmations,
    this.hours,
  });

  final Address address;
  final PublicKey publicKey;
  final List<PublicKey>? custodians;
  final int? requireConfirmations;
  final int? hours;

  @override
  Map<String, String> toQueryParams() {
    return {
      _addressQueryParam: address.address,
      _publicKeyQueryParam: publicKey.publicKey,
      if (custodians != null && custodians!.isNotEmpty)
        _custodiansQueryParam: custodians!.map((e) => e.publicKey).join(','),
      if (requireConfirmations != null)
        _requireConfirmationsQueryParam: requireConfirmations!.toString(),
      if (hours != null) _hoursQueryParam: hours!.toString(),
    };
  }
}
