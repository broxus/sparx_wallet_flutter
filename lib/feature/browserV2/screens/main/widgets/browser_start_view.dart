import 'package:app/feature/browserV2/screens/main/widgets/menu/menu_view_tab/menu_view_tab.dart';
import 'package:app/generated/generated.dart';
import 'package:flutter/material.dart';
import 'package:lucide_icons_flutter/lucide_icons.dart';
import 'package:ui_components_lib/v2/ui_components_lib_v2.dart';

// TODO(kngihtforce): not complete
class BrowserStartView extends StatelessWidget {
  const BrowserStartView({super.key});

  @override
  Widget build(BuildContext context) {
    final styles = context.themeStyleV2.textStyles;

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
              bottom: BrowserTabViewMenu.height + DimensSizeV2.d12,
              left: 0,
              right: 0,
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  // TODO(knightforce): check
                  Text(
                    LocaleKeys.browserStartTitle.tr(),
                    textAlign: TextAlign.center,
                    style: styles.headingXLarge,
                  ),
                  const SizedBox(height: DimensSizeV2.d8),
                  // TODO(knightforce): check
                  Text(
                    LocaleKeys.browserStartDescription.tr(),
                    textAlign: TextAlign.center,
                    style: styles.paragraphLarge,
                  ),
                  const SizedBox(height: DimensSizeV2.d24),
                  const Icon(
                    LucideIcons.arrowDown,
                    size: DimensSizeV2.d40,
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
