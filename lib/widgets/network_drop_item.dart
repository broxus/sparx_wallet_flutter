import 'package:app/app/service/service.dart';
import 'package:app/widgets/network_icon.dart';
import 'package:flutter/material.dart';
import 'package:lucide_icons_flutter/lucide_icons.dart';
import 'package:ui_components_lib/ui_components_lib.dart';

class NetworkDropItem extends StatelessWidget {
  const NetworkDropItem({required this.data, super.key});

  final Connection data;

  @override
  Widget build(BuildContext context) {
    final theme = context.themeStyleV2;

    return Container(
      padding: const EdgeInsets.only(
        left: DimensSize.d4,
        top: DimensSize.d4,
        bottom: DimensSize.d4,
        right: DimensSize.d8,
      ),
      decoration: BoxDecoration(
        color: theme.colors.backgroundAlpha,
        borderRadius: BorderRadius.circular(DimensRadius.theBiggest),
      ),
      child: Row(
        children: [
          NetworkIcon(group: data.group, itemSize: DimensSize.d28),
          const SizedBox(width: DimensSize.d4),
          const Icon(LucideIcons.chevronDown, size: DimensSize.d20),
        ],
      ),
    );
  }
}
