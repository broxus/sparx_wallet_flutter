import 'package:flutter/material.dart';

import 'package:ui_components_lib/ui_components_lib.dart';

enum SelectionStatus { unfocus, focus, completed }

/// This is a widget, that allows user interact with selection field.
/// Widget displays different UI depends on [SelectionStatus] and let user
/// know how to interact with it.
class SelectionStatusInput extends StatefulWidget {
  const SelectionStatusInput({
    required this.title,
    required this.onPressed,
    required this.status,
    super.key,
  });

  final String title;
  final SelectionStatus status;
  final VoidCallback? onPressed;

  @override
  State<SelectionStatusInput> createState() => _SelectionStatusInputState();
}

class _SelectionStatusInputState extends State<SelectionStatusInput> {
  bool isPressed = false;

  @override
  Widget build(BuildContext context) {
    final colors = context.themeStyle.colors;
    Color? backgroundColor;
    Color? borderColor;
    Color contentColor;

    switch (widget.status) {
      case SelectionStatus.unfocus:
        borderColor = colors.strokePrimary;
        contentColor = isPressed ? colors.textPrimary : colors.textSecondary;
        break;
      case SelectionStatus.focus:
        borderColor = colors.strokeContrast;
        contentColor = isPressed ? colors.textSecondary : colors.textPrimary;
        break;
      case SelectionStatus.completed:
        backgroundColor = colors.backgroundPrimary;
        contentColor = isPressed ? colors.textSecondary : colors.textContrast;
        break;
    }

    return SizedBox(
      width: double.infinity,
      height: commonButtonHeight,
      child: Material(
        color: backgroundColor ?? Colors.transparent,
        shape: SquircleBoxBorder(
          squircleRadius: 16,
          borderSide: BorderSide(color: borderColor ?? Colors.transparent),
        ),
        child: InkWell(
          hoverColor: Colors.transparent,
          splashColor: Colors.transparent,
          highlightColor: Colors.transparent,
          onHighlightChanged: (isPressed) {
            if (isPressed != this.isPressed) {
              setState(() => this.isPressed = isPressed);
            }
          },
          onTap: widget.onPressed,
          child: AnimatedColor(
            color: contentColor,
            duration: kThemeAnimationDuration,
            builder: (context, color) {
              return Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                    widget.title,
                    style: StyleRes.button.copyWith(color: contentColor),
                  ),
                  // TODO(alex-a4): add trash can button
                ],
              );
            },
          ),
        ),
      ),
    );
  }
}
