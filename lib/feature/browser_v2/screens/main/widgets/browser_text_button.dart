import 'package:flutter/cupertino.dart';
import 'package:ui_components_lib/ui_components_lib.dart';

class BrowserTextButton extends StatelessWidget {
  const BrowserTextButton({
    required this.title,
    this.alignment = Alignment.center,
    this.onPressed,
    super.key,
  });

  final String title;
  final Alignment alignment;
  final VoidCallback? onPressed;

  @override
  Widget build(BuildContext context) {
    final themeStyle = context.themeStyleV2;

    return GestureDetector(
      onTap: onPressed,
      behavior: HitTestBehavior.opaque,
      child: Align(
        alignment: alignment,
        child: Padding(
          padding: const EdgeInsets.symmetric(
            horizontal: DimensSizeV2.d32,
          ),
          child: Text(
            title,
            // TODO(knightforce): check style from designer
            style: themeStyle.textStyles.labelSmall.copyWith(
              fontWeight: FontWeight.w600,
              color: themeStyle.colors.content2,
              height: 1,
            ),
          ),
        ),
      ),
    );
  }
}