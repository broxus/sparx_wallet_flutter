import 'package:app/app/service/connection/data/connection/connection.dart';
import 'package:app/app/service/connection/data/work_chain/connection_work_chain.dart';
import 'package:app/widgets/network_icon.dart';
import 'package:flutter/material.dart';
import 'package:ui_components_lib/ui_components_lib.dart';

class NetworkItem extends StatelessWidget {
  const NetworkItem({
    required this.networkGroup,
    required this.title,
    EdgeInsets? padding,
    this.trailing,
    this.onTap,
    super.key,
  }) : padding = padding ??
            const EdgeInsets.symmetric(
              vertical: DimensSizeV2.d12,
            );

  NetworkItem.formConnection({
    required Connection data,
    EdgeInsets? padding,
    Widget? trailing,
    VoidCallback? onTap,
    Key? key,
  }) : this(
          networkGroup: data.defaultWorkchain.networkGroup,
          title: data.networkName,
          padding: padding,
          trailing: trailing,
          onTap: onTap,
          key: key,
        );

  NetworkItem.formWorkchain({
    required ConnectionWorkchain data,
    EdgeInsets? padding,
    Widget? trailing,
    VoidCallback? onTap,
    Key? key,
  }) : this(
          networkGroup: data.networkGroup,
          title: '${data.networkName} id: ${data.id}',
          padding: padding,
          trailing: trailing,
          onTap: onTap,
          key: key,
        );

  final String networkGroup;
  final String title;
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
            NetworkIcon(group: networkGroup),
            Expanded(
              child: Text(
                title,
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
