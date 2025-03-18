import 'package:app/feature/wallet/wallet.dart';
import 'package:app/generated/assets.gen.dart';
import 'package:flutter/material.dart';
import 'package:nekoton_repository/nekoton_repository.dart';
import 'package:ui_components_lib/ui_components_lib.dart';

class WalletView extends StatelessWidget {
  const WalletView({
    required this.currentAccount,
    required this.scrollController,
    required this.isShowingBadge,
    required this.isShowingNewTokens,
    required this.hasUnconfirmedTransactions,
    required this.finishedBackupCallback,
    required this.confirmImportCallback,
    required this.manifestUrl,
    super.key,
  });

  final KeyAccount? currentAccount;
  final ScrollController scrollController;
  final bool isShowingBadge;
  final bool isShowingNewTokens;
  final bool hasUnconfirmedTransactions;
  final VoidCallback finishedBackupCallback;
  final VoidCallback confirmImportCallback;
  final String manifestUrl;

  @override
  Widget build(BuildContext context) {
    final theme = context.themeStyleV2;

    return SafeArea(
      child: Stack(
        children: [
          const _Background(),
          CustomScrollView(
            physics: const ClampingScrollPhysics(),
            controller: scrollController,
            slivers: [
              const SliverToBoxAdapter(
                child: WalletAppBarWidget(),
              ),
              WalletAccountsBody(
                account: currentAccount,
                isShowingBadge: isShowingBadge,
                finishedBackupCallback: finishedBackupCallback,
              ),
              WalletBottomPanel(
                currentAccount: currentAccount!,
                scrollController: scrollController,
                isShowingNewTokens: isShowingNewTokens,
                confirmImportCallback: confirmImportCallback,
                manifestUrl: manifestUrl,
                hasUnconfirmedTransactions: hasUnconfirmedTransactions,
              ),
              SliverFillRemaining(
                hasScrollBody: false,
                child: Container(color: theme.colors.background0),
              ),
            ],
          ),
        ],
      ),
    );
  }
}

class _Background extends StatelessWidget {
  const _Background();

  @override
  Widget build(BuildContext context) {
    return Positioned(
      top: -DimensSizeV2.d16,
      left: 0,
      right: 0,
      child: Padding(
        padding: const EdgeInsets.all(DimensSizeV2.d8),
        child: Image.asset(
          Assets.images.bgMain.bgMain.path,
          fit: BoxFit.contain,
          alignment: Alignment.topCenter,
        ),
      ),
    );
  }
}
