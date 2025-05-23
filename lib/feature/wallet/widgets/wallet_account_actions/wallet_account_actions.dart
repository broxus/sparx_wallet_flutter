// ignore_for_file: lines_longer_than_80_chars, unused_element

import 'package:app/feature/wallet/wallet.dart';
import 'package:app/feature/wallet/widgets/wallet_account_actions/wallet_account_actions_wm.dart';
import 'package:app/generated/generated.dart';
import 'package:elementary/elementary.dart';
import 'package:elementary_helper/elementary_helper.dart';
import 'package:flutter/material.dart';
import 'package:lucide_icons_flutter/lucide_icons.dart';
import 'package:nekoton_repository/nekoton_repository.dart' hide Message;
import 'package:ui_components_lib/ui_components_lib.dart';

/// Row with actions for current account.
/// If account is null, then no actions available.
class WalletAccountActions
    extends ElementaryWidget<WalletAccountActionsWidgetModel> {
  const WalletAccountActions({
    required this.account,
    this.allowStake = true,
    this.sendSpecified = false,
    this.disableSensetiveActions = false,
    this.padding = const EdgeInsets.symmetric(vertical: DimensSizeV2.d32),
    Key? key,
    WidgetModelFactory wmFactory =
        defaultWalletAccountActionsWidgetModelFactory,
  }) : super(wmFactory, key: key);

  final KeyAccount account;
  final bool allowStake;
  final bool sendSpecified;
  final bool disableSensetiveActions;
  final EdgeInsetsGeometry padding;

  @override
  Widget build(WalletAccountActionsWidgetModel wm) {
    return TripleSourceBuilder(
      firstSource: wm.action,
      secondSource: wm.hasStake,
      thirdSource: wm.hasStakeActions,
      builder: (_, action, hasStake, hasStakeActions) => _ActionList(
        action: action ?? WalletAccountActionBehavior.send,
        hasStake: hasStake ?? false,
        hasStakeActions: hasStakeActions ?? false,
        sendSpecified: sendSpecified,
        padding: padding,
        disableSensetiveActions: disableSensetiveActions,
        onReceivePressed: wm.onReceive,
        onMainActionPressed: wm.onMainAction,
        onStakePressed: wm.onStake,
        onInfoPressed: wm.onInfo,
      ),
    );
  }
}

class _ActionList extends StatelessWidget {
  const _ActionList({
    required this.hasStake,
    required this.hasStakeActions,
    required this.sendSpecified,
    required this.action,
    required this.padding,
    required this.disableSensetiveActions,
    required this.onReceivePressed,
    required this.onInfoPressed,
    required this.onMainActionPressed,
    required this.onStakePressed,
  });

  final WalletAccountActionBehavior action;
  final bool hasStake;
  final bool hasStakeActions;
  final bool sendSpecified;
  final bool disableSensetiveActions;
  final EdgeInsetsGeometry padding;
  final VoidCallback onReceivePressed;
  final VoidCallback onInfoPressed;
  final VoidCallback onMainActionPressed;
  final VoidCallback onStakePressed;

  IconData get _actionIcon => switch (action) {
        WalletAccountActionBehavior.deploy => LucideIcons.settings,
        _ => LucideIcons.arrowUp,
      };

  String get _actionTitle => switch (action) {
        WalletAccountActionBehavior.deploy => LocaleKeys.deployWord.tr(),
        _ => LocaleKeys.sendWord.tr(),
      };

  @override
  Widget build(BuildContext context) {
    final theme = context.themeStyleV2;

    return Padding(
      padding: padding,
      child: SizedBox(
        height: DimensSizeV2.d74,
        child: SeparatedRow(
          separator: VerticalDivider(
            width: DimensStroke.small,
            thickness: DimensStroke.small,
            color: theme.colors.borderAlpha,
          ),
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            WalletActionButton(
              label: LocaleKeys.receiveWord.tr(),
              icon: LucideIcons.arrowDown,
              onPressed: !disableSensetiveActions ? onReceivePressed : null,
            ),
            WalletActionButton(
              label: _actionTitle,
              icon: _actionIcon,
              onPressed:
                  disableSensetiveActions == false ? onMainActionPressed : null,
            ),
            if (hasStake)
              WalletActionButton(
                label: LocaleKeys.stakeWord.tr(),
                icon: LucideIcons.layers2,
                badge: hasStakeActions,
                onPressed:
                    disableSensetiveActions == false ? onStakePressed : null,
              ),
            if (!sendSpecified)
              WalletActionButton(
                label: LocaleKeys.info.tr(),
                icon: LucideIcons.ellipsis,
                onPressed: onInfoPressed,
              ),
          ],
        ),
      ),
    );
  }
}
