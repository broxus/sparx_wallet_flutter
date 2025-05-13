import 'package:app/app/router/compass/compass.dart';
import 'package:app/feature/wallet/token_wallet_send/route.dart';
import 'package:app/feature/wallet/ton_wallet_send/route.dart';
import 'package:app/feature/wallet/wallet_prepare_transfer/wallet_prepare_transfer_page.dart';
import 'package:app/utils/utils.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:injectable/injectable.dart';
import 'package:nekoton_repository/nekoton_repository.dart';

part 'route.freezed.dart';

/// Constants for query parameters
const walletPrepareTransferAddressQueryParam = 'walletPrepareTransferAddress';
const walletPrepareTransferDestinationQueryParam =
    'walletPrepareTransferDestination';
const walletPrepareTransferRootTokenAddressQueryParam =
    'walletPrepareTransferRootTokenAddress';
const walletPrepareTransferSymbolQueryParam = 'walletPrepareTransferSymbol';
const walletPrepareTransferTypeQueryParam = 'walletPrepareTransferType';

@named
@Singleton(as: CompassBaseRoute)
class WalletPrepareTransferRoute
    extends CompassRoute<WalletPrepareTransferRouteData> {
  WalletPrepareTransferRoute(
    @Named.from(TonWalletSendRoute) CompassBaseRoute tonWalletSendRoute,
    @Named.from(TokenWalletSendRoute) CompassBaseRoute tokenWalletSendRoute,
  ) : super(
          name: 'wallet-prepare-transfer',
          builder: (context, data, _) {
            return data.map(
              basic: (basic) => WalletPrepareTransferPage(
                address: basic.address,
                destination: basic.destination,
              ),
              specified: (specified) => WalletPrepareTransferPage(
                address: specified.address,
                rootTokenContract: specified.rootTokenContract,
                tokenSymbol: specified.tokenSymbol,
              ),
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
    final transferType = queryParams[walletPrepareTransferTypeQueryParam];
    final address = Address(
      address: queryParams[walletPrepareTransferAddressQueryParam]!,
    );

    // If this is a specified token transfer
    if (transferType == 'specified') {
      final rootTokenContract = Address(
        address: queryParams[walletPrepareTransferRootTokenAddressQueryParam]!,
      );

      final tokenSymbol = queryParams[walletPrepareTransferSymbolQueryParam]!;

      return WalletPrepareTransferRouteData.specified(
        address: address,
        rootTokenContract: rootTokenContract,
        tokenSymbol: tokenSymbol,
      );
    }
    // Otherwise it's a basic transfer
    else {
      final destination =
          queryParams[walletPrepareTransferDestinationQueryParam]?.let(
        (address) => Address(address: address),
      );

      return WalletPrepareTransferRouteData.basic(
        address: address,
        destination: destination,
      );
    }
  }
}

/// Data model for WalletPrepareTransfer route
@freezed
sealed class WalletPrepareTransferRouteData
    with _$WalletPrepareTransferRouteData
    implements CompassRouteDataQuery {
  /// Basic transfer with optional destination
  const factory WalletPrepareTransferRouteData.basic({
    /// Address of wallet for transfer
    required Address address,

    /// Optional destination address
    Address? destination,
  }) = _BasicWalletPrepareTransferRouteData;

  /// Transfer with specified token
  const factory WalletPrepareTransferRouteData.specified({
    /// Address of wallet for transfer
    required Address address,

    /// Root token contract address
    required Address rootTokenContract,

    /// Token symbol
    required String tokenSymbol,
  }) = _SpecifiedWalletPrepareTransferRouteData;

  const WalletPrepareTransferRouteData._();

  @override
  Map<String, String> toQueryParams() {
    return map(
      basic: (basic) {
        final params = {
          walletPrepareTransferAddressQueryParam: basic.address.address,
          walletPrepareTransferTypeQueryParam: 'basic',
        };

        if (basic.destination != null) {
          params[walletPrepareTransferDestinationQueryParam] =
              basic.destination!.address;
        }

        return params;
      },
      specified: (specified) {
        return {
          walletPrepareTransferAddressQueryParam: specified.address.address,
          walletPrepareTransferRootTokenAddressQueryParam:
              specified.rootTokenContract.address,
          walletPrepareTransferSymbolQueryParam: specified.tokenSymbol,
          walletPrepareTransferTypeQueryParam: 'specified',
        };
      },
    );
  }
}
