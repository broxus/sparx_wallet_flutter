import 'package:app/core/wm/custom_wm.dart';
import 'package:app/feature/wallet/widgets/wallet_app_bar/wallet_app_bar_wm.dart';
import 'package:app/utils/utils.dart';
import 'package:app/widgets/network_drop_item.dart';
import 'package:app/widgets/user_avatar/user_avatar.dart';
import 'package:elementary_helper/elementary_helper.dart';
import 'package:flutter/material.dart';
import 'package:lucide_icons_flutter/lucide_icons.dart';
import 'package:nekoton_repository/nekoton_repository.dart';
import 'package:ui_components_lib/ui_components_lib.dart';

class WalletAppBarWidget
    extends InjectedElementaryWidget<WalletAppBarWidgetModel>
    implements PreferredSizeWidget {
  const WalletAppBarWidget({
    super.key,
  });

  @override
  Size get preferredSize => const Size.fromHeight(DimensSizeV2.d68);

  @override
  Widget build(WalletAppBarWidgetModel wm) {
    return Padding(
      padding: const EdgeInsets.symmetric(
        vertical: DimensSizeV2.d12,
        horizontal: DimensSizeV2.d16,
      ),
      child: SeparatedRow(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Flexible(
            child: DoubleSourceBuilder(
              firstSource: wm.currentAccountState,
              secondSource: wm.walletState,
              builder: (_, account, walletState) =>
                  account?.let(
                    (value) => _AccountInfo(
                      account: value,
                      walletState: walletState,
                      walletTypeName: wm.getWalletTypeName(
                        account.account.tonWallet.contract,
                      ),
                      onTap: wm.onSelectAccount,
                    ),
                  ) ??
                  const SizedBox.shrink(),
            ),
          ),
          Row(
            spacing: DimensSizeV2.d12,
            children: [
              _QrButton(onTap: wm.onScanQr),
              StateNotifierBuilder(
                listenableState: wm.connectionState,
                builder: (_, connection) =>
                    connection?.let(
                      (value) => GestureDetector(
                        onTap: wm.onNetwork,
                        child: NetworkDropItem(data: value),
                      ),
                    ) ??
                    const SizedBox.shrink(),
              ),
            ],
          ),
        ],
      ),
    );
  }
}

class _QrButton extends StatelessWidget {
  const _QrButton({
    required this.onTap,
  });

  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    final theme = context.themeStyleV2;

    return GestureDetector(
      onTap: onTap,
      child: Container(
        padding: const EdgeInsets.all(DimensSizeV2.d8),
        decoration: BoxDecoration(
          color: theme.colors.backgroundAlpha,
          borderRadius: BorderRadius.circular(DimensRadiusV2.theBiggest),
        ),
        child: const Icon(
          LucideIcons.scan,
          size: DimensSizeV2.d20,
        ),
      ),
    );
  }
}

class _AccountInfo extends StatelessWidget {
  const _AccountInfo({
    required this.account,
    required this.walletState,
    required this.walletTypeName,
    required this.onTap,
  });

  final KeyAccount account;
  final TonWalletState? walletState;
  final String walletTypeName;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    final theme = context.themeStyleV2;
    final custodians = walletState?.wallet?.custodians?.length ?? 1;
    final requiredConfirmations =
        walletState?.wallet?.details.requiredConfirmations;

    return GestureDetector(
      onTap: onTap,
      child: SeparatedRow(
        children: [
          UserAvatar(
            address: account.address.address,
          ),
          Flexible(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                SeparatedRow(
                  spacing: DimensSizeV2.d2,
                  children: [
                    Text(
                      account.name,
                      style: theme.textStyles.headingXSmall,
                      overflow: TextOverflow.ellipsis,
                      softWrap: false,
                      maxLines: 1,
                    ),
                    const Icon(LucideIcons.chevronDown),
                  ],
                ),
                Row(
                  children: [
                    Icon(
                      custodians > 1
                          ? LucideIcons.usersRound
                          : LucideIcons.userRound,
                      size: DimensSizeV2.d16,
                      color: theme.colors.content3,
                    ),
                    const SizedBox(width: DimensSizeV2.d4),
                    Flexible(
                      child: Text(
                        walletTypeName,
                        style: theme.textStyles.labelXSmall.copyWith(
                          color: theme.colors.content3,
                        ),
                        overflow: TextOverflow.ellipsis,
                        softWrap: false,
                        maxLines: 1,
                      ),
                    ),
                    const SizedBox(width: DimensSizeV2.d8),
                    if (requiredConfirmations != null && custodians > 1)
                      SeparatedRow(
                        spacing: DimensSizeV2.d4,
                        children: [
                          Icon(
                            LucideIcons.usersRound,
                            size: DimensSizeV2.d16,
                            color: theme.colors.content3,
                          ),
                          Text(
                            '$requiredConfirmations/$custodians',
                            style: theme.textStyles.labelXSmall.copyWith(
                              color: theme.colors.content3,
                            ),
                          ),
                        ],
                      ),
                  ],
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
