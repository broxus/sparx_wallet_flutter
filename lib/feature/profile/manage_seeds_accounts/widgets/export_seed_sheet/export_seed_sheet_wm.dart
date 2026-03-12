import 'package:app/core/wm/custom_wm.dart';
import 'package:app/feature/profile/manage_seeds_accounts/widgets/export_seed_sheet/export_seed_save_phrase.dart';
import 'package:app/feature/profile/manage_seeds_accounts/widgets/export_seed_sheet/export_seed_sheet.dart';
import 'package:app/feature/profile/manage_seeds_accounts/widgets/export_seed_sheet/export_seed_sheet_model.dart';
import 'package:app/generated/generated.dart';
import 'package:elementary_helper/elementary_helper.dart';
import 'package:flutter/material.dart';
import 'package:injectable/injectable.dart';
import 'package:nekoton_repository/nekoton_repository.dart';
import 'package:ui_components_lib/ui_components_lib.dart';

@injectable
class ExportSeedSheetWidgetModel
    extends
        CustomWidgetModelParametrized<
          ExportSeedSheet,
          ExportSeedSheetModel,
          PublicKey
        > {
  ExportSeedSheetWidgetModel(super.model);

  late final _activeBtnState = createNotifier<bool>(false);

  ListenableState<bool> get activeBtnState => _activeBtnState;

  PublicKey get publicKey => wmParams.value;

  void onChangedText(String? text) {
    _activeBtnState.accept(text?.isNotEmpty ?? false);
  }

  Future<void> onPasswordEntered(String password) async {
    try {
      final phrase = await model.exportSeedPhrase(publicKey, password);
      if (contextSafe == null) return;
      // Close the current sheet and open the save phrase sheet
      Navigator.of(contextSafe!).pop();

      final textStyles = contextSafe!.themeStyleV2.textStyles;

      await Navigator.of(contextSafe!).push(
        exportSeedSavePhraseRoute(
          textStyles.headingLarge,
          textStyles.paragraphMedium.copyWith(color: ColorsResV2.m80),
          phrase,
        ),
      );
    } on SeedMissingException {
      model.showError(LocaleKeys.seedIsMissing.tr());
    } on WrongPasswordException {
      model.showError(LocaleKeys.passwordIsWrong.tr());
    } catch (e) {
      model.showError(e.toString());
    }
  }
}
