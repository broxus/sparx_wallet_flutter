import 'package:app/app/router/router.dart';
import 'package:app/di/di.dart';
import 'package:app/feature/messenger/data/message.dart';
import 'package:app/feature/messenger/domain/service/messenger_service.dart';
import 'package:app/feature/profile/account_detail/route.dart';
import 'package:app/feature/profile/profile.dart';
import 'package:app/generated/generated.dart';
import 'package:app/widgets/user_avatar/user_avatar.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:lucide_icons_flutter/lucide_icons.dart';
import 'package:nekoton_repository/nekoton_repository.dart' hide Message;
import 'package:ui_components_lib/ui_components_lib.dart';
import 'package:ui_components_lib/v2/ui_components_lib_v2.dart';

class KeyDetailView extends StatelessWidget {
  KeyDetailView({
    required this.seedName,
    required this.seedKey,
    required this.tab,
    required this.onTabChanged,
    super.key,
  });

  final String seedName;
  final SeedKey seedKey;
  final KeyDetailAccountsTab tab;
  final void Function(KeyDetailAccountsTab tab) onTabChanged;

  late final accountTabItems = [
    PrimarySegmentControl(
      title: LocaleKeys.myAccounts.tr(),
      value: KeyDetailAccountsTab.local,
      state: SegmentControlState.normal,
      size: SegmentControlSize.small,
    ),
    PrimarySegmentControl(
      state: SegmentControlState.normal,
      title: LocaleKeys.externalAccounts.tr(),
      value: KeyDetailAccountsTab.external,
      size: SegmentControlSize.small,
    ),
  ];

  @override
  Widget build(BuildContext context) {
    final theme = context.themeStyleV2;

    final currentAccounts = tab == KeyDetailAccountsTab.local
        ? seedKey.accountList.localAccounts
        : seedKey.accountList.externalAccounts;

    return SeparatedColumn(
      children: [
        Expanded(
          child: SingleChildScrollView(
            child: SeparatedColumn(
              spacing: DimensSize.d16,
              children: [
                SeparatedColumn(
                  spacing: DimensSize.d4,
                  children: [
                    Text(
                      LocaleKeys.publicKey.tr(),
                      style: theme.textStyles.labelXSmall.copyWith(
                        color: theme.colors.content3,
                      ),
                    ),
                    Text(
                      seedKey.name,
                      style: theme.textStyles.headingLarge,
                    ),
                  ],
                ),
                ShapedContainerColumn(
                  spacing: 0,
                  color: theme.colors.background1,
                  children: [
                    Padding(
                      padding: const EdgeInsets.symmetric(
                        vertical: DimensSizeV2.d16,
                      ),
                      child: _headerItem(
                        title: LocaleKeys.currentSeed.tr(),
                        subtitle: seedName,
                      ),
                    ),
                    const CommonDivider(),
                    Padding(
                      padding: const EdgeInsets.symmetric(
                        vertical: DimensSizeV2.d16,
                      ),
                      child: _headerItem(
                        title: LocaleKeys.publicKey.tr(),
                        subtitle: seedKey.publicKey.publicKey,
                        isPrimary: false,
                        action: CommonIconButton.svg(
                          svg: Assets.images.copy.path,
                          buttonType: EverButtonType.ghost,
                          size: CommonIconButtonSize.xsmall,
                          color: theme.colors.content3,
                          onPressed: () {
                            Clipboard.setData(
                              ClipboardData(text: seedKey.publicKey.publicKey),
                            );
                            inject<MessengerService>().show(
                              Message.successful(
                                message: LocaleKeys.valueCopiedExclamation.tr(
                                  args: [seedKey.publicKey.toEllipseString()],
                                ),
                              ),
                            );
                          },
                        ),
                      ),
                    ),
                  ],
                ),
                ShapedContainerColumn(
                  color: theme.colors.background1,
                  mainAxisSize: MainAxisSize.min,
                  spacing: DimensSize.d16,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    SwitcherSegmentControls(
                      onTabChanged: onTabChanged,
                      values: accountTabItems,
                      currentValue: tab,
                    ),
                    if (currentAccounts.isEmpty)
                      Text(
                        LocaleKeys.noAccountsYet.tr(),
                        style: theme.textStyles.labelXSmall
                            .copyWith(color: theme.colors.content3),
                      )
                    else
                      SeparatedColumn(
                        separator: const Padding(
                          padding: EdgeInsets.symmetric(
                            vertical: DimensSize.d16,
                          ),
                          child: CommonDivider(),
                        ),
                        children: currentAccounts.map(_accountItem).toList(),
                      ),
                  ],
                ),
              ],
            ),
          ),
        ),
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: DimensSize.d16),
          child: PrimaryButton(
            buttonShape: ButtonShape.pill,
            postfixIcon: LucideIcons.plus,
            title: tab == KeyDetailAccountsTab.external
                ? LocaleKeys.addExistingAccount.tr()
                : LocaleKeys.addNewAccount.tr(),
            onPressed: () {
              switch (tab) {
                case KeyDetailAccountsTab.local:
                  showAddNewLocalAccountSheet(
                    context: context,
                    publicKey: seedKey.publicKey,
                  );
                case KeyDetailAccountsTab.external:
                  showAddNewExternalAccountSheet(
                    context: context,
                    publicKey: seedKey.publicKey,
                  );
              }
            },
          ),
        ),
      ],
    );
  }

  Widget _headerItem({
    required String title,
    required String subtitle,
    bool isPrimary = true,
    Widget? action,
  }) {
    return Builder(
      builder: (context) {
        final theme = context.themeStyleV2;

        return SeparatedColumn(
          spacing: DimensSize.d4,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            CommonListTile(
              height: null,
              titleChild: Text(
                title,
                style: theme.textStyles.labelXSmall
                    .copyWith(color: theme.colors.content3),
              ),
              subtitleChild: Text(
                subtitle,
                style: isPrimary
                    ? theme.textStyles.labelMedium
                    : theme.textStyles.labelSmall,
              ),
              trailing: action,
              backgroundColor: Colors.transparent,
            ),
          ],
        );
      },
    );
  }

  Widget _accountItem(KeyAccount account) {
    return Builder(
      builder: (context) {
        final colors = context.themeStyleV2.colors;

        return CommonListTile(
          padding: EdgeInsets.zero,
          onPressed: () {
            context.compassContinue(
              AccountDetailRouteData(address: account.address),
            );
          },
          leading: UserAvatar(
            address: account.account.address.address,
            key: UniqueKey(),
          ),
          titleText: account.name,
          subtitleText: account.address.toEllipseString(),
          trailing: SeparatedRow(
            spacing: DimensSize.d4,
            mainAxisSize: MainAxisSize.min,
            children: [
              if (account.isHidden)
                CommonIconWidget.svg(
                  svg: Assets.images.closedEye.path,
                  color: colors.content0,
                ),
              CommonIconButton.svg(
                svg: Assets.images.settings.path,
                buttonType: EverButtonType.ghost,
                color: colors.content0,
                size: CommonIconButtonSize.xsmall,
                onPressed: () => showAccountSettingsSheet(
                  context: context,
                  address: account.address,
                ),
              ),
            ],
          ),
        );
      },
    );
  }
}
