import 'package:app/generated/generated.dart';
import 'package:flutter/cupertino.dart';
import 'package:ui_components_lib/ui_components_lib.dart';
import 'package:ui_components_lib/v2/ui_components_lib_v2.dart';

Future<bool?> showBrowserClearTabsSheet({required BuildContext context}) {
  final theme = context.themeStyleV2;

  return showCommonBottomSheet<bool?>(
    context: context,
    body: (BuildContext context, __) => Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        const SizedBox(height: DimensSizeV2.d24),
        Assets.images.exclamationMarkAlert.image(
          width: DimensSizeV2.d56,
          height: DimensSizeV2.d56,
        ),
        const SizedBox(height: DimensSizeV2.d16),
        Text(
          LocaleKeys.browserCloseAllTabsDescription.tr(),
          style: theme.textStyles.headingLarge,
          textAlign: TextAlign.center,
        ),
        const SizedBox(height: DimensSizeV2.d24),
        DestructiveButton(
          buttonShape: ButtonShape.pill,
          title: LocaleKeys.clearAll.tr(),
          onPressed: () {
            Navigator.of(context).pop(true);
          },
        ),
        const SizedBox(height: DimensSizeV2.d8),
        PrimaryButton(
          buttonShape: ButtonShape.pill,
          title: LocaleKeys.backWord.tr(),
          onPressed: () {
            Navigator.of(context).pop(false);
          },
        ),
      ],
    ),
  );
}
