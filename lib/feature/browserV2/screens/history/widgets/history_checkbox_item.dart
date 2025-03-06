import 'package:flutter/material.dart';
import 'package:ui_components_lib/ui_components_lib.dart';

class HistoryCheckboxItem extends StatelessWidget {
  const HistoryCheckboxItem({
    super.key,
    required this.title,
    required this.isSelected,
    required this.onChanged,
  });

  final String title;
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
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(
            title,
            style: theme.textStyles.labelMedium.copyWith(
              color: isSelected ? theme.colors.content0 : theme.colors.content2,
            ),
          ),
          CommonCheckboxInput(checked: isSelected, onChanged: onChanged)
        ],
      ),
    );
  }
}
