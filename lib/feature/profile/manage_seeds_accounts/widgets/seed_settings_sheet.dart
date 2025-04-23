import 'package:app/feature/profile/profile.dart';
import 'package:app/generated/generated.dart';
import 'package:flutter/material.dart';
import 'package:nekoton_repository/nekoton_repository.dart';
import 'package:ui_components_lib/ui_components_lib.dart';

/// Helper function that shows [SeedSettingsWidget]
void showSeedSettingsSheet(
  BuildContext context,
  PublicKey publicKey,
) {
  showCommonBottomSheet<void>(
    context: context,
    titleTextStyle: context.themeStyleV2.textStyles.headingLarge,
    title: LocaleKeys.settingsOfSeed.tr(),
    body: (_, __) => SeedSettingsWidget(publicKey: publicKey),
  );
}
