import 'package:flutter/material.dart';
import 'package:ui_components_lib/ui_components_lib.dart';

///This class should be deleted after refactoring enter seed v2
class CommonInputStyleV2 {
  CommonInputStyleV2(ThemeStyle themeStyle)
    : borderColor = themeStyle.colors.borderFocus,
      borderSuggestionColor = themeStyle.colors.borderAlpha,
      labelTextStyle = themeStyle.textStyles.labelSmall;

  final Color borderColor;
  final Color borderSuggestionColor;
  final TextStyle labelTextStyle;
}
