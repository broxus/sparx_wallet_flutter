import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:ui_components_lib/ui_components_lib.dart';

final _colors = ColorsPalette(
  primaryA: ColorsRes.n100,
  primaryB: ColorsRes.n10,
  accent: ColorsRes.p60,
  negative: ColorsRes.e70,
  warning: ColorsRes.w70,
  positive: ColorsRes.s75,
  background0: const Color(0xFF0D0F20),
  background1: ColorsRes.n20,
  background2: ColorsRes.n30,
  background3: ColorsRes.n35,
  backgroundInput: ColorsRes.n95,
  backgroundAccent: ColorsRes.p60,
  backgroundAlpha: ColorsRes.n100.withAlpha(Opac.opac10.toByteInt()),
  backgroundNegativeAlpha: ColorsRes.e30.withAlpha(Opac.opac50.toByteInt()),
  backgroundWarningAlpha: ColorsRes.w40.withAlpha(Opac.opac50.toByteInt()),
  backgroundPositiveAlpha: ColorsRes.s25.withAlpha(Opac.opac50.toByteInt()),
  backgroundButtonAlpha: ColorsRes.n100.withAlpha(Opac.opac16.toByteInt()),
  content0: ColorsRes.n100,
  content1: ColorsRes.n70,
  content2: ColorsRes.n65,
  content3: ColorsRes.n60,
  content4: ColorsRes.n80,
  border0: ColorsRes.n35,
  border1: ColorsRes.n40,
  border2: ColorsRes.n50,
  borderAlpha: ColorsRes.n100.withAlpha(Opac.opac10.toByteInt()),
  borderFocus: ColorsRes.n70.withAlpha(Opac.opac50.toByteInt()),
  borderDisabled: ColorsRes.n70.withAlpha(Opac.opac50.toByteInt()),
  backgroundOverlay: ColorsRes.n10.withAlpha(Opac.opac80.toByteInt()),
  backgroundNegative: ColorsRes.e30,
  backgroundWarning: ColorsRes.w20,
  backgroundPositive: ColorsRes.s25,
  contentNegative: ColorsRes.e70,
  contentNegative1: ColorsRes.e80,
  contentWarning: ColorsRes.w70,
  contentWarning1: ColorsRes.w80,
  contentPositive: ColorsRes.s75,
  contentPositive1: ColorsRes.s65,
  borderNegative: ColorsRes.e40,
  borderWarning: ColorsRes.w65,
  borderPositive: ColorsRes.s40,
  // Legacy colors
  textPrimary: ColorsRes.n100,
  textSecondary: ColorsRes.n60,
  textContrast: const Color(0xFF222222),
  strokePrimary: const Color(0xFFE2E2E2),
  strokeSecondary: const Color(0xFFF3F3F3),
  strokeContrast: const Color(0xFF000000),
  backgroundPrimary: ColorsRes.n100,
  backgroundSecondary: const Color(0xFF303030),
);

/// Default theme for ever app with light brightness
ThemeData getPredefinedLightTheme() => getPredefinedDarkTheme();

/// Default theme for ever app with dark brightness
ThemeData getPredefinedDarkTheme() {
  return ThemeData(
    brightness: Brightness.dark,
    scaffoldBackgroundColor: _colors.background0,
    appBarTheme: const AppBarTheme(
      systemOverlayStyle: SystemUiOverlayStyle(
        systemNavigationBarColor: Colors.transparent,
        systemNavigationBarIconBrightness: Brightness.light,
        statusBarIconBrightness: Brightness.light,
        statusBarBrightness: Brightness.dark,
      ),
    ),
    switchTheme: SwitchThemeData(
      thumbColor: WidgetStatePropertyAll(_colors.primaryA),
      trackColor: WidgetStateProperty.resolveWith((states) {
        if (states.contains(WidgetState.selected)) return _colors.accent;
        return _colors.backgroundAlpha;
      }),
      trackOutlineColor: const WidgetStatePropertyAll(Colors.transparent),
      materialTapTargetSize: MaterialTapTargetSize.shrinkWrap,
    ),
    extensions: [
      ThemeStyle(
        colors: _colors,
        textStyles: TextStyles.defaultTextStyles(_colors),
        legacyStyles: StylesPalette(
          buttonTextStyle: StyleRes.button,
          buttonsStyle: _mapButtonStyle(_colors),
        ),
      ),
    ],
  );
}

ThemeStyle getDefaultTheme() {
  return ThemeStyle(
    colors: _colors,
    textStyles: TextStyles.defaultTextStyles(_colors),
    legacyStyles: StylesPalette(
      buttonTextStyle: StyleRes.button,
      buttonsStyle: _mapButtonStyle(_colors),
    ),
  );
}

// import 'package:ui_components_lib/ui_components_lib.dart';

// ThemeStyle getEverDefaultTheme() {
//   const colors = ColorsPaletteOld(
//     textPrimary: ColorsResOld.white,
//     textSecondary: ColorsResOld.grey898989,
//     textContrast: ColorsResOld.black,
//     appBackground: ColorsResOld.black,
//     backgroundPrimary: ColorsResOld.white,
//     backgroundSecondary: ColorsResOld.black303030,
//     loading: ColorsResOld.grey3C3C3C,
//     strokePrimary: ColorsResOld.black454545,
//     strokeSecondary: ColorsResOld.black3C3C3C,
//     strokeContrast: ColorsResOld.white,
//     alert: ColorsResOld.redDark,
//     apply: ColorsResOld.greenDark,
//     blue: ColorsResOld.blue,
//     blueSecond: ColorsResOld.blueSecond,
//     labelYellow: ColorsResOld.yellow,
//     labelOrange: ColorsResOld.orange,
//     lightBlue: ColorsResOld.blue344347,
//     lightGreen: ColorsResOld.green374236,
//     lightOrange: ColorsResOld.orange463D2D,
//     lightRed: ColorsResOld.red443926,
//     gradient: ColorsResOld.gradientDark,
//   );

//   return ThemeStyle(
//     colors: colors,
//     styles: StylesPalette(
//       buttonTextStyle: StyleRes.button,
//       buttonsStyle: _mapButtonStyle(colors),
//     ),
//   );
// }

Map<EverButtonType, EverButtonStyle> _mapButtonStyle(ColorsPalette colors) {
  return {
    EverButtonType.primary: EverButtonStyle(
      backgroundColor: colors.backgroundPrimary,
      backgroundDisabledColor: colors.backgroundPrimary.withAlpha(
        Opac.opac50.toByteInt(),
      ),
      contentColor: colors.textContrast,
      contentPressedColor: colors.textSecondary,
      contentDisabledColor: colors.textContrast,
    ),
    EverButtonType.secondary: EverButtonStyle(
      backgroundColor: colors.backgroundSecondary,
      backgroundDisabledColor: colors.backgroundSecondary.withAlpha(
        Opac.opac50.toByteInt(),
      ),
      contentColor: colors.textPrimary,
      contentDisabledColor: colors.textPrimary.withAlpha(
        Opac.opac50.toByteInt(),
      ),
      contentPressedColor: colors.textSecondary,
    ),
    EverButtonType.ghost: EverButtonStyle(
      backgroundColor: ColorsResOld.transparent,
      contentColor: colors.textPrimary,
      contentDisabledColor: colors.textPrimary.withAlpha(
        Opac.opac50.toByteInt(),
      ),
      backgroundDisabledColor: ColorsResOld.transparent,
      contentPressedColor: colors.textSecondary,
    ),
  };
}
