import 'package:flutter/cupertino.dart';
import 'package:ui_components_lib/ui_components_lib.dart';

class BrowserHeaderTextButton extends StatelessWidget {
  const BrowserHeaderTextButton({
    required this.width,
    required this.text,
    required this.alignment,
    required this.onPressed,
    super.key,
  });

  final double width;
  final String text;
  final Alignment alignment;
  final VoidCallback onPressed;

  @override
  Widget build(BuildContext context) {
    final theme = context.themeStyleV2;

    final colors = theme.colors;

    final styles = theme.textStyles;

    return GestureDetector(
      onTap: onPressed,
      child: SizedBox(
        width: width,
        height: double.infinity,
        child: Align(
          alignment: alignment,
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: DimensSizeV2.d16),
            child: Center(
              child: Text(
                text,
                style: styles.labelSmall.copyWith(
                  color: colors.content2,
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}