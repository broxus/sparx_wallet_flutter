import 'package:flutter/material.dart';
import 'package:lucide_icons_flutter/lucide_icons.dart';
import 'package:ui_components_lib/ui_components_lib.dart';

const _alertContainerSize = 92.0;
const _padding = 7.0;
const _iconSize = 38.0;

class AlertIconBlock extends StatelessWidget {
  const AlertIconBlock({super.key});

  @override
  Widget build(BuildContext context) {
    final theme = context.themeStyle;
    final color = theme.colors.borderNegative.withAlpha(51);

    return Container(
      width: _alertContainerSize,
      height: _alertContainerSize,
      decoration: BoxDecoration(color: color, shape: .circle),
      child: Padding(
        padding: const EdgeInsets.all(_padding),
        child: Container(
          decoration: BoxDecoration(color: color, shape: .circle),
          child: Padding(
            padding: const EdgeInsets.all(_padding),
            child: Container(
              decoration: BoxDecoration(color: color, shape: .circle),
              child: Center(
                child: Icon(
                  LucideIcons.triangleAlert,
                  color: theme.colors.borderNegative,
                  size: _iconSize,
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
