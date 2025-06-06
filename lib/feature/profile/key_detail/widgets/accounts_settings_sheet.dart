import 'package:app/di/di.dart';
import 'package:app/feature/browser_v1/browser.dart';
import 'package:app/feature/messenger/data/message.dart';
import 'package:app/feature/messenger/domain/service/messenger_service.dart';
import 'package:app/feature/profile/profile.dart';
import 'package:app/generated/generated.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
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
    ),
  );
}

/// Sheet that displays settings of account
class AccountSettingsSheet extends StatelessWidget {
  const AccountSettingsSheet({
    required this.address,
    required this.showHiding,
    required this.seeInExplorer,
    required this.showCopyAddress,
    super.key,
  });

  /// Address of account to show settings for.
  final Address address;

  /// Flag if hide/show item should be shown.
  final bool showHiding;

  /// Flag to open browser and explore account.
  final bool seeInExplorer;

  /// Flag to copy address to clipboard
  final bool showCopyAddress;

  @override
  Widget build(BuildContext context) {
    final account =
        inject<NekotonRepository>().seedList.findAccountByAddress(address);

    final colors = context.themeStyleV2.colors;

    return ShapedContainerColumn(
      color: colors.background2,
      mainAxisSize: MainAxisSize.min,
      separator: const CommonDivider(),
      margin: EdgeInsets.zero,
      children: account == null
          ? const []
          : [
              if (showHiding)
                CommonListTile(
                  titleText: account.isHidden
                      ? LocaleKeys.showWord.tr()
                      : LocaleKeys.hideWord.tr(),
                  onPressed: () {
                    Navigator.of(context).pop();
                    if (account.isHidden) {
                      account.show();
                    } else {
                      account.hide();
                    }
                  },
                  contentColor: colors.content0,
                  trailing: CommonButtonIconWidget.svg(
                    svg: account.isHidden
                        ? Assets.images.openedEye.path
                        : Assets.images.closedEye.path,
                  ),
                ),
              CommonListTile(
                titleText: LocaleKeys.renameWord.tr(),
                onPressed: () {
                  Navigator.of(context)
                    ..pop()
                    ..push(getRenameAccountSheet(context, address));
                },
                contentColor: colors.content0,
                trailing: CommonButtonIconWidget.svg(
                  svg: Assets.images.edit.path,
                ),
              ),
              if (showCopyAddress)
                CommonListTile(
                  titleText: LocaleKeys.copyAddress.tr(),
                  onPressed: () {
                    Clipboard.setData(
                      ClipboardData(text: account.address.address),
                    );
                    inject<MessengerService>().show(
                      Message.successful(
                        message: LocaleKeys.valueCopiedExclamation.tr(
                          args: [account.address.toEllipseString()],
                        ),
                      ),
                    );
                  },
                  contentColor: colors.content0,
                  trailing: CommonButtonIconWidget.svg(
                    svg: Assets.images.copy.path,
                  ),
                ),
              if (seeInExplorer)
                CommonListTile(
                  titleText: LocaleKeys.seeInExplorer.tr(),
                  onPressed: () {
                    Navigator.of(context).pop();
                    openBrowserUrl(
                      inject<NekotonRepository>()
                          .currentTransport
                          .accountExplorerLink(account.address),
                    );
                  },
                  contentColor: colors.content0,
                  trailing: CommonButtonIconWidget.svg(
                    svg: Assets.images.planetInner.path,
                  ),
                ),
              CommonListTile(
                titleText: LocaleKeys.deleteWord.tr(),
                contentColor: colors.contentNegative,
                onPressed: () {
                  Navigator.of(context)
                    ..pop()
                    ..push(deleteAccountSheetRoute(context, account));
                },
                trailing: CommonButtonIconWidget.svg(
                  svg: Assets.images.trash.path,
                ),
              ),
            ],
    );
  }
}
