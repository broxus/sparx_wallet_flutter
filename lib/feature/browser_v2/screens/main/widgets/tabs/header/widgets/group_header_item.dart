import 'package:auto_size_text/auto_size_text.dart';
import 'package:flutter/cupertino.dart';
import 'package:ui_components_lib/ui_components_lib.dart';

class BrowserGroupHeaderItem extends StatelessWidget {
  const BrowserGroupHeaderItem({
    required this.width,
    required this.name,
    required this.isSelected,
    required this.onPressed,
    this.count,
    super.key,
  });

  final double width;
  final String name;
  final bool isSelected;
  final String? count;
  final VoidCallback onPressed;

  @override
  Widget build(BuildContext context) {
    final theme = context.themeStyleV2;

    final colors = theme.colors;

    final styles = theme.textStyles;

    return GestureDetector(
      behavior: HitTestBehavior.opaque,
      onTap: onPressed,
      child: SizedBox(
        width: width,
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
              name,
              style: isSelected
                  ? styles.labelMedium
                  : styles.labelSmall.copyWith(
                color: colors.content2,
              ),
            ),
            if (count != null)
              Padding(
                padding: const EdgeInsets.only(left: DimensSizeV2.d4),
                child: DecoratedBox(
                  decoration: const BoxDecoration(
                    shape: BoxShape.circle,
                    // TODO(knightforce): add to color palette
                    color: Color(0xff353960),
                  ),
                  child: SizedBox(
                    width: DimensSizeV2.d20,
                    height: DimensSizeV2.d20,
                    child: Center(
                      child: AutoSizeText(
                        count!,
                        minFontSize: 1,
                        style: styles.labelXSmall,
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