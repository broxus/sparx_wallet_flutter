import 'package:app/core/wm/custom_wm.dart';
import 'package:app/feature/ledger/ledger.dart';
import 'package:app/feature/loader_screen/loader_screen.dart';
import 'package:app/feature/messenger/data/message.dart';
import 'package:app/feature/profile/profile.dart';
import 'package:app/generated/generated.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:injectable/injectable.dart';
import 'package:nekoton_repository/nekoton_repository.dart' hide Message;
import 'package:ui_components_lib/ui_components_lib.dart';

@injectable
class SeedSettingsWidgetModel extends CustomWidgetModelParametrized<
    SeedSettingsWidget,
    SeedSettingsModel,
    PublicKey> with BleAvailabilityWmMixin {
  SeedSettingsWidgetModel(
    super.model,
  );

  late final publicKeyState = createWmParamsNotifier((it) => it);

  SeedKey? get seedKey => model.getMasterKey(publicKeyState.value);

  ThemeStyleV2 get theme => context.themeStyleV2;

  PublicKey? get currentKey => model.currentKey;

  void onChangeCurrentKey() {
    model.changeCurrentKey(publicKeyState.value);
    Navigator.of(context).pop();
  }

  void onRename() {
    Navigator.of(context)
      ..pop()
      ..push(showRenameSheet(context, publicKeyState.value, renameSeed: true));
  }

  void onExport() {
    Navigator.of(context)
      ..pop()
      ..push(exportSeedSheetRoute(context, publicKeyState.value));
  }

  void onChangePassword() {
    Navigator.of(context)
      ..pop()
      ..push(changeSeedPasswordSheetRoute(context, publicKeyState.value));
  }

  void onDelete() {
    Navigator.of(context)
      ..pop()
      ..push(deleteSeedSheetRoute(context, publicKeyState.value));
  }

  Future<void> onScan() async {
    final key = model.getMasterKey(publicKeyState.value);
    if (key == null) return;

    if (key.isLedger) {
      final isAvailable = await checkBluetoothAvailability();
      if (!isAvailable) return;
    }

    try {
      if (key.isLegacy) {
        await _triggerAddingAccounts(publicKeyState.value);
        return;
      }

      String? password;
      if (!key.isLedger) {
        if (contextSafe == null) return;

        password = await showEnterPasswordSheet(
          context: contextSafe!,
          publicKey: publicKeyState.value,
        );

        if (password == null) return;
      }

      await _triggerDerivingKeys(
        publicKey: publicKeyState.value,
        password: password,
      );

      model.showMessage(
        Message.successful(
          message: LocaleKeys.scanningCompleted.tr(),
          duration: const Duration(seconds: 2),
        ),
      );
    } on OperationCanceledException {
      // User canceled the operation, do nothing
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
    String? password,
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
