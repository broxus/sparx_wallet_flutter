import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:ui_components_lib/ui_components_lib.dart';
import 'package:ui_components_lib/v2/ui_components_lib_v2.dart';

//It's base class for button, in this button we handle all parameters like
//shape, styles, size
abstract class BaseButton extends StatelessWidget {
  const BaseButton({
    required this.buttonShape,
    this.child,
    this.buttonSize = ButtonSize.large,
    this.title,
    this.onPressed,
    this.width,
    this.isLoading = false,
    this.icon,
    this.postfixIcon,
    this.isFullWidth = true,
    this.backgroundBlur,
    this.padding,
    this.mainAxisAlignment = MainAxisAlignment.center,
    super.key,
  });

  final ButtonShape buttonShape;
  final bool isLoading;
  final ButtonSize buttonSize;
  final VoidCallback? onPressed;
  final Widget? child;
  final String? title;
  final double? width;
  final IconData? icon;
  final IconData? postfixIcon;
  final bool isFullWidth;
  final double? backgroundBlur;
  final EdgeInsetsGeometry? padding;
  final MainAxisAlignment mainAxisAlignment;

  EdgeInsetsGeometry get _paddingByButtonSize {
    return padding ??
        switch (buttonSize) {
          ButtonSize.large => const EdgeInsets.all(DimensSizeV2.d18),
          ButtonSize.medium => const EdgeInsets.all(DimensSizeV2.d16),
          ButtonSize.small => const EdgeInsets.symmetric(
            horizontal: DimensSizeV2.d24,
            vertical: DimensSizeV2.d8,
          ),
          ButtonSize.mini => const EdgeInsets.symmetric(
            horizontal: DimensSizeV2.d12,
            vertical: DimensSizeV2.d6,
          ),
        };
  }

  double get _iconSize {
    switch (buttonSize) {
      case ButtonSize.large:
        return DimensSizeV2.d20;
      case ButtonSize.medium:
        return DimensSizeV2.d16;
      case ButtonSize.small:
        return DimensSizeV2.d16;
      case ButtonSize.mini:
        return DimensSizeV2.d16;
    }
  }

  double get _fabSize {
    switch (buttonSize) {
      case ButtonSize.large:
        return DimensSizeV2.d56;
      case ButtonSize.medium:
        return DimensSizeV2.d48;
      case ButtonSize.small:
        return DimensSizeV2.d40;
      case ButtonSize.mini:
        return DimensSizeV2.d28;
    }
  }

  double get _borderRadius {
    if (buttonShape == ButtonShape.rectangle ||
        buttonShape == ButtonShape.square) {
      switch (buttonSize) {
        case ButtonSize.large:
          return DimensRadiusV2.radius16;
        case ButtonSize.medium:
          return DimensRadiusV2.radius12;
        case ButtonSize.small:
          return DimensRadiusV2.radius8;
        case ButtonSize.mini:
          return DimensRadiusV2.radius24;
      }
    } else {
      return DimensRadiusV2.theBiggest;
    }
  }

  @override
  Widget build(BuildContext context) {
    final themeStyle = context.themeStyleV2;
    final style = getStyle(themeStyle);
    final buttonStyle = _getButtonStyle(themeStyle, style);
    final child = this.child ?? Text(title ?? '', textAlign: TextAlign.center);

    switch (buttonShape) {
      case ButtonShape.pill:
      case ButtonShape.rectangle:
        return ClipRRect(
          borderRadius: BorderRadius.circular(_borderRadius),
          child: BackdropFilter(
            filter: ImageFilter.blur(
              sigmaX: backgroundBlur ?? 0,
              sigmaY: backgroundBlur ?? 0,
            ),
            child: ElevatedButton(
              onPressed: isLoading ? null : onPressed,
              style: buttonStyle,
              child: isLoading
                  ? Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        ProgressIndicatorWidget(
                          color: style.iconColor,
                          size: _iconSize,
                        ),
                      ],
                    )
                  : Row(
                      mainAxisAlignment: mainAxisAlignment,
                      mainAxisSize: isFullWidth
                          ? MainAxisSize.max
                          : MainAxisSize.min,
                      children: [
                        if (icon != null)
                          Padding(
                            padding: const EdgeInsets.only(
                              right: DimensSizeV2.d8,
                            ),
                            child: Icon(icon, size: _iconSize),
                          ),
                        child,
                        if (postfixIcon != null)
                          Padding(
                            padding: const EdgeInsets.only(
                              left: DimensSizeV2.d8,
                            ),
                            child: Icon(postfixIcon, size: _iconSize),
                          ),
                      ],
                    ),
            ),
          ),
        );
      case ButtonShape.square:
      case ButtonShape.circle:
        return SizedBox(
          width: _fabSize,
          height: _fabSize,
          child: ElevatedButton(
            style: buttonStyle,
            onPressed: isLoading ? null : onPressed,
            child: this.child ?? Icon(icon, size: _iconSize),
          ),
        );
    }
  }

  @protected
  AppButtonStyle getStyle(ThemeStyleV2 theme);

  ButtonStyle _getButtonStyle(ThemeStyleV2 themeStyle, AppButtonStyle style) {
    return ButtonStyle(
      elevation: WidgetStateProperty.all(0),
      textStyle: WidgetStateProperty.resolveWith<TextStyle>(
        (Set<WidgetState> states) =>
            _getTextStyle(states, themeStyle.textStyles, buttonSize),
      ),
      shape: WidgetStateProperty.resolveWith<RoundedRectangleBorder>(
        (Set<WidgetState> states) =>
            _getBorder(states, style, buttonShape, buttonSize),
      ),
      backgroundColor: WidgetStateProperty.resolveWith<Color>(
        (Set<WidgetState> states) => _getColorBackground(states, style),
      ),
      overlayColor: WidgetStateProperty.resolveWith<Color>(
        (Set<WidgetState> states) => _getColorOverlay(states, style),
      ),
      foregroundColor: WidgetStateProperty.resolveWith<Color?>(
        (Set<WidgetState> states) => _getColorForeground(states, style),
      ),
      padding: WidgetStateProperty.resolveWith(
        (_) => switch (buttonShape) {
          ButtonShape.circle || ButtonShape.square => EdgeInsets.zero,
          _ => _paddingByButtonSize,
        },
      ),
      minimumSize: WidgetStateProperty.resolveWith(
        (_) => switch (buttonSize) {
          ButtonSize.mini => Size.zero,
          _ => null,
        },
      ),
    );
  }

  TextStyle _getTextStyle(
    Set<WidgetState> states,
    TextStylesV2 styles,
    ButtonSize size,
  ) {
    final color = styles.labelMedium.color;
    if (states.contains(WidgetState.pressed)) {
      return _getTextStyleBySize(
        styles,
      ).copyWith(color: color?.withAlpha(OpacV2.opac80.toByteInt()));
    }
    if (states.contains(WidgetState.disabled)) {
      return _getTextStyleBySize(
        styles,
      ).copyWith(color: color?.withAlpha(OpacV2.opac50.toByteInt()));
    }
    return _getTextStyleBySize(styles);
  }

  RoundedRectangleBorder _getBorder(
    Set<WidgetState> states,
    AppButtonStyle style,
    ButtonShape shape,
    ButtonSize size,
  ) {
    return RoundedRectangleBorder(
      side: BorderSide(
        color: states.contains(WidgetState.focused)
            ? style.borderColor
            : Colors.transparent,
        width: DimensSizeV2.d2,
      ),
      borderRadius: BorderRadius.circular(_borderRadius),
    );
  }

  Color _getColorBackground(Set<WidgetState> states, AppButtonStyle style) {
    if (states.contains(WidgetState.pressed)) {
      return style.backgroundColor.withAlpha(
        (style.backgroundColor.a * OpacV2.opac80).toByteInt(),
      );
    }

    if (states.contains(WidgetState.disabled)) {
      return style.backgroundColor.withAlpha(
        (style.backgroundColor.a * OpacV2.opac50).toByteInt(),
      );
    }

    return style.backgroundColor;
  }

  Color _getColorForeground(Set<WidgetState> states, AppButtonStyle style) {
    if (states.contains(WidgetState.pressed)) {
      return style.iconColor.withAlpha(OpacV2.opac80.toByteInt());
    }

    if (states.contains(WidgetState.disabled)) {
      return style.iconColor.withAlpha(OpacV2.opac50.toByteInt());
    }
    return style.iconColor;
  }

  Color _getColorOverlay(Set<WidgetState> states, AppButtonStyle style) => style
      .backgroundColor
      .withAlpha((style.backgroundColor.a * OpacV2.opac80).toByteInt());

  TextStyle _getTextStyleBySize(TextStylesV2 styles) {
    switch (buttonSize) {
      case ButtonSize.large:
        return styles.labelMedium;
      case ButtonSize.medium:
        return styles.labelSmall;
      case ButtonSize.small:
        return styles.labelSmall;
      case ButtonSize.mini:
        return styles.labelXSmall;
    }
  }
}
