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
          padding: const EdgeInsets.symmetric(horizontal: DimensSize.d32),
          child: Text(
            title,
            style: themeStyle.textStyles.labelSmallSemibold.copyWith(
              color: themeStyle.colors.content2,
            ),
          ),
        ),
      ),
    );
  }
}
