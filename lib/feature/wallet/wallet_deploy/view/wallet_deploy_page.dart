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
        ledgerService: inject(),
        messengerService: inject(),
        permissionsService: inject(),
      ),
      child: BlocConsumer<WalletDeployBloc, WalletDeployState>(
        listener: (context, state) {
          if (state is WalletDeployStateDeployed) {
            context.compassPointNamed(const WalletRouteData());
          }
        },
        builder: (context, state) {
          return switch (state) {
            WalletDeployStateSubscribeError(:final error) => _scaffold(
                WalletSubscribeErrorWidget(error: error),
              ),
            WalletDeployStateStandard() =>
              _scaffold(const WalletDeployStandardBody()),
            WalletDeployStateMultisig() => _scaffold(
                WalletDeployMultisigBody(
                  custodians: state.custodians,
                  requireConfirmations: state.requireConfirmations,
                  hours: state.hours,
                  walletType: state.walletType,
                ),
              ),
            WalletDeployStateCalculatingError() => _scaffold(
                WalletDeployConfirmView(
                  publicKey: publicKey,
                  balance: state.balance,
                  feeError: state.error,
                  fee: state.fee,
                  custodians: state.custodians,
                  requireConfirmations: state.requireConfirmations,
                  tonIconPath: state.tonIconPath,
                  currency: Currencies()[state.ticker ?? ''],
                  customCurrency: state.currency,
                ),
                canPrev: true,
              ),
            WalletDeployStateReadyToDeploy() => _scaffold(
                WalletDeployConfirmView(
                  publicKey: publicKey,
                  balance: state.balance,
                  fee: state.fee,
                  custodians: state.custodians,
                  requireConfirmations: state.requireConfirmations,
                  tonIconPath: state.tonIconPath,
                  currency: Currencies()[state.ticker ?? ''],
                  customCurrency: state.currency,
                  account: state.account,
                  ledgerAuthInput: state.ledgerAuthInput,
                ),
                canPrev: true,
              ),
            WalletDeployStateDeployed() => _scaffold(
                WalletDeployConfirmView(
                  publicKey: publicKey,
                  balance: state.balance,
                  fee: state.fee,
                  custodians: state.custodians,
                  requireConfirmations: state.requireConfirmations,
                  tonIconPath: state.tonIconPath,
                ),
              ),
            WalletDeployStateDeploying(:final canClose) => Scaffold(
                body: Padding(
                  padding: const EdgeInsets.all(DimensSize.d16),
                  child: TransactionSendingWidget(
                    canClose: canClose,
                    popOnComplete: false,
                    isDeploying: true,
                  ),
                ),
              ),
          };
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
