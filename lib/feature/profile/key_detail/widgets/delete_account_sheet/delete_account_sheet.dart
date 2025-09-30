import 'package:app/core/wm/custom_wm.dart';
import 'package:app/di/di.dart';
import 'package:app/feature/profile/key_detail/widgets/delete_account_sheet/delete_account_sheet_wm.dart';
import 'package:app/generated/generated.dart';
import 'package:elementary_helper/elementary_helper.dart';
import 'package:flutter/material.dart';
import 'package:nekoton_repository/nekoton_repository.dart';
import 'package:ui_components_lib/ui_components_lib.dart';
import 'package:ui_components_lib/v2/ui_components_lib_v2.dart';

/// Helper method that shows the [DeleteAccountSheet] bottom sheet.
ModalRoute<void> deleteAccountSheetRoute(
  BuildContext context,
  KeyAccount account,
) {
  final name = inject<NekotonRepository>()
      .currentTransport
      .defaultAccountName(account.account.tonWallet.contract);

  return commonBottomSheetRoute<void>(
    titleTextStyle: context.themeStyleV2.textStyles.headingLarge,
    title: LocaleKeys.deleteAccountWithName.tr(args: [name.toUpperCase()]),
    subtitle: LocaleKeys.deleteAccountDescription.tr(),
    body: (_, __) => DeleteAccountSheet(account: account),
  );
}

/// Widget that allows to delete account.
class DeleteAccountSheet extends InjectedElementaryParametrizedWidget<
    DeleteAccountSheetWidgetModel, KeyAccount> {
  const DeleteAccountSheet({
    required KeyAccount account,
    super.key,
  }) : super(wmFactoryParam: account);

  @override
  Widget build(DeleteAccountSheetWidgetModel wm) {
    return Builder(
      builder: (context) {
        final colors = context.themeStyleV2.colors;

        return SeparatedColumn(
          mainAxisSize: MainAxisSize.min,
          children: [
            ShapedContainerColumn(
              margin: EdgeInsets.zero,
              color: colors.background2,
              mainAxisSize: MainAxisSize.min,
              separator: const CommonDivider(),
              children: [
                StateNotifierBuilder(
                  listenableState: wm.balanceState,
                  builder: (context, balance) {
                    if (balance != null) {
                      return CommonListTile(
                        invertTitleSubtitleStyles: true,
                        titleText: LocaleKeys.totalBalance.tr(),
                        subtitleChild: MoneyWidget(
                          money: balance,
                          style: MoneyWidgetStyle.primary,
                        ),
                        padding: EdgeInsets.zero,
                      );
                    }

                    return CommonListTile(
                      titleText: LocaleKeys.totalBalance.tr(),
                      subtitleChild: const CommonLoader(
                        width: DimensSizeV2.d64,
                        height: DimensSizeV2.d24,
                      ),
                      padding: EdgeInsets.zero,
                    );
                  },
                ),
                CommonListTile(
                  height: DimensSizeV2.d80,
                  invertTitleSubtitleStyles: true,
                  subtitleChild: Text(wm.address.address),
                  titleText: LocaleKeys.addressWord.tr(),
                  subtitleText: wm.address.address,
                  padding: EdgeInsets.zero,
                ),
              ],
            ),
            const SizedBox(height: DimensSizeV2.d8),
            DestructiveButton(
              buttonShape: ButtonShape.pill,
              title: LocaleKeys.deleteWord.tr(),
              onPressed: wm.onRemove,
            ),
            PrimaryButton(
              buttonShape: ButtonShape.pill,
              title: LocaleKeys.cancelWord.tr(),
              onPressed: wm.onCancel,
            ),
          ],
        );
      },
    );
  }
}
