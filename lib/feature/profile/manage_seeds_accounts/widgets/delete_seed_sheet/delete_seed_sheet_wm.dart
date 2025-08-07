import 'package:app/core/wm/custom_wm.dart';
import 'package:app/feature/profile/manage_seeds_accounts/widgets/delete_seed_sheet/delete_seed_sheet.dart';
import 'package:app/feature/profile/manage_seeds_accounts/widgets/delete_seed_sheet/delete_seed_sheet_model.dart';
import 'package:elementary/elementary.dart';
import 'package:flutter/material.dart';
import 'package:injectable/injectable.dart';
import 'package:nekoton_repository/nekoton_repository.dart';
import 'package:ui_components_lib/ui_components_lib.dart';

/// [WidgetModel] for [DeleteSeedSheet]
@injectable
class DeleteSeedSheetWidgetModel extends CustomWidgetModelParametrized<
    DeleteSeedSheet, DeleteSeedSheetModel, DeleteSeedSheetParams> {
  DeleteSeedSheetWidgetModel(
    super.model,
  );

  ColorsPaletteV2 get colors => context.themeStyleV2.colors;

  Seed? get seed => model.getSeedByKey(wmParams.value.publicKey);

  void onPressedDeleteWord() {
    model.removeSeed(wmParams.value.publicKey);
    Navigator.of(context).pop();
  }

  void onPressedCancelWord() => Navigator.of(context).pop();
}

class DeleteSeedSheetParams {
  DeleteSeedSheetParams(this.publicKey);

  final PublicKey publicKey;
}
