import 'package:app/generated/generated.dart';
import 'package:flutter/material.dart';
import 'package:ui_components_lib/v2/ui_components_lib_v2.dart';

class BrowserBookmarksMenu extends StatelessWidget {
  const BrowserBookmarksMenu({
    required this.onPressedEdit,
    required this.onPressedDone,
    this.isChanged = false,
    super.key,
  });

  final bool isChanged;

  final VoidCallback onPressedEdit;
  final VoidCallback onPressedDone;

  static const height = _Container._height;

  @override
  Widget build(BuildContext context) {
    return _Container(
      child: Align(
        alignment: Alignment.topRight,
        child: _EditButton(
          isChanged: isChanged,
          onPressedEdit: onPressedEdit,
          onPressedDone: onPressedDone,
        ),
      ),
    );
  }
}

class _Container extends StatelessWidget {
  const _Container({
    required this.child,
  });

  final Widget child;

  static const _height = DimensSizeV2.d70;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: double.infinity,
      height: _height,
      child: child,
    );
  }
}

class _EditButton extends StatelessWidget {
  const _EditButton({
    required this.onPressedEdit,
    required this.onPressedDone,
    this.isChanged = false,
  });

  final bool isChanged;

  final VoidCallback onPressedEdit;
  final VoidCallback onPressedDone;

  @override
  Widget build(BuildContext context) {
    final theme = context.themeStyleV2;
    final styles = theme.textStyles;
    final colors = theme.colors;
    return GestureDetector(
      child: Padding(
        padding: const EdgeInsets.symmetric(
          vertical: DimensSizeV2.d14,
          horizontal: DimensSizeV2.d32,
        ),
        child: Text(
          isChanged ? LocaleKeys.done.tr() : LocaleKeys.edit.tr(),
          // style: styles,
        ),
      ),
    );
  }
}
