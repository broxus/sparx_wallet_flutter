import 'package:app/generated/generated.dart';
import 'package:flutter/material.dart';
import 'package:lucide_icons_flutter/lucide_icons.dart';
import 'package:ui_components_lib/ui_components_lib.dart';

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
        const SizedBox(width: DimensSize.d16),
        Icon(
          LucideIcons.lockKeyhole,
          color: theme.colors.content0,
          size: DimensSize.d16,
        ),
        const SizedBox(width: DimensSize.d12),
        Expanded(
          child: Text(
            name,
            style: theme.textStyles.labelMedium,
            overflow: TextOverflow.ellipsis,
          ),
        ),
        if (isLedger)
          Padding(
            padding: const EdgeInsets.only(left: DimensSize.d12),
            child: Assets.images.ledger.svg(
              width: DimensSize.d20,
              height: DimensSize.d20,
            ),
          ),
        const SizedBox(width: DimensSize.d12),
        Icon(
          isExpanded ? LucideIcons.chevronUp : LucideIcons.chevronDown,
          color: theme.colors.content0,
          size: DimensSize.d20,
        ),
        const SizedBox(width: DimensSize.d16),
      ],
    );
  }
}
