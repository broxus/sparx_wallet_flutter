import 'package:app/core/wm/custom_wm.dart';
import 'package:app/feature/profile/profile.dart';
import 'package:app/generated/generated.dart';
import 'package:flutter/material.dart';
import 'package:lucide_icons_flutter/lucide_icons.dart';
import 'package:nekoton_repository/nekoton_repository.dart' show PublicKey;
import 'package:ui_components_lib/ui_components_lib.dart';

class SeedSettingsWidget
    extends InjectedElementaryWidget<SeedSettingsWidgetModel>
    with WidgetsBindingObserver {
  const SeedSettingsWidget({
    required PublicKey publicKey,
    super.key,
  }) : super(
          wmFactoryParam: publicKey,
        );

  @override
  Widget build(SeedSettingsWidgetModel wm) {
    final colors = wm.theme.colors;

    return ShapedContainerColumn(
      color: colors.background2,
      margin: EdgeInsets.zero,
      mainAxisSize: MainAxisSize.min,
      separator: const CommonDivider(),
      children: [
        if (wm.publicKey != wm.currentKey)
          CommonListTile(
            titleText: LocaleKeys.useThisSeed.tr(),
            trailing: CommonIconWidget.svg(
              svg: Assets.images.checkSquare.path,
              color: colors.content0,
            ),
            onPressed: wm.onChangeCurrentKey,
          ),
        CommonListTile(
          titleText: LocaleKeys.renameWord.tr(),
          trailing: CommonIconWidget.svg(
            svg: Assets.images.edit.path,
            color: colors.content0,
          ),
          onPressed: wm.onRename,
        ),
        CommonListTile(
          titleText: LocaleKeys.exportWord.tr(),
          trailing: CommonIconWidget.svg(
            svg: Assets.images.exportFill.path,
            color: colors.content0,
          ),
          onPressed: wm.onExport,
        ),
        CommonListTile(
          titleText: LocaleKeys.scanSeed.tr(),
          trailing: Icon(
            LucideIcons.searchCheck,
            size: DimensSizeV2.d20,
            color: colors.content0,
          ),
          onPressed: wm.onScan,
        ),
        CommonListTile(
          titleText: LocaleKeys.changePassword.tr(),
          trailing: CommonIconWidget.svg(
            svg: Assets.images.lock.path,
            color: colors.content0,
          ),
          onPressed: wm.onChangePassword,
        ),
        if (wm.publicKey != wm.currentKey)
          CommonListTile(
            contentColor: colors.contentNegative,
            titleText: LocaleKeys.deleteWord.tr(),
            trailing: CommonIconWidget.svg(svg: Assets.images.trash.path),
            onPressed: wm.onDelete,
          ),
      ],
    );
  }
}
