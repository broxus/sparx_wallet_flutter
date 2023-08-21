import 'package:app/app/router/router.dart';
import 'package:app/feature/add_seed/add_seed_enable_biometry/add_seed_enable_biometry.dart';
import 'package:app/feature/wallet/wallet.dart';
import 'package:app/feature/wallet/widgets/account_asset_tab/select_new_asset/select_new_asset.dart';
import 'package:go_router/go_router.dart';
import 'package:nekoton_repository/nekoton_repository.dart';

const selectNewAssetAddressPathParam = 'selectNewAssetAddress';
const tonWalletDetailsAddressPathParam = 'tonWalletDetailsAddress';
const tokenWalletDetailsOwnerAddressPathParam = 'tonWalletDetailsOwnerAddress';
const tokenWalletDetailsContractAddressPathParam =
    'tonWalletDetailsContractAddress';
const walletPrepareTransferAddressPathParam = 'walletPrepareAddress';
const walletPrepareTransferRootTokenAddressPathParam =
    'walletPrepareRootTokenAddress';

const tonWalletSendAddressQueryParam = 'tonWalletSendAddress';
const tonWalletSendPublicKeyQueryParam = 'tonWalletSendPublicKey';
const tonWalletSendCommentQueryParam = 'tonWalletSendComment';
const tonWalletSendDestinationQueryParam = 'tonWalletSendDestination';
const tonWalletSendAmountQueryParam = 'tonWalletSendAmount';

const tokenWalletSendOwnerQueryParam = 'tokenWalletSendOwner';
const tokenWalletSendContractQueryParam = 'tokenWalletSendContract';
const tokenWalletSendPublicKeyQueryParam = 'tokenWalletSendPublicKey';
const tokenWalletSendCommentQueryParam = 'tokenWalletSendComment';
const tokenWalletSendDestinationQueryParam = 'tokenWalletSendDestination';
const tokenWalletSendAmountQueryParam = 'tokenWalletSendAmount';
const tokenWalletSendAttachedAmountQueryParam = 'tokenWalletSendAttachedAmount';

/// Branch that is root for wallet.
StatefulShellBranch get walletBranch {
  return StatefulShellBranch(
    routes: [
      GoRoute(
        name: AppRoute.wallet.name,
        path: AppRoute.wallet.path,
        builder: (context, state) => const WalletPage(),
        routes: [
          GoRoute(
            path: AppRoute.enableBiometryAfterOnboarding.path,
            builder: (_, __) => const AddSeedEnableBiometryPage(),
          ),
          GoRoute(
            path: AppRoute.selectNewAsset.path,
            builder: (_, state) => SelectNewAssetPage(
              address: Address(
                address: state.pathParameters[selectNewAssetAddressPathParam]!,
              ),
            ),
          ),
          addSeedNamedRoute,
          tonWalletDetailsRoute,
          tokenWalletDetailsRoute,
          walletPrepareTransferRoute,
        ],
      ),
    ],
  );
}

GoRoute get tonWalletDetailsRoute {
  return GoRoute(
    path: AppRoute.tonWalletDetails.path,
    builder: (_, state) => TonWalletDetailsPage(
      address: Address(
        address: state.pathParameters[tonWalletDetailsAddressPathParam]!,
      ),
    ),
    routes: [
      walletPrepareTransferLockedRoute,
    ],
  );
}

GoRoute get tokenWalletDetailsRoute {
  return GoRoute(
    path: AppRoute.tokenWalletDetails.path,
    builder: (_, state) => TokenWalletDetailsPage(
      owner: Address(
        address: state.pathParameters[tokenWalletDetailsOwnerAddressPathParam]!,
      ),
      rootTokenContract: Address(
        address:
            state.pathParameters[tokenWalletDetailsContractAddressPathParam]!,
      ),
    ),
    routes: [
      walletPrepareTransferLockedRoute,
    ],
  );
}

/// Prepare transfer with selecting token
GoRoute get walletPrepareTransferRoute {
  return GoRoute(
    path: AppRoute.walletPrepareTransfer.path,
    builder: (_, state) => WalletPrepareTransferPage(
      address: Address(
        address: state.pathParameters[walletPrepareTransferAddressPathParam]!,
      ),
    ),
    routes: [
      tonWalletSend,
      tokenWalletSend,
    ],
  );
}

/// Prepare transfer with specified token
GoRoute get walletPrepareTransferLockedRoute {
  return GoRoute(
    path: AppRoute.walletPrepareTransferSpecified.path,
    builder: (_, state) => WalletPrepareTransferPage(
      address: Address(
        address: state.pathParameters[walletPrepareTransferAddressPathParam]!,
      ),
      rootTokenContract: Address(
        address: state
            .pathParameters[walletPrepareTransferRootTokenAddressPathParam]!,
      ),
    ),
    routes: [
      tonWalletSend,
      tokenWalletSend,
    ],
  );
}

/// Send native token from TonWallet
GoRoute get tonWalletSend {
  return GoRoute(
    path: AppRoute.tonWalletSend.path,
    builder: (context, state) {
      return TonWalletSendPage(
        address: Address(
          address: state.queryParameters[tonWalletSendAddressQueryParam]!,
        ),
        publicKey: PublicKey(
          publicKey: state.queryParameters[tonWalletSendPublicKeyQueryParam]!,
        ),
        destination: Address(
          address: state.queryParameters[tonWalletSendDestinationQueryParam]!,
        ),
        amount: BigInt.parse(
          state.queryParameters[tonWalletSendAmountQueryParam]!,
        ),
        comment: state.queryParameters[tonWalletSendCommentQueryParam],
      );
    },
  );
}

GoRoute get tokenWalletSend {
  return GoRoute(
    path: AppRoute.tokenWalletSend.path,
    builder: (context, state) {
      return TokenWalletSendPage(
        owner: Address(
          address: state.queryParameters[tokenWalletSendOwnerQueryParam]!,
        ),
        rootTokenContract: Address(
          address: state.queryParameters[tokenWalletSendContractQueryParam]!,
        ),
        publicKey: PublicKey(
          publicKey: state.queryParameters[tokenWalletSendPublicKeyQueryParam]!,
        ),
        destination: Address(
          address: state.queryParameters[tokenWalletSendDestinationQueryParam]!,
        ),
        attachedAmount: BigInt.tryParse(
          state.queryParameters[tokenWalletSendAttachedAmountQueryParam] ?? '',
        ),
        amount: BigInt.parse(
          state.queryParameters[tokenWalletSendAmountQueryParam]!,
        ),
        comment: state.queryParameters[tokenWalletSendCommentQueryParam],
      );
    },
  );
}
