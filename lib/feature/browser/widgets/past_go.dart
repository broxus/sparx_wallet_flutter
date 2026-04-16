import 'package:app/generated/generated.dart';
import 'package:flutter/material.dart';
import 'package:ui_components_lib/ui_components_lib.dart';

const _pastGoButtonWidth = 151.0;
const _pastGoButtonHeight = 54.0;

class PastGoButton extends StatelessWidget {
  const PastGoButton({required this.onPressed, super.key});

  final VoidCallback onPressed;

  @override
  Widget build(BuildContext context) {
    final theme = context.themeStyle;
    return SizedBox(
      width: _pastGoButtonWidth,
      height: _pastGoButtonHeight,
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
                  padding: const EdgeInsets.only(top: DimensSize.d10),
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
