import 'package:app/widgets/user_avatar/user_avatar.dart';
import 'package:flutter/material.dart';
import 'package:nekoton_repository/nekoton_repository.dart' show KeyAccount;
import 'package:ui_components_lib/ui_components_lib.dart';

class AccountInfo extends StatelessWidget {
  const AccountInfo({
    required this.account,
    this.color,
    this.subtitle,
    super.key,
  });

  final KeyAccount account;
  final Color? color;
  final Widget? subtitle;

  @override
  Widget build(BuildContext context) {
    final theme = context.themeStyleV2;
    final address = account.address.toEllipseString();
    final pk = account.publicKey.toEllipseString();

    final defautSubtitle = Text(
      '$address • $pk',
      style: theme.textStyles.labelXSmall.copyWith(
        color: theme.colors.content3,
      ),
    );

    return ShapedContainerRow(
      color: color ?? theme.colors.background1,
      squircleRadius: DimensSizeV2.d16,
      margin: EdgeInsets.zero,
      padding: const EdgeInsets.symmetric(
        horizontal: DimensSizeV2.d16,
        vertical: DimensSizeV2.d12,
      ),
      children: [
        UserAvatar(
          address: account.address.address,
        ),
        Flexible(
          child: SeparatedColumn(
            spacing: DimensSizeV2.d4,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                account.name,
                style: theme.textStyles.labelMedium,
                overflow: TextOverflow.ellipsis,
                softWrap: false,
                maxLines: 1,
              ),
              subtitle ?? defautSubtitle,
            ],
          ),
        ),
      ],
    );
  }
}
