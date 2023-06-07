import 'package:flutter/material.dart';

import 'package:ui_components_lib/ui_components_lib.dart';

/// This is a wrapper widget above [CommonButton] with specified
/// size parameters.
class SmallButton extends StatelessWidget {
  const SmallButton({
    this.buttonType = EverButtonType.primary,
    super.key,
    this.text,
    this.onPressed,
    this.onLongPress,
    this.leading,
    this.trailing,
    this.child,
    this.focusNode,
  });

  /// CommonButton with primary style
  factory SmallButton.primary({
    String? text,
    VoidCallback? onPressed,
    VoidCallback? onLongPress,
    Widget? leading,
    Widget? trailing,
    FocusNode? focusNode,
  }) =>
      SmallButton(
        text: text,
        onPressed: onPressed,
        onLongPress: onLongPress,
        leading: leading,
        trailing: trailing,
        focusNode: focusNode,
      );

  /// SmallButton with secondary style
  factory SmallButton.secondary({
    String? text,
    VoidCallback? onPressed,
    VoidCallback? onLongPress,
    Widget? leading,
    Widget? trailing,
    FocusNode? focusNode,
  }) =>
      SmallButton(
        buttonType: EverButtonType.secondary,
        text: text,
        onPressed: onPressed,
        onLongPress: onLongPress,
        leading: leading,
        trailing: trailing,
        focusNode: focusNode,
      );

  /// SmallButton with ghost style
  factory SmallButton.ghost({
    String? text,
    VoidCallback? onPressed,
    VoidCallback? onLongPress,
    Widget? leading,
    Widget? trailing,
    FocusNode? focusNode,
  }) =>
      SmallButton(
        buttonType: EverButtonType.ghost,
        text: text,
        onPressed: onPressed,
        onLongPress: onLongPress,
        leading: leading,
        trailing: trailing,
        focusNode: focusNode,
      );

  /// See [CommonButton.buttonType]
  final EverButtonType buttonType;

  /// See [CommonButton.text]
  final String? text;

  /// See [CommonButton.onPressed]
  final VoidCallback? onPressed;

  /// See [CommonButton.onLongPress]
  final VoidCallback? onLongPress;

  /// See [CommonButton.leading]
  final Widget? leading;

  /// See [CommonButton.trailing]
  final Widget? trailing;

  /// See [CommonButton.child]
  final Widget? child;

  /// See [CommonButton.focusNode]
  final FocusNode? focusNode;

  @override
  Widget build(BuildContext context) {
    return CommonButton(
      height: DimensSize.d32,
      padding: const EdgeInsets.symmetric(
        horizontal: DimensSize.d16,
        vertical: DimensSize.d4,
      ),
      focusNode: focusNode,
      buttonType: buttonType,
      onPressed: onPressed,
      onLongPress: onLongPress,
      text: text,
      leading: leading,
      trailing: trailing,
      fillWidth: false,
      child: child,
    );
  }
}
