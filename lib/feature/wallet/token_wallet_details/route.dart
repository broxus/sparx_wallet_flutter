import 'package:app/app/router/compass/compass.dart';
import 'package:app/feature/wallet/token_wallet_details/view/token_wallet_details_page.dart';
import 'package:app/feature/wallet/wallet_prepare_transfer/route.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:injectable/injectable.dart';
import 'package:nekoton_repository/nekoton_repository.dart';

part 'route.freezed.dart';

const tokenWalletDetailsOwnerAddressQueryParam =
    'tokenWalletDetailsOwnerAddress';
const tokenWalletDetailsContractAddressQueryParam =
    'tokenWalletDetailsContractAddress';

@singleton
class TokenWalletDetailsRoute
    extends CompassRoute<TokenWalletDetailsRouteData, void> {
  TokenWalletDetailsRoute({
    required this.walletPrepareTransferRoute,
  }) : super(
          name: 'token-wallet-details',
          builder: (context, data, _) => TokenWalletDetailsPage(
            owner: data.owner,
            rootTokenContract: data.rootTokenContract,
          ),
          compassBaseRoutes: [walletPrepareTransferRoute],
        );

  final WalletPrepareTransferRoute walletPrepareTransferRoute;

  @override
  TokenWalletDetailsRouteData fromQueryParams(Map<String, String> queryParams) {
    return TokenWalletDetailsRouteData(
      owner: Address(
        address: queryParams[tokenWalletDetailsOwnerAddressQueryParam]!,
      ),
      rootTokenContract: Address(
        address: queryParams[tokenWalletDetailsContractAddressQueryParam]!,
      ),
    );
  }
}

/// Data model for TokenWalletDetails route
@freezed
class TokenWalletDetailsRouteData
    with _$TokenWalletDetailsRouteData
    implements CompassRouteDataQuery {
  const factory TokenWalletDetailsRouteData({
    /// Owner of token wallet
    required Address owner,

    /// Root token contract address
    required Address rootTokenContract,
  }) = _TokenWalletDetailsRouteData;

  const TokenWalletDetailsRouteData._();

  @override
  Map<String, String> toQueryParams() {
    return {
      tokenWalletDetailsOwnerAddressQueryParam: owner.address,
      tokenWalletDetailsContractAddressQueryParam: rootTokenContract.address,
    };
  }
}
