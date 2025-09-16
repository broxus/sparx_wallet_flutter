import 'package:app/app/router/router.dart';
import 'package:app/feature/wallet/wallet_deploy/data/wallet_deploy_type.dart';
import 'package:app/feature/wallet/wallet_deploy/wallet_deploy_confirm/route.dart';
import 'package:app/feature/wallet/wallet_deploy/wallet_multisig_config/route.dart';
import 'package:app/generated/generated.dart';
import 'package:flutter/material.dart';
import 'package:lucide_icons_flutter/lucide_icons.dart';
import 'package:nekoton_repository/nekoton_repository.dart';
import 'package:ui_components_lib/ui_components_lib.dart';

Future<void> showWalletTypeSelectionSheet({
  required BuildContext context,
  required Address address,
  required PublicKey publicKey,
}) async {
  await showCommonBottomSheet<void>(
    context: context,
    title: LocaleKeys.selectWalletType.tr(),
    titleTextStyle: context.themeStyleV2.textStyles.headingLarge,
    body: (context, __) => WalletTypeSelectionSheet(
      address: address,
      publicKey: publicKey,
    ),
  );
}

class WalletTypeSelectionSheet extends StatelessWidget {
  const WalletTypeSelectionSheet({
    required this.address,
    required this.publicKey,
    super.key,
  });

  final Address address;
  final PublicKey publicKey;

  @override
  Widget build(BuildContext context) {
    final theme = context.themeStyleV2;

    return Column(
      mainAxisSize: MainAxisSize.min,
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        Text(
          LocaleKeys.selectWalletTypeDescription.tr(),
          style: theme.textStyles.paragraphMedium.copyWith(
            color: theme.colors.content1,
          ),
        ),
        const SizedBox(height: DimensSizeV2.d24),
        _WalletTypeOption(
          title: LocaleKeys.standardWallet.tr(),
          description: LocaleKeys.standardWalletDescription.tr(),
          icon: LucideIcons.wallet,
          onTap: () {
            Navigator.of(context).pop();
            context.compassContinue(
              WalletDeployConfirmRouteData(
                address: address,
                publicKey: publicKey,
                deployType: WalletDeployType.standard,
              ),
            );
          },
          theme: theme,
        ),
        const SizedBox(height: DimensSizeV2.d12),
        _WalletTypeOption(
          title: LocaleKeys.multisigWallet.tr(),
          description: LocaleKeys.multisigWalletDescription.tr(),
          icon: LucideIcons.users,
          onTap: () {
            Navigator.of(context).pop();
            // Navigate to multisig configuration
            context.compassContinue(
              WalletMultisigConfigRouteData(
                address: address,
                publicKey: publicKey,
              ),
            );
          },
          theme: theme,
        ),
      ],
    );
  }
}

class _WalletTypeOption extends StatelessWidget {
  const _WalletTypeOption({
    required this.title,
    required this.description,
    required this.icon,
    required this.onTap,
    required this.theme,
  });

  final String title;
  final String description;
  final IconData icon;
  final VoidCallback onTap;
  final ThemeStyleV2 theme;

  @override
  Widget build(BuildContext context) {
    return Material(
      color: theme.colors.background2,
      borderRadius: BorderRadius.circular(DimensRadiusV2.radius16),
      child: InkWell(
        onTap: onTap,
        borderRadius: BorderRadius.circular(DimensRadiusV2.radius16),
        child: Container(
          padding: const EdgeInsets.all(DimensSizeV2.d20),
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(DimensRadiusV2.radius16),
          ),
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Container(
                width: DimensSizeV2.d40,
                height: DimensSizeV2.d40,
                decoration: BoxDecoration(
                  color: theme.colors.background1,
                  borderRadius: BorderRadius.circular(DimensRadiusV2.radius12),
                ),
                child: Icon(
                  icon,
                  color: theme.colors.content0,
                  size: DimensSizeV2.d20,
                ),
              ),
              const SizedBox(width: DimensSizeV2.d16),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      title,
                      style: theme.textStyles.headingSmall.copyWith(
                        color: theme.colors.content0,
                      ),
                    ),
                    const SizedBox(height: DimensSizeV2.d8),
                    Text(
                      description,
                      style: theme.textStyles.paragraphSmall.copyWith(
                        color: theme.colors.content2,
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
