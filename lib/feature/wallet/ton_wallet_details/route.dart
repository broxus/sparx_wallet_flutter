import 'package:app/app/router/compass/compass.dart';
import 'package:app/feature/wallet/confirm_multisig_transaction/route.dart';
import 'package:app/feature/wallet/ton_wallet_details/view/ton_wallet_details_page.dart';
import 'package:app/feature/wallet/wallet_deploy/route.dart';
import 'package:app/feature/wallet/wallet_prepare_transfer/route.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:injectable/injectable.dart';
import 'package:nekoton_repository/nekoton_repository.dart';

part 'route.freezed.dart';

const tonWalletDetailsAddressQueryParam = 'tonWalletDetailsAddress';

@named
@Singleton(as: CompassBaseRoute)
class TonWalletDetailsRoute extends CompassRoute<TonWalletDetailsRouteData> {
  TonWalletDetailsRoute(
    @Named.from(WalletDeployRoute) CompassBaseRoute walletDeployRoute,
    @Named.from(WalletPrepareTransferRoute)
    CompassBaseRoute walletPrepareTransferRoute,
    @Named.from(ConfirmMultisigTransactionRoute)
    CompassBaseRoute confirmMultisigTransactionRoute,
  ) : super(
          name: 'ton-wallet-details',
          builder: (context, data, _) => TonWalletDetailsPage(
            address: data.address,
          ),
          compassBaseRoutes: [
            walletDeployRoute,
            walletPrepareTransferRoute,
            confirmMultisigTransactionRoute,
          ],
        );

  @override
  TonWalletDetailsRouteData fromQueryParams(Map<String, String> queryParams) {
    return TonWalletDetailsRouteData(
      address: Address(
        address: queryParams[tonWalletDetailsAddressQueryParam]!,
      ),
    );
  }
}

/// Data model for TonWalletDetails route
@freezed
class TonWalletDetailsRouteData
    with _$TonWalletDetailsRouteData
    implements CompassRouteDataQuery {
  const factory TonWalletDetailsRouteData({
    /// Address of TON wallet to display
    required Address address,
  }) = _TonWalletDetailsRouteData;

  const TonWalletDetailsRouteData._();

  @override
  Map<String, String> toQueryParams() {
    return {
      tonWalletDetailsAddressQueryParam: address.address,
    };
  }
}
