import 'package:app/generated/locale_keys.g.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:elementary_helper/elementary_helper.dart';
import 'package:flutter/material.dart';
import 'package:lucide_icons_flutter/lucide_icons.dart';
import 'package:ui_components_lib/ui_components_lib.dart';
import 'package:ui_components_lib/v2/ui_components_lib_v2.dart';

class ProfileView extends StatelessWidget {
  const ProfileView({
    required this.appVersion,
    required this.isBiometryAvailable,
    required this.isBiometryEnabled,
    required this.onManageSeeds,
    required this.onExportSeed,
    required this.onContactSupport,
    required this.onFAQ,
    required this.onLegal,
    required this.onLogout,
    required this.onBiomentryChanged,
    required this.onManageDapps,
    this.isDarkThemeEnabled = false,
    super.key,
  });

  final ListenableState<bool> isBiometryAvailable;
  final ListenableState<bool> isBiometryEnabled;
  final String appVersion;
  final bool isDarkThemeEnabled;
  final VoidCallback onManageSeeds;
  final VoidCallback onExportSeed;
  final VoidCallback onContactSupport;
  final VoidCallback onFAQ;
  final VoidCallback onLegal;
  final VoidCallback onLogout;
  final VoidCallback onManageDapps;
  final ValueChanged<bool> onBiomentryChanged;

  @override
  Widget build(BuildContext context) {
    final theme = context.themeStyleV2;

    return Scaffold(
      backgroundColor: theme.colors.background1,
      body: SafeArea(
        child: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: DimensSizeV2.d16),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                Padding(
                  padding: const EdgeInsets.symmetric(
                    vertical: DimensSizeV2.d24,
                  ),
                  child: Text(
                    LocaleKeys.settings.tr(),
                    style: theme.textStyles.headingMedium,
                    textAlign: TextAlign.center,
                  ),
                ),
                Column(
                  spacing: DimensSizeV2.d32,
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    _Container(
                      children: [
                        _Item(
                          title: LocaleKeys.manageSeedsAndAccounts.tr(),
                          icon: LucideIcons.keyRound,
                          onPressed: onManageSeeds,
                        ),
                        _Item(
                          title: LocaleKeys.connectedDappsTitle.tr(),
                          subtitle: LocaleKeys.connectedDappsSubtitle.tr(),
                          icon: LucideIcons.plus,
                          onPressed: onManageDapps,
                        ),
                      ],
                    ),
                    StateNotifierBuilder(
                      listenableState: isBiometryAvailable,
                      builder: (_, available) => _Container(
                        children: [
                          _Item(
                            title: LocaleKeys.exportSeedPhrase.tr(),
                            icon: LucideIcons.databaseBackup,
                            onPressed: onExportSeed,
                          ),
                          if (available ?? false)
                            StateNotifierBuilder(
                              listenableState: isBiometryEnabled,
                              builder: (_, enabled) => _Item(
                                title: LocaleKeys.biometryWord.tr(),
                                icon: LucideIcons.fingerprint,
                                trailing: Switch(
                                  value: enabled ?? false,
                                  onChanged: onBiomentryChanged,
                                ),
                              ),
                            ),
                        ],
                      ),
                    ),
                    _Container(
                      children: [
                        _Item(
                          title: LocaleKeys.faq.tr(),
                          icon: LucideIcons.messageCircleQuestion,
                          onPressed: onFAQ,
                        ),
                        _Item(
                          title: LocaleKeys.contactSupport.tr(),
                          icon: LucideIcons.messagesSquare,
                          onPressed: onContactSupport,
                        ),
                        _Item(
                          title: LocaleKeys.legal.tr(),
                          icon: LucideIcons.link,
                          onPressed: onLegal,
                        ),
                      ],
                    ),
                    Column(
                      mainAxisSize: MainAxisSize.min,
                      spacing: DimensSizeV2.d16,
                      children: [
                        DestructiveButton(
                          buttonShape: ButtonShape.pill,
                          title: LocaleKeys.logOut.tr(),
                          icon: LucideIcons.logOut,
                          onPressed: onLogout,
                        ),
                        Text(
                          '${LocaleKeys.versionWord.tr()} $appVersion',
                          textAlign: TextAlign.center,
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
        ),
      ),
    );
  }
}

class _Item extends StatelessWidget {
  const _Item({
    required this.icon,
    required this.title,
    this.subtitle,
    this.trailing,
    this.onPressed,
  });

  final IconData icon;
  final String title;
  final String? subtitle;
  final Widget? trailing;
  final VoidCallback? onPressed;

  @override
  Widget build(BuildContext context) {
    final theme = context.themeStyleV2;

    return CommonListTile(
      padding: EdgeInsets.zero,
      height: DimensSizeV2.d40,
      titleText: title,
      titleTextStyle: theme.textStyles.button,
      subtitleText: subtitle,
      subtitleTextStyle: theme.textStyles.labelXSmall.copyWith(
        color: ColorsRes.grey898989,
      ),
      leading: CommonBackgroundedIconWidget.icon(
        icon: icon,
        iconColor: theme.colors.content0,
        backgroundColor: theme.colors.backgroundAlpha,
      ),
      trailing: trailing ??
          const Icon(
            LucideIcons.chevronRight,
            size: DimensSizeV2.d20,
          ),
      onPressed: onPressed,
    );
  }
}

class _Container extends StatelessWidget {
  const _Container({
    required this.children,
  });

  final List<Widget> children;

  @override
  Widget build(BuildContext context) {
    final theme = context.themeStyleV2;

    return ShapedContainerColumn(
      color: theme.colors.background2,
      separator: const CommonDivider(
        margin: EdgeInsets.symmetric(
          vertical: DimensSizeV2.d16,
        ),
      ),
      padding: const EdgeInsets.all(DimensSizeV2.d16),
      margin: EdgeInsets.zero,
      children: children,
    );
  }
}
