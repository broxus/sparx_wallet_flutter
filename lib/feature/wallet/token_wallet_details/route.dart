import 'package:app/app/router/compass/bottom_bar_state.dart';
import 'package:app/app/router/compass/compass.dart';
import 'package:app/feature/wallet/token_wallet_details/view/token_wallet_details_page.dart';
import 'package:app/feature/wallet/wallet_prepare_transfer/route.dart';
import 'package:injectable/injectable.dart';
import 'package:nekoton_repository/nekoton_repository.dart';

const _ownerAddressQueryParam = 'ownerAddress';
const _contractAddressQueryParam = 'contractAddress';

@named
@Singleton(as: CompassBaseRoute)
class TokenWalletDetailsRoute
    extends CompassRoute<TokenWalletDetailsRouteData> {
  TokenWalletDetailsRoute(
    @Named.from(WalletPrepareSpecifiedTransferRoute)
    CompassBaseRoute walletPrepareTransferRoute,
  ) : super(
          path: '/token-details',
          bottomBarState: BottomBarState.hidden,
          builder: (context, data, _) => TokenWalletDetailsPage(
            owner: data.owner,
            rootTokenContract: data.rootTokenContract,
          ),
          compassBaseRoutes: [walletPrepareTransferRoute],
        );

  @override
  TokenWalletDetailsRouteData fromQueryParams(Map<String, String> queryParams) {
    return TokenWalletDetailsRouteData(
      owner: Address(
        address: queryParams[_ownerAddressQueryParam]!,
      ),
      rootTokenContract: Address(
        address: queryParams[_contractAddressQueryParam]!,
      ),
    );
  }
}

class TokenWalletDetailsRouteData implements CompassRouteDataQuery {
  const TokenWalletDetailsRouteData({
    required this.owner,
    required this.rootTokenContract,
  });

  /// Owner of token wallet
  final Address owner;

  /// Root token contract address
  final Address rootTokenContract;

  @override
  Map<String, String> toQueryParams() {
    return {
      _ownerAddressQueryParam: owner.address,
      _contractAddressQueryParam: rootTokenContract.address,
    };
  }
}
