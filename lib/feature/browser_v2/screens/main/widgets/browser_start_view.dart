import 'package:app/feature/browser_v2/screens/main/widgets/control_panel/main_control_panel/main_control_panel.dart';
import 'package:app/feature/browser_v2/screens/main/widgets/control_panel/page_control_panel/url_panel.dart';
import 'package:app/generated/generated.dart';
import 'package:flutter/material.dart';
import 'package:lucide_icons_flutter/lucide_icons.dart';
import 'package:ui_components_lib/v2/ui_components_lib_v2.dart';

class BrowserStartView extends StatelessWidget {
  const BrowserStartView({super.key});

  static const _bottom = BrowserTabViewMenuUrlPanel.height +
      BrowserMainControlPanel.height +
      DimensSizeV2.d12;

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
              bottom: BrowserStartView._bottom,
              left: 0,
              right: 0,
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Padding(
                    padding: const EdgeInsets.only(
                      bottom: DimensSizeV2.d8,
                    ),
                    child: Text(
                      LocaleKeys.browserStartTitle.tr(),
                      textAlign: TextAlign.center,
                      style: styles.headingXLarge,
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.only(
                      bottom: DimensSizeV2.d24,
                    ),
                    child: Text(
                      LocaleKeys.browserStartDescription.tr(),
                      textAlign: TextAlign.center,
                      style: styles.paragraphLarge.copyWith(
                        color: colors.content4,
                      ),
                    ),
                  ),
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
