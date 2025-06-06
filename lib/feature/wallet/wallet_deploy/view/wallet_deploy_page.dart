import 'package:app/app/router/router.dart';
import 'package:app/di/di.dart';
import 'package:app/feature/wallet/route.dart';
import 'package:app/feature/wallet/wallet.dart';
import 'package:app/generated/generated.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:nekoton_repository/nekoton_repository.dart';
import 'package:ui_components_lib/ui_components_lib.dart';

/// Page that allows deploy wallet with [address] and [publicKey]
class WalletDeployPage extends StatelessWidget {
  const WalletDeployPage({
    required this.address,
    required this.publicKey,
    super.key,
  });

  final Address address;
  final PublicKey publicKey;

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (_) => WalletDeployBloc(
        context: context,
        address: address,
        publicKey: publicKey,
        nekotonRepository: inject(),
        currenciesService: inject(),
      ),
      child: BlocConsumer<WalletDeployBloc, WalletDeployState>(
        listener: (context, state) {
          state.whenOrNull(
            deployed: (
              _,
              __,
              ___,
              ____,
              _____,
              ______,
            ) =>
                context.compassPointNamed(const WalletRouteData()),
          );
        },
        builder: (context, state) {
          return state.maybeWhen(
            subscribeError: (error) => _scaffold(
              WalletSubscribeErrorWidget(error: error),
            ),
            standard: () => _scaffold(const WalletDeployStandardBody()),
            multisig: (custodians, requireConfirmations, hours, walletType) =>
                _scaffold(
              WalletDeployMultisigBody(
                custodians: custodians,
                requireConfirmations: requireConfirmations,
                hours: hours,
                walletType: walletType,
              ),
            ),
            calculatingError: (
              error,
              fee,
              balance,
              custodians,
              requireConfirmations,
              tonIconPath,
              ticker,
              customCurrency,
            ) =>
                _scaffold(
              WalletDeployConfirmView(
                publicKey: publicKey,
                balance: balance,
                feeError: error,
                fee: fee,
                custodians: custodians,
                requireConfirmations: requireConfirmations,
                tonIconPath: tonIconPath,
                currency: Currencies()[ticker ?? ''],
                customCurrency: customCurrency,
              ),
              canPrev: true,
            ),
            readyToDeploy: (
              fee,
              balance,
              custodians,
              requireConfirmations,
              tonIconPath,
              ticker,
              customCurrency,
              account,
              hours,
            ) {
              return _scaffold(
                WalletDeployConfirmView(
                  publicKey: publicKey,
                  balance: balance,
                  fee: fee,
                  custodians: custodians,
                  requireConfirmations: requireConfirmations,
                  tonIconPath: tonIconPath,
                  currency: Currencies()[ticker ?? ''],
                  customCurrency: customCurrency,
                  account: account,
                ),
                canPrev: true,
              );
            },
            deployed: (
              fee,
              balance,
              transaction,
              custodians,
              requireConfirmations,
              tonIconPath,
            ) =>
                _scaffold(
              WalletDeployConfirmView(
                publicKey: publicKey,
                balance: balance,
                fee: fee,
                custodians: custodians,
                requireConfirmations: requireConfirmations,
                tonIconPath: tonIconPath,
              ),
            ),
            deploying: (canClose) => Scaffold(
              body: Padding(
                padding: const EdgeInsets.all(DimensSize.d16),
                child: TransactionSendingWidget(
                  canClose: canClose,
                  popOnComplete: false,
                  isDeploying: true,
                ),
              ),
            ),
            orElse: () => _scaffold(const SizedBox(), canPrev: true),
          );
        },
      ),
    );
  }

  Widget _scaffold(Widget body, {bool canPrev = false}) {
    return Builder(
      builder: (context) {
        final colors = context.themeStyleV2.colors;
        return GestureDetector(
          onTap: () => FocusScope.of(context).unfocus(),
          child: Scaffold(
            backgroundColor: colors.background0,
            appBar: DefaultAppBar(
              titleText: canPrev
                  ? LocaleKeys.deployWallet.tr()
                  : LocaleKeys.selectWalletType.tr(),
              onClosePressed: (context) {
                if (canPrev) {
                  context
                      .read<WalletDeployBloc>()
                      .add(const WalletDeployEvent.goPrevStep());
                } else {
                  context.compassBack();
                }
              },
            ),
            body: body,
          ),
        );
      },
    );
  }
}
