import 'package:flutter/material.dart';
import 'package:ui_components_lib/ui_components_lib.dart';

class WalletActionButton extends StatelessWidget {
  const WalletActionButton({
    required this.label,
    required this.icon,
    required this.onPressed,
    this.badge,
    super.key,
  });

  final String label;
  final IconData icon;
  final bool? badge;
  final VoidCallback? onPressed;

  @override
  Widget build(BuildContext context) {
    final theme = context.themeStyle;

    return GestureDetector(
      behavior: HitTestBehavior.translucent,
      onTap: onPressed,
      child: Opacity(
        opacity: onPressed == null ? Opac.opac25 : Opac.opac100,
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Padding(
              padding: const EdgeInsets.all(DimensSize.d18),
              child: Icon(icon, size: DimensSize.d20),
            ),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: DimensSize.d4),
              child: FittedBox(
                fit: BoxFit.scaleDown,
                child: Text(
                  label,
                  style: theme.textStyles.labelXSmall.copyWith(
                    color: theme.colors.content3,
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
