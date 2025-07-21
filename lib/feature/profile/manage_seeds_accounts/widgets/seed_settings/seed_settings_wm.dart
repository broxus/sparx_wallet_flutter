import 'package:app/core/error_handler_factory.dart';
import 'package:app/core/wm/custom_wm.dart';
import 'package:app/di/di.dart';
import 'package:app/feature/loader_screen/loader_screen.dart';
import 'package:app/feature/messenger/data/message.dart';
import 'package:app/feature/profile/profile.dart';
import 'package:app/generated/generated.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:nekoton_repository/nekoton_repository.dart' show PublicKey;
import 'package:ui_components_lib/ui_components_lib.dart';

SeedSettingsWidgetModel defaultSeedSettingsWidgetModelFactory(
  BuildContext context,
) =>
    SeedSettingsWidgetModel(
      SeedSettingsModel(
        createPrimaryErrorHandler(context),
        inject(),
        inject(),
        inject(),
      ),
    );

class SeedSettingsWidgetModel
    extends CustomWidgetModel<SeedSettingsWidget, SeedSettingsModel> {
  SeedSettingsWidgetModel(super.model);

  ThemeStyleV2 get theme => context.themeStyleV2;

  PublicKey? get currentKey => model.currentKey;

  void onChangeCurrentKey() {
    model.changeCurrentKey(widget.publicKey);
    Navigator.of(context).pop();
  }

  void onRename() {
    Navigator.of(context)
      ..pop()
      ..push(showRenameSheet(context, widget.publicKey, renameSeed: true));
  }

  void onExport() {
    Navigator.of(context)
      ..pop()
      ..push(exportSeedSheetRoute(context, widget.publicKey));
  }

  void onChangePassword() {
    Navigator.of(context)
      ..pop()
      ..push(changeSeedPasswordSheetRoute(context, widget.publicKey));
  }

  void onDelete() {
    Navigator.of(context)
      ..pop()
      ..push(deleteSeedSheetRoute(context, widget.publicKey));
  }

  Future<void> onScan() async {
    final key = model.getMasterKey(widget.publicKey);
    if (key == null) return;

    try {
      if (key.isLegacy) {
        await _triggerAddingAccounts(widget.publicKey);
        return;
      }

      // TODO(komarov): ledger support
      final password = await showEnterPasswordSheet(
        context: context,
        publicKey: widget.publicKey,
      );
      if (password == null) return;

      await _triggerDerivingKeys(
        publicKey: widget.publicKey,
        password: password,
      );

      model.showMessage(
        Message.successful(
          message: LocaleKeys.scanningCompleted.tr(),
          duration: const Duration(seconds: 2),
        ),
      );
    } catch (e) {
      model.showMessage(Message.error(message: e.toString()));
    } finally {
      contextSafe?.pop();
    }
  }

  Future<void> _triggerAddingAccounts(PublicKey publicKey) async {
    final hideLoader = showLoaderScreen(
      context,
      title: LocaleKeys.scanSeedLoaderTitle.tr(),
    );

    try {
      await model.triggerAddingAccounts(publicKey);
    } finally {
      hideLoader();
    }
  }

  Future<void> _triggerDerivingKeys({
    required PublicKey publicKey,
    required String password,
  }) async {
    final hideLoader = showLoaderScreen(
      context,
      title: LocaleKeys.scanSeedLoaderTitle.tr(),
    );

    try {
      await model.triggerDerivingKeys(
        masterKey: publicKey,
        password: password,
      );
    } finally {
      hideLoader();
    }
  }
}
