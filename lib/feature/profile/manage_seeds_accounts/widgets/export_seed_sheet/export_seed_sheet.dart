import 'package:app/core/wm/custom_wm.dart';
import 'package:app/feature/profile/manage_seeds_accounts/widgets/export_seed_sheet/export_seed_sheet_wm.dart';
import 'package:app/feature/profile/profile.dart';
import 'package:app/generated/generated.dart';
import 'package:flutter/material.dart';
import 'package:nekoton_repository/nekoton_repository.dart' hide Message;
import 'package:ui_components_lib/ui_components_lib.dart';

/// Helper method that shows the [ExportSeedSheet] bottom sheet.
ModalRoute<void> exportSeedSheetRoute(
  BuildContext context,
  PublicKey publicKey,
) {
  return commonBottomSheetRoute<void>(
    titleTextStyle: context.themeStyleV2.textStyles.headingLarge,
    title: LocaleKeys.enterPasswordTo.tr(
      args: [LocaleKeys.exportWord.tr().toLowerCase()],
    ),
    body: (_, __) => ExportSeedSheet(publicKey: publicKey),
  );
}

/// Sheet that allows user to enter password and export seed phrase.
class ExportSeedSheet extends InjectedElementaryParametrizedWidget<
    ExportSeedSheetWidgetModel, PublicKey> {
  const ExportSeedSheet({
    required PublicKey publicKey,
    super.key,
  }) : super(wmFactoryParam: publicKey);

  @override
  Widget build(ExportSeedSheetWidgetModel wm) {
    return EnterPasswordWidget(
      publicKey: wm.publicKey,
      title: LocaleKeys.exportWord.tr(),
      onPasswordEntered: wm.onPasswordEntered,
    );
  }
}
