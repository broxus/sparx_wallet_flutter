import 'package:flutter/material.dart';
import 'package:ui_components_lib/ui_components_lib.dart';

class AppPopupMenuItem extends StatelessWidget {
  const AppPopupMenuItem({
    required this.title,
    required this.icon,
    required this.onTap,
    super.key,
  });

  final String title;
  final IconData icon;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    final theme = context.themeStyleV2;
    return Container(
      width: double.infinity,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(
            title,
            style: theme.textStyles.labelMedium
                .copyWith(color: theme.colors.content2),
          ),
          Icon(
            icon,
            size: DimensSizeV2.d16,
            color: theme.colors.content2,
          )
        ],
      ),
    );
  }
}
