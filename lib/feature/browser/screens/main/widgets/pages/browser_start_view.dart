import 'package:app/generated/generated.dart';
import 'package:flutter/material.dart';
import 'package:lucide_icons_flutter/lucide_icons.dart';
import 'package:ui_components_lib/ui_components_lib.dart';

class BrowserStartView extends StatelessWidget {
  const BrowserStartView({super.key});

  @override
  Widget build(BuildContext context) {
    final theme = context.themeStyleV2;
    final styles = theme.textStyles;
    final colors = theme.colors;
    return SizedBox(
      height: double.infinity,
      child: DecoratedBox(
        decoration: BoxDecoration(
          color: context.themeStyleV2.colors.background0,
        ),
        child: Stack(
          children: [
            Assets.images.bgNetwork.image(width: double.infinity),
            Positioned(
              bottom: DimensSize.d4,
              left: 0,
              right: 0,
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Padding(
                    padding: const EdgeInsets.only(bottom: DimensSize.d8),
                    child: Text(
                      LocaleKeys.browserStartTitle.tr(),
                      textAlign: TextAlign.center,
                      style: styles.headingXLarge,
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.only(bottom: DimensSize.d24),
                    child: Text(
                      LocaleKeys.browserStartDescription.tr(),
                      textAlign: TextAlign.center,
                      style: styles.paragraphLarge.copyWith(
                        color: colors.content4,
                      ),
                    ),
                  ),
                  const Icon(LucideIcons.arrowDown, size: DimensSize.d40),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
