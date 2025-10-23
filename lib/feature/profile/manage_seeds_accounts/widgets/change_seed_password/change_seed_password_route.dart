import 'package:app/feature/profile/manage_seeds_accounts/widgets/change_seed_password/change_seed_password.dart';
import 'package:app/generated/generated.dart';
import 'package:app/widgets/widgets.dart';
import 'package:flutter/material.dart';
import 'package:nekoton_repository/nekoton_repository.dart';
import 'package:ui_components_lib/ui_components_lib.dart';

ModalRoute<void> changeSeedPasswordSheetRoute(
  BuildContext context,
  PublicKey publicKey,
) {
  return commonBottomSheetRoute<void>(
    titleTextStyle: context.themeStyleV2.textStyles.headingLarge,
    title: LocaleKeys.changeSeedPassword.tr(),
    body: (_, __) =>
        ProtectedContent(child: ChangeSeedPasswordSheet(publicKey: publicKey)),
  );
}
