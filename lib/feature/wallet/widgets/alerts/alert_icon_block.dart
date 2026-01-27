import 'package:flutter/material.dart';
import 'package:lucide_icons_flutter/lucide_icons.dart';
import 'package:ui_components_lib/ui_components_lib.dart';

class AlertIconBlock extends StatelessWidget {
  const AlertIconBlock({super.key});

  @override
  Widget build(BuildContext context) {
    final theme = context.themeStyleV2;
    final color = theme.colors.borderNegative.withAlpha(51);

    return Container(
      width: DimensSize.d92,
      height: DimensSize.d92,
      decoration: BoxDecoration(color: color, shape: .circle),
      child: Padding(
        padding: const EdgeInsets.all(DimensSize.d7),
        child: Container(
          decoration: BoxDecoration(color: color, shape: .circle),
          child: Padding(
            padding: const EdgeInsets.all(DimensSize.d7),
            child: Container(
              decoration: BoxDecoration(color: color, shape: .circle),
              child: Center(
                child: Icon(
                  LucideIcons.triangleAlert,
                  color: theme.colors.borderNegative,
                  size: DimensSize.d38,
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
