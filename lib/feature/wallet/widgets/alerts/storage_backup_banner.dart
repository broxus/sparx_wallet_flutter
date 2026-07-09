import 'package:app/feature/wallet/widgets/storage_backup/storage_backup_sheet.dart';
import 'package:app/generated/generated.dart';
import 'package:flutter/material.dart';
import 'package:lucide_icons_flutter/lucide_icons.dart';
import 'package:ui_components_lib/ui_components_lib.dart';

/// Banner that suggests creating an encrypted backup of seeds and accounts.
///
/// Tapping the banner opens the [StorageBackupSheet] bottom sheet.
class StorageBackupBanner extends StatelessWidget {
  const StorageBackupBanner({super.key});

  @override
  Widget build(BuildContext context) {
    final theme = context.themeStyle;

    return GestureDetector(
      onTap: () => showStorageBackupSheet(context),
      child: Container(
        height: DimensSize.d124,
        padding: const EdgeInsets.symmetric(horizontal: DimensSize.d16),
        decoration: BoxDecoration(
          color: theme.colors.background1,
          borderRadius: BorderRadius.circular(DimensRadius.radius16),
        ),
        child: Row(
          spacing: DimensSize.d14,
          children: [
            Expanded(
              child: Column(
                mainAxisSize: MainAxisSize.min,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    LocaleKeys.storageBackupBannerTitle.tr(),
                    style: theme.textStyles.headingXSmall,
                  ),
                  const SizedBox(height: DimensSize.d4),
                  Text(
                    LocaleKeys.storageBackupBannerDescription.tr(),
                    style: theme.textStyles.paragraphXSmall.copyWith(
                      color: theme.colors.content1,
                    ),
                  ),
                ],
              ),
            ),
            Container(
              width: DimensSize.d48,
              height: DimensSize.d48,
              decoration: BoxDecoration(
                color: theme.colors.background2,
                shape: BoxShape.circle,
              ),
              child: Icon(
                LucideIcons.shieldCheck,
                size: DimensSize.d24,
                color: theme.colors.content0,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
