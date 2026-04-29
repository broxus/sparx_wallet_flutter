import 'package:flutter/material.dart';
import 'package:ui_components_lib/ui_components_lib.dart';

//This class has some named constructors, every constructor has different
// value of fields, which will be used in BaseButton
class AppButtonStyle {
  AppButtonStyle.ghost(ColorsPalette colors, TextStyles textStyles)
    : backgroundColor = ColorsRes.transparent,
      iconColor = colors.content0,
      buttonTextStyle = textStyles.labelMedium,
      borderColor = colors.borderFocus.withAlpha(Opac.opac50.toByteInt());

  AppButtonStyle.accent(ColorsPalette colors, TextStyles textStyles)
    : backgroundColor = colors.backgroundAccent,
      iconColor = colors.content0,
      buttonTextStyle = textStyles.labelMedium,
      borderColor = colors.borderFocus.withAlpha(Opac.opac50.toByteInt());

  AppButtonStyle.primary(ColorsPalette colors, TextStyles textStyles)
    : backgroundColor = colors.background3,
      iconColor = colors.content0,
      buttonTextStyle = textStyles.labelMedium,
      borderColor = colors.borderFocus.withAlpha(Opac.opac50.toByteInt());

  AppButtonStyle.float(ColorsPalette colors, TextStyles textStyles)
    : backgroundColor = colors.backgroundAlpha,
      iconColor = colors.content0,
      buttonTextStyle = textStyles.labelMedium,
      borderColor = colors.borderFocus.withAlpha(Opac.opac50.toByteInt());

  AppButtonStyle.custom(
    ColorsPalette colors,
    TextStyles textStyles, {
    Color? backgroundColor,
    Color? iconColor,
    Color? borderColor,
    TextStyle? textStyle,
  }) : backgroundColor = backgroundColor ?? colors.background3,
       iconColor = iconColor ?? colors.content0,
       buttonTextStyle = textStyle ?? textStyles.labelMedium,
       borderColor =
           borderColor ?? colors.borderFocus.withAlpha(Opac.opac50.toByteInt());

  AppButtonStyle.destructive(
    ColorsPalette colors,
    TextStyles textStyles, {
    Color? backgroundColor,
  }) : backgroundColor = backgroundColor ?? colors.backgroundNegative,
       iconColor = colors.content0,
       buttonTextStyle = textStyles.labelMedium,
       borderColor = colors.borderFocus.withAlpha(Opac.opac50.toByteInt());

  AppButtonStyle.transparent(ColorsPalette colors, TextStyles textStyles)
    : backgroundColor = colors.backgroundButtonAlpha,
      iconColor = colors.content0,
      buttonTextStyle = textStyles.labelMedium,
      borderColor = colors.borderFocus.withAlpha(Opac.opac50.toByteInt());

  final Color backgroundColor;
  final Color iconColor;
  final TextStyle buttonTextStyle;
  final Color borderColor;
}
