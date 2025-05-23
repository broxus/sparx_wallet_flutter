// ignore_for_file: deprecated_member_use_from_same_package

import 'dart:convert';

import 'package:app/app/router/router.dart';
import 'package:app/app/router/routs/wallet/ton_wallet_send_route_data.dart';
import 'package:app/data/models/models.dart';
import 'package:app/di/di.dart';
import 'package:app/feature/biometry/view/biometry_screen.dart';
import 'package:app/feature/network/network.dart';
import 'package:app/feature/no_internet/no_internet_screen.dart';
import 'package:app/feature/splash/splash_screen.dart';
import 'package:app/feature/wallet/custodians_settings/custodians_settings_page.dart';
import 'package:app/feature/wallet/new_account/add_account.dart';
import 'package:app/feature/wallet/new_account/add_account_page.dart';
import 'package:app/feature/wallet/new_account/add_external_account/add_external_account_page.dart';
import 'package:app/feature/wallet/new_account/screen/new_account_screen.dart';
import 'package:app/feature/wallet/new_account/select_seed/select_seed_page.dart';
import 'package:app/feature/wallet/wallet.dart';
import 'package:app/feature/wallet/widgets/account_asset_tab/select_new_asset/select_new_asset.dart';
import 'package:app/utils/utils.dart';
import 'package:go_router/go_router.dart';
import 'package:nekoton_repository/nekoton_repository.dart';

const selectNewAssetAddressPathParam = 'selectNewAssetAddress';
const walletSelectSeedPathParam = 'walletSelectSeedSeeds';
const custodianSettingsCustodiansParam = 'custodianSettingsCustodiansParam';
const tonWalletDetailsAddressPathParam = 'tonWalletDetailsAddress';
const tokenWalletDetailsOwnerAddressPathParam = 'tonWalletDetailsOwnerAddress';
const tokenWalletDetailsContractAddressPathParam =
    'tonWalletDetailsContractAddress';
const walletPrepareTransferAddressPathParam = 'walletPrepareAddress';
const walletPrepareTransferRootTokenAddressPathParam =
    'walletPrepareRootTokenAddress';
const walletPrepareTransferSymbolPathParam = 'walletPrepareSymbol';

const walletPrepareTransferDestinationQueryParam = 'walletPrepareDestination';

const tokenWalletSendOwnerQueryParam = 'tokenWalletSendOwner';
const tokenWalletSendContractQueryParam = 'tokenWalletSendContract';
const tokenWalletSendPublicKeyQueryParam = 'tokenWalletSendPublicKey';
const tokenWalletSendCommentQueryParam = 'tokenWalletSendComment';
const tokenWalletSendDestinationQueryParam = 'tokenWalletSendDestination';
const tokenWalletSendAmountQueryParam = 'tokenWalletSendAmount';
const tokenWalletSendAttachedAmountQueryParam = 'tokenWalletSendAttachedAmount';
const tokenWalletSendResultMessageQueryParam = 'tokenWalletSendResultMessage';
const tokenWalletSendNotifyReceiverQueryParam = 'tokenWalletSendNotifyReceiver';

const walletDeployAddressPathParam = 'walletDeployAddress';
const walletDeployPublicKeyPathParam = 'walletDeployPublicKey';

const confirmMultisigTransactionWalletAddressQueryParam =
    'tonWalletConfirmTransactionAddress';
const confirmMultisigTransactionLocalCustodiansQueryParam =
    'tonWalletConfirmTransactionLocalCustodians';
const confirmMultisigTransactionTransactionIdQueryParam =
    'tonWalletConfirmTransactionTransactionId';
const confirmMultisigTransactionIdHashQueryParam =
    'tonWalletConfirmTransactionIdHash';
const confirmMultisigTransactionDestinationQueryParam =
    'tonWalletConfirmTransactionDestination';
const confirmMultisigTransactionAmountQueryParam =
    'tonWalletConfirmTransactionAmount';
const confirmMultisigTransactionCommentQueryParam =
    'tonWalletConfirmTransactionComment';

const networkConnectionDataIdQueryParam = 'connectionDataId';

const walletStakeAddressPathParam = 'walletStakeAddress';

const walletCancelUnstakingRequestQueryParam = 'walletCancelUnstakingRequest';
const walletCancelUnstakingPublicKeyQueryParam =
    'walletCancelUnstakingPublicKey';
const walletCancelUnstakingExchangeRateQueryParam =
    'walletCancelUnstakingExchangeRate';
const walletCancelUnstakingWithdrawHorsQueryParam =
    'walletCancelUnstakingWithdrawHors';
const walletCancelUnstakingStakingCurrencyCodeQueryParam =
    'walletCancelUnstakingStakingCurrencyCode';
const walletCancelUnstakingAttachedFeeQueryParam =
    'walletCancelUnstakingStakingAttachedFee';
const walletCancelUnstakingTokenPriceQueryParam =
    'walletCancelUnstakingTokenPrice';
const walletCancelUnstakingEverPriceQueryParam =
    'walletCancelUnstakingEverPrice';

const walletCreatePublicKeyQueryParam = 'walletCreatePublicKey';
const walletCreatePasswordQueryParam = 'walletCreatePassword';

TonWalletSendRoute get _tonWalletSendRoute => inject<TonWalletSendRoute>();

/// Branch that is root for wallet.
StatefulShellBranch get walletBranch {
  return StatefulShellBranch(
    routes: [
      GoRoute(
        name: AppRoute.wallet.name,
        path: AppRoute.wallet.path,
        builder: (context, state) => const WalletPageWidget(),
        routes: [
          GoRoute(
            path: AppRoute.enableBiometry.path,
            builder: (_, __) => const BiometryScreen(),
          ),
          GoRoute(
            path: AppRoute.selectNewAsset.path,
            builder: (_, state) => SelectNewAssetPage(
              address: Address(
                address: state.pathParameters[selectNewAssetAddressPathParam]!,
              ),
            ),
          ),
          GoRoute(
            path: AppRoute.custodiansSettings.path,
            builder: (_, state) {
              try {
                final decoded = (jsonDecode(
                  state.uri.queryParameters[custodianSettingsCustodiansParam]!,
                ) as List<dynamic>)
                    .cast<String>();
                return CustodiansSettingsPage(custodians: decoded);
              } catch (_) {
                return const CustodiansSettingsPage(custodians: []);
              }
            },
          ),
          GoRoute(
            path: AppRoute.walletAddAccount.path,
            builder: (_, state) => const AddAccountPage(),
            routes: [
              GoRoute(
                path: AppRoute.walletSelectSeed.path,
                builder: (_, state) => const SelectSeedPage(),
                routes: [
                  GoRoute(
                    path: AppRoute.walletNewAccount.path,
                    builder: (_, state) => NewAccountScreen(
                      publicKey: getQueryParams(
                        state,
                        walletCreatePublicKeyQueryParam,
                      ),
                      password: getQueryParams(
                        state,
                        walletCreatePasswordQueryParam,
                      ),
                    ),
                  ),
                ],
              ),
              GoRoute(
                path: AppRoute.walletNewAccount.path,
                builder: (_, state) => NewAccountScreen(
                  publicKey: getQueryParams(
                    state,
                    walletCreatePublicKeyQueryParam,
                  ),
                  password: getQueryParams(
                    state,
                    walletCreatePasswordQueryParam,
                  ),
                ),
              ),
              GoRoute(
                path: AppRoute.walletNewExternalAccount.path,
                builder: (_, state) => const AddExternalAccountPage(),
              ),
            ],
          ),
          addSeedNamedRoute,
          tonWalletDetailsRoute,
          tokenWalletDetailsRoute,
          walletPrepareTransferRoute,
          walletDeployRoute,
          confirmMultisigTranscationRoute,
          configureNetworksRoute,
          stakingRoute,
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
      walletDeployRoute,
      walletPrepareTransferLockedRoute,
      confirmMultisigTranscationRoute,
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
      destination: state
          .uri.queryParameters[walletPrepareTransferDestinationQueryParam]
          ?.let((address) => Address(address: address)),
    ),
    routes: [
      _tonWalletSendRoute.route,
      tokenWalletSendRoute,
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
      tokenSymbol: state.pathParameters[walletPrepareTransferSymbolPathParam],
    ),
    routes: [
      _tonWalletSendRoute.route,
      tokenWalletSendRoute,
    ],
  );
}

/// Send not native tokens
GoRoute get tokenWalletSendRoute {
  return GoRoute(
    path: AppRoute.tokenWalletSend.path,
    builder: (context, state) {
      return TokenWalletSendWidget(
        owner: Address(
          address: state.uri.queryParameters[tokenWalletSendOwnerQueryParam]!,
        ),
        rootTokenContract: Address(
          address:
              state.uri.queryParameters[tokenWalletSendContractQueryParam]!,
        ),
        publicKey: PublicKey(
          publicKey:
              state.uri.queryParameters[tokenWalletSendPublicKeyQueryParam]!,
        ),
        destination: Address(
          address:
              state.uri.queryParameters[tokenWalletSendDestinationQueryParam]!,
        ),
        attachedAmount: BigInt.tryParse(
          state.uri.queryParameters[tokenWalletSendAttachedAmountQueryParam] ??
              '',
        ),
        amount: BigInt.parse(
          state.uri.queryParameters[tokenWalletSendAmountQueryParam]!,
        ),
        comment: state.uri.queryParameters[tokenWalletSendCommentQueryParam],
        resultMessage:
            state.uri.queryParameters[tokenWalletSendResultMessageQueryParam],
        notifyReceiver: bool.tryParse(
          state.uri.queryParameters[tokenWalletSendNotifyReceiverQueryParam] ??
              '',
        ),
      );
    },
  );
}

/// Deploy account to blockchain
GoRoute get walletDeployRoute {
  return GoRoute(
    path: AppRoute.walletDeploy.path,
    builder: (context, state) {
      return WalletDeployPage(
        address: Address(
          address: state.pathParameters[walletDeployAddressPathParam]!,
        ),
        publicKey: PublicKey(
          publicKey: state.pathParameters[walletDeployPublicKeyPathParam]!,
        ),
      );
    },
  );
}

/// Confirm multisig transaction for TonWallet
GoRoute get confirmMultisigTranscationRoute {
  return GoRoute(
    path: AppRoute.confirmMultisigTransaction.path,
    builder: (context, state) {
      final decoded = (jsonDecode(
        state.uri.queryParameters[
            confirmMultisigTransactionLocalCustodiansQueryParam]!,
      ) as List<dynamic>)
          .cast<String>();

      return ConfirmMultisigTransactionWidget(
        walletAddress: Address(
          address: state.uri.queryParameters[
              confirmMultisigTransactionWalletAddressQueryParam]!,
        ),
        localCustodians: decoded.map((e) => PublicKey(publicKey: e)).toList(),
        transactionId: state.uri.queryParameters[
            confirmMultisigTransactionTransactionIdQueryParam]!,
        transactionIdHash: state
            .uri.queryParameters[confirmMultisigTransactionIdHashQueryParam],
        destination: Address(
          address: state.uri.queryParameters[
              confirmMultisigTransactionDestinationQueryParam]!,
        ),
        amount: BigInt.parse(
          state
              .uri.queryParameters[confirmMultisigTransactionAmountQueryParam]!,
        ),
        comment: state
            .uri.queryParameters[confirmMultisigTransactionCommentQueryParam],
      );
    },
  );
}

/// Configure networks
GoRoute get configureNetworksRoute {
  return GoRoute(
    path: AppRoute.configureNetworks.path,
    builder: (_, __) => const ConfigureNetworksPage(),
    routes: [
      GoRoute(
        path: AppRoute.editNetwork.path,
        builder: (_, state) => EditNetworkPageWidget(
          connectionDataId:
              state.uri.queryParameters[networkConnectionDataIdQueryParam],
        ),
      ),
    ],
  );
}

GoRoute get stakingRoute {
  return GoRoute(
    path: AppRoute.walletStake.path,
    builder: (context, state) => StakingPageWidget(
      accountAddress: Address(
        address: state.pathParameters[walletStakeAddressPathParam]!,
      ),
    ),
    routes: [
      _tonWalletSendRoute.route,
      tokenWalletSendRoute,
      cancelUnstakingRoute,
    ],
  );
}

GoRoute get cancelUnstakingRoute {
  return GoRoute(
    path: AppRoute.walletCancelUnstaking.path,
    builder: (context, state) => CancelUnstakingPageWidget(
      request: StEverWithdrawRequest.fromJson(
        jsonDecode(
          state.uri.queryParameters[walletCancelUnstakingRequestQueryParam]!,
        ) as Map<String, dynamic>,
      ),
      accountKey: PublicKey(
        publicKey: state
            .uri.queryParameters[walletCancelUnstakingPublicKeyQueryParam]!,
      ),
      attachedFee: BigInt.parse(
        state.uri.queryParameters[walletCancelUnstakingAttachedFeeQueryParam]!,
      ),
      exchangeRate: double.parse(
        state.uri.queryParameters[walletCancelUnstakingExchangeRateQueryParam]!,
      ),
      stakeCurrency: Currencies()[state.uri.queryParameters[
          walletCancelUnstakingStakingCurrencyCodeQueryParam]!]!,
      withdrawHours: int.parse(
        state.uri.queryParameters[walletCancelUnstakingWithdrawHorsQueryParam]!,
      ),
      tokenPrice: Fixed.tryParse(
        state.uri.queryParameters[walletCancelUnstakingTokenPriceQueryParam] ??
            '',
      ),
      everPrice: Fixed.tryParse(
        state.uri.queryParameters[walletCancelUnstakingEverPriceQueryParam] ??
            '',
      ),
    ),
    routes: [
      _tonWalletSendRoute.route,
    ],
  );
}

GoRoute get noInternetRoute {
  return GoRoute(
    path: AppRoute.noInternet.path,
    builder: (_, state) => const NoInternetScreen(),
  );
}

GoRoute get splashScreenRoute {
  return GoRoute(
    path: AppRoute.splash.path,
    builder: (_, state) => const SplashScreen(),
  );
}
