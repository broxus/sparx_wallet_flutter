import 'package:app/core/wm/custom_wm.dart';
import 'package:app/feature/localization/localization.dart';
import 'package:flutter/widgets.dart';
import 'package:injectable/injectable.dart';
import 'package:ui_components_lib/ui_components_lib.dart';

@injectable
class LocalizationSheetWidgetModel
    extends CustomWidgetModel<LocalizationSheet, LocalizationSheetModel> {
  LocalizationSheetWidgetModel(super.model);

  late final ValueNotifier<SupportedLocaleCodes> currentLocale =
      createValueNotifierFromStream<SupportedLocaleCodes>(
        model.localeCode,
        model.localeCodeStream,
      );

  void onPressedLocale(SupportedLocaleCodes code) {
    model.setLocaleCode(code);
    Navigator.of(context).pop();
  }

  ThemeStyle get themeStyle => context.themeStyle;
}
