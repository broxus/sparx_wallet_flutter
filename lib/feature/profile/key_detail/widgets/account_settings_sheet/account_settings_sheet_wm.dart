import 'package:app/core/wm/custom_wm.dart';
import 'package:app/feature/browser_v2/domain/browser_launcher.dart';
import 'package:app/feature/profile/key_detail/widgets/account_rename_sheet/account_rename_sheet.dart';
import 'package:app/feature/profile/key_detail/widgets/account_settings_sheet/account_settings_sheet.dart';
import 'package:app/feature/profile/key_detail/widgets/account_settings_sheet/account_settings_sheet_model.dart';
import 'package:app/feature/profile/key_detail/widgets/delete_account_sheet/delete_account_sheet.dart';
import 'package:elementary/elementary.dart';
import 'package:flutter/cupertino.dart';
import 'package:injectable/injectable.dart';
import 'package:nekoton_repository/nekoton_repository.dart';
import 'package:ui_components_lib/ui_components_lib.dart';

/// [WidgetModel] for [AccountSettingsSheet]
@injectable
class AccountSettingsSheetWidgetModel extends CustomWidgetModelParametrized<
    AccountSettingsSheet,
    AccountSettingsSheetModel,
    AccountSettingsSheetParams> {
  AccountSettingsSheetWidgetModel(
    super.model,
  );

  bool get isShowHiding => wmParams.value.showHiding;

  bool get isShowCopyAddress => wmParams.value.showCopyAddress;

  bool get isSeeInExplorer => wmParams.value.seeInExplorer;

  ColorsPaletteV2 get colors => context.themeStyleV2.colors;

  late final KeyAccount? account = model.getAccount(wmParams.value.address);

  void onPressedToggleVisibleWord() {
    Navigator.of(context).pop();
    if (account == null) {
      return;
    }

    if (account!.isHidden) {
      account!.show();
    } else {
      account!.hide();
    }
  }

  void onPressedRename() {
    Navigator.of(context)
      ..pop()
      ..push(
        getRenameAccountSheet(
          context,
          wmParams.value.address,
        ),
      );
  }

  void onPressedCopyAddress() {
    if (account == null) {
      return;
    }
    model.copyAddress(account!.address);
  }

  void onPressedSeeInExplorer() {
    if (account == null) {
      return;
    }
    Navigator.of(context).pop();
    model.openBrowserByString(account!.address);
  }

  void onPressedDeleteWord() {
    if (account == null) {
      return;
    }
    Navigator.of(context)
      ..pop()
      ..push(
        deleteAccountSheetRoute(context, account!),
      );
  }
}

class AccountSettingsSheetParams {
  AccountSettingsSheetParams({
    required this.address,
    required this.showHiding,
    required this.seeInExplorer,
    required this.showCopyAddress,
    required this.browserLauncher,
  });

  final Address address;

  final bool showHiding;

  final bool seeInExplorer;

  final bool showCopyAddress;
  final BrowserLauncher browserLauncher;
}
