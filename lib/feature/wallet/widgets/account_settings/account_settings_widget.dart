import 'package:app/core/wm/custom_wm.dart';
import 'package:app/feature/wallet/widgets/account_settings/account_settings_wm.dart';
import 'package:app/feature/wallet/widgets/account_settings/info_card.dart';
import 'package:app/feature/wallet/widgets/account_settings/widgets/account_settings_button.dart';
import 'package:app/feature/wallet/widgets/account_settings/widgets/change_color_button/account_settings_change_color_button.dart';
import 'package:app/generated/generated.dart';
import 'package:elementary_helper/elementary_helper.dart';
import 'package:flutter/material.dart';
import 'package:lucide_icons_flutter/lucide_icons.dart';
import 'package:nekoton_repository/nekoton_repository.dart';
import 'package:ui_components_lib/ui_components_lib.dart';
import 'package:ui_components_lib/v2/ui_components_lib_v2.dart';

class AccountSettingsWidget extends InjectedElementaryParametrizedWidget<
    AccountSettingsWidgetModel, AccountSettingsWmParams> {
  AccountSettingsWidget({
    required KeyAccount account,
    required this.scrollController,
    required List<PublicKey>? custodians,
    super.key,
  }) : super(
          wmFactoryParam: AccountSettingsWmParams(
            account: account,
            custodians: custodians,
          ),
        );

  final ScrollController scrollController;

  @override
  Widget build(AccountSettingsWidgetModel wm) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        ValueListenableBuilder(
          valueListenable: wm.accountState,
          builder: (_, account, __) {
            return AccountSettingsInfoCard(account: account);
          },
        ),
        const SizedBox(height: DimensSizeV2.d16),
        MultiListenerRebuilder(
          listenableList: [
            wm.displayAccounts,
            wm.accountState,
            wm.custodiansState,
          ],
          builder: (_) {
            final displayList = wm.displayAccounts.value;
            final acc = wm.accountState.value;
            final custodians = wm.custodiansState.value;

            return _ButtonsCard(
              address: acc.address.address,
              custodians: custodians,
              onCustodiansSettings: () =>
                  wm.onCustodiansSettings(custodians ?? []),
              onViewInExplorer: wm.onViewInExplorer,
              onRename: wm.onRename,
              onVerify: wm.onVerify,
              onHideAccount:
                  (displayList?.length ?? 0) > 1 ? wm.onHideAccount : null,
            );
          },
        ),
      ],
    );
  }
}

class _ButtonsCard extends StatelessWidget {
  const _ButtonsCard({
    required this.address,
    required this.custodians,
    required this.onCustodiansSettings,
    required this.onViewInExplorer,
    required this.onRename,
    required this.onVerify,
    required this.onHideAccount,
  });

  final String address;
  final List<PublicKey>? custodians;
  final VoidCallback onCustodiansSettings;
  final VoidCallback onViewInExplorer;
  final VoidCallback onRename;
  final VoidCallback onVerify;
  final VoidCallback? onHideAccount;

  @override
  Widget build(BuildContext context) {
    final theme = context.themeStyleV2;

    return PrimaryCard(
      color: theme.colors.background2,
      borderRadius: BorderRadius.circular(DimensRadiusV2.radius16),
      padding: EdgeInsets.zero,
      child: SeparatedColumn(
        mainAxisSize: MainAxisSize.min,
        separator: Divider(
          height: DimensStroke.small,
          thickness: DimensStroke.small,
          color: theme.colors.borderAlpha,
        ),
        children: [
          if ((custodians?.length ?? 0) > 1)
            AccountSettingsButton(
              label: LocaleKeys.custodiansWord.tr(),
              icon: LucideIcons.userRound,
              onTap: onCustodiansSettings,
            ),
          AccountSettingsButton(
            label: LocaleKeys.changeAccountName.tr(),
            icon: LucideIcons.pencilLine,
            onTap: onRename,
          ),
          AccountSettingsButton(
            label: LocaleKeys.verifyOnLedger.tr(),
            iconWidget: Assets.images.ledger.svg(
              width: DimensSizeV2.d20,
              height: DimensSizeV2.d20,
            ),
            onTap: onVerify,
          ),
          AccountSettingsChangeColorButton(
            address: address,
          ),
          AccountSettingsButton(
            label: LocaleKeys.seeInExplorer.tr(),
            icon: LucideIcons.globe,
            onTap: onViewInExplorer,
          ),
          if (onHideAccount != null)
            AccountSettingsButton(
              label: LocaleKeys.hideAccount.tr(),
              icon: LucideIcons.eyeOff,
              color: theme.colors.contentNegative,
              onTap: onHideAccount!,
            ),
        ],
      ),
    );
  }
}
