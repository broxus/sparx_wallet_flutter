import 'dart:ui';

import 'package:app/generated/generated.dart';

enum SupportedLocaleCodes {
  en(LocaleKeys.langEnglish),
  es(LocaleKeys.langSpanish),
  pt(LocaleKeys.langPortuguese),
  ru(LocaleKeys.langRussian),
  tr(LocaleKeys.langTurkish),
  vi(LocaleKeys.langVietnamese),
  id(LocaleKeys.langIndonesian),
  fr(LocaleKeys.langFrench),
  de(LocaleKeys.langGerman),
  ja(LocaleKeys.langJapanese),
  ko(LocaleKeys.langKorean),
  zh(LocaleKeys.langChinese);

  const SupportedLocaleCodes(this.localizedString);

  final String localizedString;

  String get iconPath => switch (this) {
    SupportedLocaleCodes.en => Assets.images.langIcons.english.path,
    SupportedLocaleCodes.es => Assets.images.langIcons.spanish.path,
    SupportedLocaleCodes.pt => Assets.images.langIcons.portuguese.path,
    SupportedLocaleCodes.ru => Assets.images.langIcons.russian.path,
    SupportedLocaleCodes.tr => Assets.images.langIcons.turkish.path,
    SupportedLocaleCodes.vi => Assets.images.langIcons.vietnamese.path,
    SupportedLocaleCodes.id => Assets.images.langIcons.indonesian.path,
    SupportedLocaleCodes.fr => Assets.images.langIcons.french.path,
    SupportedLocaleCodes.de => Assets.images.langIcons.german.path,
    SupportedLocaleCodes.ja => Assets.images.langIcons.japanese.path,
    SupportedLocaleCodes.ko => Assets.images.langIcons.korean.path,
    SupportedLocaleCodes.zh => Assets.images.langIcons.chinese.path,
  };

  Locale get locale => Locale(name);

  static SupportedLocaleCodes byName(String name) {
    for (final value in SupportedLocaleCodes.values) {
      if (value.name == name) return value;
    }

    return fallbackLocaleCode;
  }
}

const fallbackLocaleCode = SupportedLocaleCodes.en;

final supportedLocales = SupportedLocaleCodes.values
    .map((locale) => locale.locale)
    .toList();
final fallbackLocale = Locale(fallbackLocaleCode.name);
