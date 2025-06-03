# Working with Translations

This document explains how to handle internationalization and localization in the SparX Wallet Flutter project.

## Overview

This project relies on [flutter_localizations](https://api.flutter.dev/flutter/flutter_localizations/flutter_localizations-library.html) and follows the [official internationalization guide for Flutter](https://flutter.dev/docs/development/accessibility-and-localization/internationalization). However, we use [easy_localization](https://pub.dev/packages/easy_localization) package to simplify the internationalization process.

## Generating Localization Files

To generate localization files for all packages, run:

```sh
melos run codegen:locale
```

## Adding New Strings

1. To add a new localizable string, open the `en.json` file at `assets/translations/en.json`.

```json
{
    "confirm": "Confirm"
}
```

2. Then add a new key/value:

```json
{
    "confirm": "Confirm",
    "continueWord": "Continue"
}
```

3. Use the new string in your Dart code:

```dart
import 'package:app/generated/generated.dart';

@override
Widget build(BuildContext context) {
  return Text(LocaleKeys.continueWord.tr());
}
```

## Adding Supported Locales

### iOS Configuration

Update the `CFBundleLocalizations` array in the `Info.plist` at `ios/Runner/Info.plist` to include the new locale:

```xml
<key>CFBundleLocalizations</key>
<array>
    <string>en</string>
    <string>es</string>
</array>
```

### Android Configuration

Android configuration is automatically handled by the Flutter framework. No additional steps are required.

## Adding New Translations

1. For each supported locale, add a new JSON file in `assets/translations`:

```
├── assets
│   ├── translations
│   │   ├── en.json
│   │   └── es.json
```

2. Add the translated strings to each JSON file:

For example, `es.json`:

```json
{
    "confirm": "Confirmar",
    "continueWord": "Continuar"
}
```

3. Provide a flag icon asset for the language selector:

Add a new vector icon to `assets/images/lang_icons/spanish.svg`.

4. Add the locale to `SupportedLocaleCodes` enum in `lib/app/service/localization/service/supported_locale_codes.dart`:

```dart
enum SupportedLocaleCodes {
    en(LocaleKeys.langEnglish),
    es(LocaleKeys.langSpanish),
    // other languages...
}
```

5. Provide a flag icon asset path in the `SupportedLocaleCodes` extension:

```dart
extension SupportedLocaleCodesExt on SupportedLocaleCodes {
  String get iconPath => switch (this) {
        SupportedLocaleCodes.en => Assets.images.langIcons.english.path,
        SupportedLocaleCodes.es => Assets.images.langIcons.spanish.path,
        // other languages...
      };
}
```

## Testing Localization

When implementing new features, ensure all user-facing strings are properly localized. You can test different localizations by changing the language in the app settings or by using the appropriate Flutter testing tools.

## Localization Best Practices

1. **Don't Hardcode Strings**: Always use the localization system for any user-facing text
2. **Use Descriptive Keys**: Create logical, structured keys (e.g., `auth.login.button` instead of `login_btn`)
3. **Include Context Comments**: When necessary, include context information for translators
4. **Test with Different Languages**: Ensure UI adapts well to languages with different text lengths
5. **Handle Plurals Properly**: Use the appropriate plural forms for different languages
6. **Consider Right-to-Left Languages**: Ensure your UI works well with RTL languages if supported

## Troubleshooting

- If localized strings are not showing up, ensure you have run `melos run codegen:locale`
- For missing keys, check that they exist in all language JSON files
- For UI layout issues with translations, consider using more flexible layouts to accommodate different text lengths

