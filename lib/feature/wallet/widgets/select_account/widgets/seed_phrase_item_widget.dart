import 'package:app/generated/generated.dart';
import 'package:flutter/material.dart';
import 'package:lucide_icons_flutter/lucide_icons.dart';
import 'package:ui_components_lib/v2/ui_components_lib_v2.dart';

class SeedPhraseItemWidget extends StatelessWidget {
  const SeedPhraseItemWidget({
    required this.name,
    required this.isExpanded,
    required this.isLedger,
    super.key,
  });

  final String name;
  final bool isExpanded;
  final bool isLedger;

  @override
  Widget build(BuildContext context) {
    final theme = context.themeStyleV2;
    return Row(
      children: [
        const SizedBox(width: DimensSizeV2.d16),
        Icon(
          LucideIcons.lockKeyhole,
          color: theme.colors.content0,
          size: DimensSizeV2.d16,
        ),
        const SizedBox(width: DimensSizeV2.d12),
        Expanded(
          child: Text(
            name,
            style: theme.textStyles.labelMedium,
            overflow: TextOverflow.ellipsis,
          ),
        ),
        if (isLedger)
          Padding(
            padding: const EdgeInsets.only(left: DimensSizeV2.d12),
            child: Assets.images.ledger.svg(
              width: DimensSizeV2.d20,
              height: DimensSizeV2.d20,
            ),
          ),
        const SizedBox(width: DimensSizeV2.d12),
        Icon(
          isExpanded ? LucideIcons.chevronUp : LucideIcons.chevronDown,
          color: theme.colors.content0,
          size: DimensSizeV2.d20,
        ),
        const SizedBox(width: DimensSizeV2.d16),
      ],
    );
  }
}
