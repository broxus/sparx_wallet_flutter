import 'package:app/feature/messenger/data/message.dart';
import 'package:flutter/material.dart';
import 'package:lucide_icons_flutter/lucide_icons.dart';
import 'package:ui_components_lib/ui_components_lib.dart';
import 'package:ui_components_lib/v2/ui_components_lib_v2.dart';

class ToastMessage extends StatelessWidget {
  const ToastMessage.fromMessage(
    this.message, {
    required this.onPressedAction,
    required this.onTapClosed,
    this.padding = EdgeInsets.zero,
    super.key,
  });

  final Message message;
  final VoidCallback? onPressedAction;
  final VoidCallback onTapClosed;
  final EdgeInsets padding;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: padding,
      child: Toast(
        type: switch (message.type.snackbarType) {
          SnackbarType.info => ToastType.normal,
          SnackbarType.error => ToastType.error,
          SnackbarType.successful => ToastType.success,
        },
        onTapClosed: onTapClosed,
        description: message.message,
        icon: switch (message.type.snackbarType) {
          SnackbarType.info => null,
          SnackbarType.error => LucideIcons.triangleAlert,
          SnackbarType.successful => LucideIcons.check,
        },
        actions: [
          if (message.actionText != null)
            FloatButton(
              buttonShape: ButtonShape.rectangle,
              buttonSize: ButtonSize.small,
              title: message.actionText,
              onPressed: onPressedAction,
              backgroundBlur: 0,
            ),
        ],
        topMargin: message.topMargin,
      ),
    );
  }
}
