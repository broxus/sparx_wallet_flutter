import 'package:app/generated/generated.dart';
import 'package:flutter/cupertino.dart';
import 'package:ui_components_lib/ui_components_lib.dart';
import 'package:ui_components_lib/v2/ui_components_lib_v2.dart';

Future<bool?> showPermissionsSheet({
  required BuildContext context,
  required String host,
  required Iterable<String> permissions,
}) {
  final theme = context.themeStyleV2;

  return showCommonBottomSheet<bool?>(
    context: context,
    body: (BuildContext context, __) => Column(
      mainAxisSize: MainAxisSize.min,
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        const SizedBox(height: DimensSizeV2.d24),
        RichText(
          textAlign: TextAlign.center,
          text: TextSpan(
            children: [
              TextSpan(
                text: '$host ',
                style: theme.textStyles.headingLarge,
              ),
              TextSpan(
                text: LocaleKeys.browserPermissionsHeader.tr(
                  args: [permissions.join(', ')],
                ),
                style: theme.textStyles.headingLarge.copyWith(
                  color: context.themeStyleV2.colors.content1,
                ),
              ),
            ],
          ),
        ),
        const SizedBox(height: DimensSizeV2.d24),
        PrimaryButton(
          buttonShape: ButtonShape.pill,
          title: LocaleKeys.acceptWord.tr(),
          onPressed: () {
            Navigator.of(context).pop(true);
          },
        ),
        const SizedBox(height: DimensSizeV2.d8),
        DestructiveButton(
          buttonShape: ButtonShape.pill,
          title: LocaleKeys.cancelWord.tr(),
          onPressed: () {
            Navigator.of(context).pop(false);
          },
        ),
      ],
    ),
  );
}
