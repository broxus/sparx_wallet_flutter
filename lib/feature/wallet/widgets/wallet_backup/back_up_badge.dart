import 'package:app/feature/wallet/widgets/wallet_backup/confirm_action/confirm_action_dialog.dart';
import 'package:app/generated/generated.dart';
import 'package:flutter/material.dart';
import 'package:lucide_icons_flutter/lucide_icons.dart';
import 'package:nekoton_repository/nekoton_repository.dart';
import 'package:ui_components_lib/v2/ui_components_lib_v2.dart';

class BackUpBadge extends StatelessWidget {
  const BackUpBadge({
    required this.currentAccount,
    required this.finishedBackupCallback,
    super.key,
  });

  final KeyAccount currentAccount;
  final VoidCallback finishedBackupCallback;

  @override
  Widget build(BuildContext context) {
    final theme = context.themeStyleV2;
    return GestureDetector(
      onTap: () {
        showConfirmActionDialog(
          context,
          currentAccount,
          finishedBackupCallback,
        );
      },
      child: Container(
        padding: const EdgeInsets.only(left: DimensSizeV2.d16),
        decoration: BoxDecoration(
          color: theme.colors.background1,
          borderRadius: BorderRadius.circular(DimensRadiusV2.radius16),
        ),
        child: Stack(
          children: [
            Padding(
              padding: const EdgeInsets.only(right: DimensSizeV2.d100),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const SizedBox(height: DimensSizeV2.d12),
                  Row(
                    children: [
                      Icon(
                        LucideIcons.triangleAlert,
                        size: DimensSizeV2.d20,
                        color: theme.colors.contentNegative,
                      ),
                      const SizedBox(width: DimensSizeV2.d8),
                      Text(
                        LocaleKeys.notBackedUpTitle.tr(),
                        style: theme.textStyles.headingXSmall,
                      ),
                    ],
                  ),
                  Text(
                    LocaleKeys.notBackedUpSubtitle.tr(),
                    style: theme.textStyles.paragraphXSmall,
                  ),
                  const SizedBox(height: DimensSizeV2.d16),
                ],
              ),
            ),
            Positioned.fill(
              child: Align(
                alignment: Alignment.centerRight,
                child: ClipRRect(
                  borderRadius: BorderRadius.circular(DimensRadiusV2.radius16),
                  child: Image.asset(
                    Assets.images.lockBackup.path,
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
