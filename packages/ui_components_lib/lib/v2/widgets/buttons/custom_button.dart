import 'package:flutter/material.dart';
import 'package:ui_components_lib/v2/theme_style_v2.dart';
import 'package:ui_components_lib/v2/widgets/buttons/base_button.dart';
import 'package:ui_components_lib/v2/widgets/buttons/button_style.dart';

class CustomButton extends BaseButton {
  const CustomButton({
    required super.buttonShape,
    super.onPressed,
    super.isLoading,
    super.title,
    super.child,
    super.icon,
    super.postfixIcon,
    super.buttonSize,
    super.isFullWidth,
    super.padding,
    super.key,
    this.backgroundColor,
    this.iconColor,
    this.borderColor,
    this.textStyle,
  });

  final Color? backgroundColor;
  final Color? iconColor;
  final Color? borderColor;
  final TextStyle? textStyle;

  @override
  AppButtonStyle getStyle(ThemeStyleV2 theme) => AppButtonStyle.custom(
        theme.colors,
        theme.textStyles,
        backgroundColor: backgroundColor,
        iconColor: iconColor,
        borderColor: borderColor,
        textStyle: textStyle,
      );
}
