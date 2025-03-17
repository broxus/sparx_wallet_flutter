import 'package:flutter/material.dart';
import 'package:ui_components_lib/components/input/common_checkbox.dart';
import 'package:ui_components_lib/v2/ui_components_lib_v2.dart';

class TypeHistoryItem extends StatelessWidget {
  const TypeHistoryItem({
    required this.title,
    required this.isSelected,
    required this.onChanged,
    required this.description,
    required this.icon,
    super.key,
  });

  final String title;
  final String description;
  final IconData icon;
  final bool isSelected;
  final ValueChanged<bool?> onChanged;

  @override
  Widget build(BuildContext context) {
    final theme = context.themeStyleV2;
    return Padding(
      padding: const EdgeInsets.symmetric(
        horizontal: DimensSizeV2.d16,
        vertical: DimensSizeV2.d12,
      ),
      child: Row(
        children: [
          Container(
            width: DimensSizeV2.d40,
            height: DimensSizeV2.d40,
            decoration: BoxDecoration(
                color: theme.colors.backgroundAlpha,
                borderRadius: BorderRadius.circular(DimensRadiusV2.radius12)),
            child: Center(
              child: Icon(
                icon,
                color: theme.colors.content0,
                size: DimensSizeV2.d20,
              ),
            ),
          ),
          const SizedBox(width: DimensSizeV2.d8),
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                title,
                style: theme.textStyles.labelMedium.copyWith(
                  color: theme.colors.content0,
                ),
              ),
              const SizedBox(height: DimensSizeV2.d4),
              Text(
                description,
                style: theme.textStyles.labelXSmall.copyWith(
                  color: theme.colors.content3,
                ),
              ),
            ],
          ),
          const Spacer(),
          CommonCheckboxInput(checked: isSelected, onChanged: onChanged)
        ],
      ),
    );
  }
}
