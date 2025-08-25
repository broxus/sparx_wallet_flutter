import 'package:app/core/wm/custom_wm.dart';
import 'package:app/feature/profile/manage_seeds_accounts/widgets/delete_seed_sheet/delete_seed_sheet_wm.dart';
import 'package:app/generated/generated.dart';
import 'package:flutter/material.dart';
import 'package:nekoton_repository/nekoton_repository.dart';
import 'package:ui_components_lib/ui_components_lib.dart';
import 'package:ui_components_lib/v2/ui_components_lib_v2.dart';

/// Helper method that shows the [DeleteSeedSheet] bottom sheet.
ModalRoute<void> deleteSeedSheetRoute(
  BuildContext context,
  PublicKey publicKey,
) {
  return commonBottomSheetRoute<void>(
    titleTextStyle: context.themeStyleV2.textStyles.headingLarge,
    title: LocaleKeys.deleteSeedPhrase.tr(),
    subtitle: LocaleKeys.deleteSeedPhraseDescription.tr(),
    body: (_, __) => DeleteSeedSheet(publicKey: publicKey),
  );
}

/// Widget that allows to delete seed.
class DeleteSeedSheet extends InjectedElementaryParametrizedWidget<
    DeleteSeedSheetWidgetModel, DeleteSeedSheetParams> {
  DeleteSeedSheet({
    required PublicKey publicKey,
    super.key,
  }) : super(
          wmFactoryParam: DeleteSeedSheetParams(publicKey),
        );

  @override
  Widget build(DeleteSeedSheetWidgetModel wm) {
    return SeparatedColumn(
      children: [
        if (wm.seed != null)
          Expanded(
            child: SingleChildScrollView(
              child: ShapedContainerColumn(
                color: wm.colors.background2,
                margin: EdgeInsets.zero,
                spacing: DimensSize.d16,
                mainAxisSize: MainAxisSize.min,
                children: [
                  _sectionItem(
                    LocaleKeys.seedPhrase.tr(),
                    [
                      CommonListTile(
                        leading: CommonBackgroundedIconWidget.svg(
                          svg: Assets.images.sparxLogoSmall.path,
                        ),
                        titleText: wm.seed!.name,
                        subtitleText: LocaleKeys.publicKeysWithData.plural(
                          wm.seed!.allKeys.length,
                          args: ['${wm.seed!.allKeys.length}'],
                        ),
                        padding: EdgeInsets.zero,
                      ),
                    ],
                  ),
                  _sectionItem(
                    LocaleKeys.keysWord.tr(),
                    [wm.seed!.masterKey, ...wm.seed!.subKeys]
                        .map(
                          (key) => CommonListTile(
                            leading: CommonBackgroundedIconWidget.svg(
                              svg: Assets.images.key.path,
                            ),
                            titleText: key.name,
                            subtitleText: LocaleKeys.accountsWithData.plural(
                              key.accountList.allAccounts.length,
                              args: ['${key.accountList.allAccounts.length}'],
                            ),
                            padding: EdgeInsets.zero,
                          ),
                        )
                        .toList(),
                  ),
                ],
              ),
            ),
          ),
        if (wm.seed != null)
          DestructiveButton(
            buttonShape: ButtonShape.pill,
            title: LocaleKeys.deleteWord.tr(),
            onPressed: wm.onPressedDeleteWord,
          ),
        PrimaryButton(
          buttonShape: ButtonShape.pill,
          title: LocaleKeys.cancelWord.tr(),
          onPressed: wm.onPressedCancelWord,
        ),
      ],
    );
  }

  Widget _sectionItem(String title, List<Widget> keys) {
    return Builder(
      builder: (context) {
        return SeparatedColumn(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.start,
          spacing: DimensSize.d12,
          children: [
            Text(
              title,
              style: StyleRes.h2.copyWith(
                color: context.themeStyle.colors.textPrimary,
              ),
            ),
            ...keys,
          ],
        );
      },
    );
  }
}
