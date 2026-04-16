import 'package:flutter/material.dart';
import 'package:ui_components_lib/ui_components_lib.dart';

class ThemeStyle extends ThemeExtension<ThemeStyle> {
  /// {@macro theme_style}
  ThemeStyle({
    required this.colors,
    required this.textStyles,
    required this.legacyStyles,
  });

  /// The palette of colors in the project.
  final ColorsPalette colors;
  final TextStyles textStyles;
  final StylesPalette legacyStyles;

  /// Do not supported
  @override
  ThemeExtension<ThemeStyle> copyWith() => this;

  /// Do not supported
  @override
  ThemeExtension<ThemeStyle> lerp(
    ThemeExtension<ThemeStyle>? other,
    double t,
  ) => this;
}

/// Getting theme style from context
extension ThemeContextExtensionV2 on BuildContext {
  ThemeStyle get themeStyle {
    return Theme.of(this).extension<ThemeStyle>() ?? getDefaultTheme();
  }
}
