import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:ui_components_lib/ui_components_lib.dart';

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
          ButtonSize.large => const EdgeInsets.all(DimensSize.d18),
          ButtonSize.medium => const EdgeInsets.all(DimensSize.d16),
          ButtonSize.small => const EdgeInsets.symmetric(
            horizontal: DimensSize.d24,
            vertical: DimensSize.d8,
          ),
          ButtonSize.mini => const EdgeInsets.symmetric(
            horizontal: DimensSize.d12,
            vertical: DimensSize.d6,
          ),
        };
  }

  double get _iconSize {
    switch (buttonSize) {
      case ButtonSize.large:
        return DimensSize.d20;
      case ButtonSize.medium:
        return DimensSize.d16;
      case ButtonSize.small:
        return DimensSize.d16;
      case ButtonSize.mini:
        return DimensSize.d16;
    }
  }

  double get _fabSize {
    switch (buttonSize) {
      case ButtonSize.large:
        return DimensSize.d56;
      case ButtonSize.medium:
        return DimensSize.d48;
      case ButtonSize.small:
        return DimensSize.d40;
      case ButtonSize.mini:
        return DimensSize.d28;
    }
  }

  double get _borderRadius {
    if (buttonShape == ButtonShape.rectangle ||
        buttonShape == ButtonShape.square) {
      switch (buttonSize) {
        case ButtonSize.large:
          return DimensRadius.radius16;
        case ButtonSize.medium:
          return DimensRadius.radius12;
        case ButtonSize.small:
          return DimensRadius.radius8;
        case ButtonSize.mini:
          return DimensRadius.radius24;
      }
    } else {
      return DimensRadius.theBiggest;
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
                              right: DimensSize.d8,
                            ),
                            child: Icon(icon, size: _iconSize),
                          ),
                        child,
                        if (postfixIcon != null)
                          Padding(
                            padding: const EdgeInsets.only(left: DimensSize.d8),
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
      // TODO(MolochkoAndrew): update
      //ignore: deprecated_member_use
      elevation: MaterialStateProperty.all(0),
      // TODO(MolochkoAndrew): update
      //ignore: deprecated_member_use
      textStyle: MaterialStateProperty.resolveWith<TextStyle>(
        // TODO(MolochkoAndrew): update
        //ignore: deprecated_member_use
        (Set<MaterialState> states) =>
            _getTextStyle(states, themeStyle.textStyles, buttonSize),
      ),
      // TODO(MolochkoAndrew): update
      //ignore: deprecated_member_use
      shape: MaterialStateProperty.resolveWith<RoundedRectangleBorder>(
        // TODO(MolochkoAndrew): update
        //ignore: deprecated_member_use
        (Set<MaterialState> states) =>
            _getBorder(states, style, buttonShape, buttonSize),
      ),
      // TODO(MolochkoAndrew): update
      //ignore: deprecated_member_use
      backgroundColor: MaterialStateProperty.resolveWith<Color>(
        // TODO(MolochkoAndrew): update
        //ignore: deprecated_member_use
        (Set<MaterialState> states) => _getColorBackground(states, style),
      ),
      // TODO(MolochkoAndrew): update
      //ignore: deprecated_member_use
      overlayColor: MaterialStateProperty.resolveWith<Color>(
        // TODO(MolochkoAndrew): update
        //ignore: deprecated_member_use
        (Set<MaterialState> states) => _getColorOverlay(states, style),
      ),
      // TODO(MolochkoAndrew): update
      //ignore: deprecated_member_use
      foregroundColor: MaterialStateProperty.resolveWith<Color?>(
        // TODO(MolochkoAndrew): update
        //ignore: deprecated_member_use
        (Set<MaterialState> states) => _getColorForeground(states, style),
      ),
      // TODO(MolochkoAndrew): update
      //ignore: deprecated_member_use
      padding: MaterialStateProperty.resolveWith(
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
    // TODO(MolochkoAndrew): update
    //ignore: deprecated_member_use
    Set<MaterialState> states,
    TextStylesV2 styles,
    ButtonSize size,
  ) {
    final color = styles.labelMedium.color;
    // TODO(MolochkoAndrew): update
    //ignore: deprecated_member_use
    if (states.contains(MaterialState.pressed)) {
      return _getTextStyleBySize(
        styles,
      ).copyWith(color: color?.withAlpha(OpacV2.opac80.toByteInt()));
    }
    // TODO(MolochkoAndrew): update
    //ignore: deprecated_member_use
    if (states.contains(MaterialState.disabled)) {
      return _getTextStyleBySize(
        styles,
      ).copyWith(color: color?.withAlpha(OpacV2.opac50.toByteInt()));
    }
    return _getTextStyleBySize(styles);
  }

  RoundedRectangleBorder _getBorder(
    // TODO(MolochkoAndrew): update
    //ignore: deprecated_member_use
    Set<MaterialState> states,
    AppButtonStyle style,
    ButtonShape shape,
    ButtonSize size,
  ) {
    return RoundedRectangleBorder(
      side: BorderSide(
        // TODO(MolochkoAndrew): update
        //ignore: deprecated_member_use
        color: states.contains(MaterialState.focused)
            ? style.borderColor
            : Colors.transparent,
        width: DimensSize.d2,
      ),
      borderRadius: BorderRadius.circular(_borderRadius),
    );
  }

  // TODO(MolochkoAndrew): update
  //ignore: deprecated_member_use
  Color _getColorBackground(Set<MaterialState> states, AppButtonStyle style) {
    // TODO(MolochkoAndrew): update
    //ignore: deprecated_member_use
    if (states.contains(MaterialState.pressed)) {
      return style.backgroundColor.withAlpha(
        (style.backgroundColor.a * OpacV2.opac80).toByteInt(),
      );
    }
    // TODO(MolochkoAndrew): update
    //ignore: deprecated_member_use
    if (states.contains(MaterialState.disabled)) {
      return style.backgroundColor.withAlpha(
        (style.backgroundColor.a * OpacV2.opac50).toByteInt(),
      );
    }

    return style.backgroundColor;
  }

  // TODO(MolochkoAndrew): update
  //ignore: deprecated_member_use
  Color _getColorForeground(Set<MaterialState> states, AppButtonStyle style) {
    // TODO(MolochkoAndrew): update
    //ignore: deprecated_member_use
    if (states.contains(MaterialState.pressed)) {
      return style.iconColor.withAlpha(OpacV2.opac80.toByteInt());
    }
    // TODO(MolochkoAndrew): update
    //ignore: deprecated_member_use
    if (states.contains(MaterialState.disabled)) {
      return style.iconColor.withAlpha(OpacV2.opac50.toByteInt());
    }
    return style.iconColor;
  }

  // TODO(MolochkoAndrew): update
  //ignore: deprecated_member_use
  Color _getColorOverlay(Set<MaterialState> states, AppButtonStyle style) =>
      style.backgroundColor.withAlpha(
        (style.backgroundColor.a * OpacV2.opac80).toByteInt(),
      );

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
