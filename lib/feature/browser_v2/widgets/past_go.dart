import 'package:app/generated/generated.dart';
import 'package:flutter/material.dart';
import 'package:ui_components_lib/ui_components_lib.dart';

class PastGoButton extends StatelessWidget {
  const PastGoButton({
    required this.onPressed,
    super.key,
  });

  final VoidCallback onPressed;

  @override
  Widget build(BuildContext context) {
    final theme = context.themeStyleV2;
    return SizedBox(
      width: DimensSizeV2.d151,
      height: DimensSizeV2.d54,
      child: GestureDetector(
        behavior: HitTestBehavior.opaque,
        onTap: onPressed,
        child: Stack(
          children: [
            Assets.images.tooltip.svg(),
            Positioned.fill(
              child: Align(
                alignment: Alignment.topCenter,
                child: Padding(
                  padding: const EdgeInsets.only(top: DimensSizeV2.d10),
                  child: Text(
                    LocaleKeys.pasteAndGo.tr(),
                    style: theme.textStyles.paragraphMedium.copyWith(
                      color: theme.colors.primaryA,
                    ),
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
