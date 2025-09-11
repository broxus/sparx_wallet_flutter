import 'package:app/core/wm/custom_wm.dart';
import 'package:app/di/di.dart';
import 'package:app/feature/browser_v2/domain/browser_launcher.dart';
import 'package:app/feature/profile/key_detail/widgets/account_settings_sheet/account_settings_sheet_wm.dart';
import 'package:app/generated/generated.dart';
import 'package:flutter/material.dart';
import 'package:nekoton_repository/nekoton_repository.dart' hide Message;
import 'package:ui_components_lib/ui_components_lib.dart';

/// Helper function to show [AccountSettingsSheet].
/// [showHiding] flag if hide/show item should be shown.
/// [seeInExplorer] flag to open browser and explore account.
Future<void> showAccountSettingsSheet({
  required BuildContext context,
  required Address address,
  bool showHiding = true,
  bool seeInExplorer = false,
  bool showCopyAddress = false,
}) {
  return showCommonBottomSheet(
    context: context,
    titleTextStyle: context.themeStyleV2.textStyles.headingLarge,
    title: LocaleKeys.settingsOfAccount.tr(),
    body: (_, __) => AccountSettingsSheet(
      address: address,
      showHiding: showHiding,
      seeInExplorer: seeInExplorer,
      showCopyAddress: showCopyAddress,
      browserLauncher: inject<BrowserLauncher>(),
    ),
  );
}

/// Sheet that displays settings of account
class AccountSettingsSheet extends InjectedElementaryParametrizedWidget<
    AccountSettingsSheetWidgetModel, AccountSettingsSheetParams> {
  AccountSettingsSheet({
    /// Address of account to show settings for.
    required Address address,

    /// Flag if hide/show item should be shown.
    required bool showHiding,

    /// Flag to open browser and explore account.
    required bool seeInExplorer,

    /// Flag to copy address to clipboard
    required bool showCopyAddress,
    required BrowserLauncher browserLauncher,
    super.key,
  }) : super(
          wmFactoryParam: AccountSettingsSheetParams(
            address: address,
            showHiding: showHiding,
            seeInExplorer: seeInExplorer,
            showCopyAddress: showCopyAddress,
            browserLauncher: browserLauncher,
          ),
        );

  @override
  Widget build(AccountSettingsSheetWidgetModel wm) {
    return ShapedContainerColumn(
      color: wm.colors.background2,
      mainAxisSize: MainAxisSize.min,
      separator: const CommonDivider(),
      margin: EdgeInsets.zero,
      children: wm.account == null
          ? const []
          : [
              if (wm.isShowHiding)
                CommonListTile(
                  titleText: wm.account!.isHidden
                      ? LocaleKeys.showWord.tr()
                      : LocaleKeys.hideWord.tr(),
                  onPressed: wm.onPressedToggleVisibleWord,
                  contentColor: wm.colors.content0,
                  trailing: CommonButtonIconWidget.svg(
                    svg: wm.account!.isHidden
                        ? Assets.images.openedEye.path
                        : Assets.images.closedEye.path,
                  ),
                ),
              CommonListTile(
                titleText: LocaleKeys.renameWord.tr(),
                onPressed: wm.onPressedRename,
                contentColor: wm.colors.content0,
                trailing: CommonButtonIconWidget.svg(
                  svg: Assets.images.edit.path,
                ),
              ),
              if (wm.isShowCopyAddress)
                CommonListTile(
                  titleText: LocaleKeys.copyAddress.tr(),
                  onPressed: wm.onPressedCopyAddress,
                  contentColor: wm.colors.content0,
                  trailing: CommonButtonIconWidget.svg(
                    svg: Assets.images.copy.path,
                  ),
                ),
              if (wm.isSeeInExplorer)
                CommonListTile(
                  titleText: LocaleKeys.seeInExplorer.tr(),
                  onPressed: wm.onPressedSeeInExplorer,
                  contentColor: wm.colors.content0,
                  trailing: CommonButtonIconWidget.svg(
                    svg: Assets.images.planetInner.path,
                  ),
                ),
              CommonListTile(
                titleText: LocaleKeys.deleteWord.tr(),
                contentColor: wm.colors.contentNegative,
                onPressed: wm.onPressedDeleteWord,
                trailing: CommonButtonIconWidget.svg(
                  svg: Assets.images.trash.path,
                ),
              ),
            ],
    );
  }
}
