import 'package:flutter/material.dart';
import 'package:ui_components_lib/ui_components_lib.dart';

class ToastStyle {
  ToastStyle.normal(ColorsPalette colors)
    // TODO(malochka): remove it after redisgn toasts
    : backgroundColor = colors.background2,
      borderColor = colors.borderAlpha,
      iconColor = colors.content3;

  ToastStyle.error(ColorsPalette colors)
    : backgroundColor = colors.backgroundNegative,
      borderColor = colors.borderNegative,
      iconColor = colors.contentNegative;

  ToastStyle.warning(ColorsPalette colors)
    : backgroundColor = colors.backgroundWarning,
      borderColor = colors.borderWarning,
      iconColor = colors.contentWarning;

  ToastStyle.success(ColorsPalette colors)
    : backgroundColor = colors.backgroundPositive,
      borderColor = colors.borderPositive,
      iconColor = colors.contentPositive;
  final Color backgroundColor;
  final Color iconColor;
  final Color borderColor;
}
