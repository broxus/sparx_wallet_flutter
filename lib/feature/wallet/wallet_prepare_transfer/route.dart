import 'package:app/app/router/compass/compass.dart';
import 'package:app/feature/wallet/token_wallet_send/route.dart';
import 'package:app/feature/wallet/ton_wallet_send/route.dart';
import 'package:app/feature/wallet/wallet_prepare_transfer/wallet_prepare_transfer_page.dart';
import 'package:app/utils/utils.dart';
import 'package:injectable/injectable.dart';
import 'package:nekoton_repository/nekoton_repository.dart';

/// Constants for query parameters
const _addressQueryParam = 'address';
const _destinationQueryParam = 'destination';
const _rootTokenAddressQueryParam = 'rootTokenAddress';
const _symbolQueryParam = 'transferSymbol';

@named
@Singleton(as: CompassBaseRoute)
class WalletPrepareTransferRoute
    extends CompassRoute<WalletPrepareTransferRouteData> {
  WalletPrepareTransferRoute(
    @Named.from(TonWalletSendRoute) CompassBaseRoute tonWalletSendRoute,
    @Named.from(TokenWalletSendRoute) CompassBaseRoute tokenWalletSendRoute,
  ) : super(
          path: '/wallet-prepare-transfer',
          builder: (context, data, _) {
            return WalletPrepareTransferPage(
              address: data.address,
              destination: data.destination,
            );
          },
          compassBaseRoutes: [
            tonWalletSendRoute,
            tokenWalletSendRoute,
          ],
        );

  @override
  WalletPrepareTransferRouteData fromQueryParams(
    Map<String, String> queryParams,
  ) {
    final address = Address(
      address: queryParams[_addressQueryParam]!,
    );

    final destination = queryParams[_destinationQueryParam]?.let(
      (address) => Address(address: address),
    );

    return WalletPrepareTransferRouteData(
      address: address,
      destination: destination,
    );
  }
}

class WalletPrepareTransferRouteData implements CompassRouteDataQuery {
  const WalletPrepareTransferRouteData({
    required this.address,
    this.destination,
  });

  /// Address of wallet for transfer
  final Address address;

  /// Optional destination address
  final Address? destination;

  @override
  Map<String, String> toQueryParams() {
    final destination = this.destination;

    return {
      _addressQueryParam: address.address,
      if (destination != null) _destinationQueryParam: destination.address,
    };
  }
}

@named
@Singleton(as: CompassBaseRoute)
class WalletPrepareSpecifiedTransferRoute
    extends CompassRoute<WalletPrepareSpecifiedTransferRouteData> {
  WalletPrepareSpecifiedTransferRoute(
    @Named.from(TonWalletSendRoute) CompassBaseRoute tonWalletSendRoute,
    @Named.from(TokenWalletSendRoute) CompassBaseRoute tokenWalletSendRoute,
  ) : super(
          path: '/wallet-prepare-specified-transfer',
          builder: (context, data, _) {
            return WalletPrepareTransferPage(
              address: data.address,
              rootTokenContract: data.rootTokenContract,
              tokenSymbol: data.tokenSymbol,
            );
          },
          compassBaseRoutes: [
            tonWalletSendRoute,
            tokenWalletSendRoute,
          ],
        );

  @override
  WalletPrepareSpecifiedTransferRouteData fromQueryParams(
    Map<String, String> queryParams,
  ) {
    final address = Address(
      address: queryParams[_addressQueryParam]!,
    );

    final rootTokenContract = Address(
      address: queryParams[_rootTokenAddressQueryParam]!,
    );

    final tokenSymbol = queryParams[_symbolQueryParam]!;

    return WalletPrepareSpecifiedTransferRouteData(
      address: address,
      rootTokenContract: rootTokenContract,
      tokenSymbol: tokenSymbol,
    );
  }
}

class WalletPrepareSpecifiedTransferRouteData implements CompassRouteDataQuery {
  const WalletPrepareSpecifiedTransferRouteData({
    required this.address,
    required this.rootTokenContract,
    required this.tokenSymbol,
  });

  /// Address of wallet for transfer
  final Address address;

  /// Root token contract address
  final Address rootTokenContract;

  /// Token symbol
  final String tokenSymbol;

  @override
  Map<String, String> toQueryParams() {
    return {
      _addressQueryParam: address.address,
      _rootTokenAddressQueryParam: rootTokenContract.address,
      _symbolQueryParam: tokenSymbol,
    };
  }
}
