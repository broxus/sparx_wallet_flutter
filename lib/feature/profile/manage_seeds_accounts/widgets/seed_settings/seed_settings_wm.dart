import 'package:app/core/wm/custom_wm.dart';
import 'package:app/feature/loader_screen/loader_screen.dart';
import 'package:app/feature/messenger/data/message.dart';
import 'package:app/feature/profile/profile.dart';
import 'package:app/generated/generated.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:injectable/injectable.dart';
import 'package:nekoton_repository/nekoton_repository.dart' show PublicKey;
import 'package:ui_components_lib/ui_components_lib.dart';

@injectable
class SeedSettingsWidgetModel extends InjectedWidgetModel<SeedSettingsWidget,
    SeedSettingsModel, PublicKey> {
  SeedSettingsWidgetModel(
    super.model,
  );

  late final ValueListenable<PublicKey> publicKey =
      createWmParamsNotifier((it) => it);

  ThemeStyleV2 get theme => context.themeStyleV2;

  PublicKey? get currentKey => model.currentKey;

  void onChangeCurrentKey() {
    model.changeCurrentKey(publicKey.value);
    Navigator.of(context).pop();
  }

  void onRename() {
    Navigator.of(context)
      ..pop()
      ..push(showRenameSheet(context, publicKey.value, renameSeed: true));
  }

  void onExport() {
    Navigator.of(context)
      ..pop()
      ..push(exportSeedSheetRoute(context, publicKey.value));
  }

  void onChangePassword() {
    Navigator.of(context)
      ..pop()
      ..push(changeSeedPasswordSheetRoute(context, publicKey.value));
  }

  void onDelete() {
    Navigator.of(context)
      ..pop()
      ..push(deleteSeedSheetRoute(context, publicKey.value));
  }

  Future<void> onScan() async {
    final key = model.getMasterKey(publicKey.value);
    if (key == null) return;

    try {
      if (key.isLegacy) {
        await _triggerAddingAccounts(publicKey.value);
        return;
      }

      final password = await showEnterPasswordSheet(
        context: context,
        publicKey: publicKey.value,
      );
      if (password == null) return;

      await _triggerDerivingKeys(
        publicKey: publicKey.value,
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
