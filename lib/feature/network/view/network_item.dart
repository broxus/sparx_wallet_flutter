import 'package:app/app/service/connection/data/connection/connection.dart';
import 'package:app/widgets/network_icon.dart';
import 'package:flutter/material.dart';
import 'package:ui_components_lib/ui_components_lib.dart';

class NetworkItem extends StatelessWidget {
  const NetworkItem({
    required this.data,
    this.padding = const EdgeInsets.symmetric(
      vertical: DimensSizeV2.d12,
    ),
    this.trailing,
    this.onTap,
    super.key,
  });

  final Connection data;
  final Widget? trailing;
  final EdgeInsetsGeometry padding;
  final VoidCallback? onTap;

  @override
  Widget build(BuildContext context) {
    final theme = context.themeStyleV2;

    return GestureDetector(
      onTap: onTap,
      behavior: HitTestBehavior.translucent,
      child: Padding(
        padding: padding,
        child: SeparatedRow(
          children: [
            NetworkIcon(group: data.defaultWorkchain.networkGroup),
            Expanded(
              child: Text(
                data.networkName,
                style: theme.textStyles.labelMedium.copyWith(
                  color: theme.colors.content0,
                ),
                overflow: TextOverflow.ellipsis,
                softWrap: false,
                maxLines: 1,
              ),
            ),
            if (trailing != null) trailing!,
          ],
        ),
      ),
    );
  }
}
