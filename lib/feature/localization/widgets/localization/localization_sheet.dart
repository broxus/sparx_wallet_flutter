import 'package:app/core/wm/custom_wm.dart';
import 'package:app/feature/localization/localization.dart';
import 'package:app/generated/generated.dart';
import 'package:flutter/material.dart';
import 'package:ui_components_lib/ui_components_lib.dart';

/// Helper function to show [LocalizationSheet].
Future<void> showLocalizationSheet({required BuildContext context}) {
  return showCommonBottomSheet(
    context: context,
    title: LocaleKeys.chooseLanguage.tr(),
    body: (_, __) => const LocalizationSheet(),
  );
}

class LocalizationSheet
    extends InjectedElementaryWidget<LocalizationSheetWidgetModel> {
  const LocalizationSheet({super.key});

  @override
  Widget build(LocalizationSheetWidgetModel wm) {
    final colors = wm.themeStyle.colors;

    return ValueListenableBuilder<SupportedLocaleCodes>(
      valueListenable: wm.currentLocale,
      builder: (_, currentLocale, __) {
        return SeparatedColumn(
          mainAxisSize: MainAxisSize.min,
          separator: const CommonDivider(),
          children: [
            for (final code in SupportedLocaleCodes.values)
              CommonListTile(
                onPressed: () => wm.onPressedLocale(code),
                leading: CommonBackgroundedIconWidget.svg(
                  svg: code.iconPath,
                  backgroundColor: Colors.transparent,
                  useDefaultColor: false,
                ),
                titleText: code.localizedString.tr(),
                trailing: currentLocale == code
                    ? CommonIconWidget.svg(
                        svg: Assets.images.check.path,
                        color: colors.textPrimary,
                      )
                    : null,
                padding: EdgeInsets.zero,
              ),
          ],
        );
      },
    );
  }
}
