import 'package:app/app/service/identify/identy_icon_data.dart';
import 'package:app/core/error_handler_factory.dart';
import 'package:app/core/wm/custom_wm.dart';
import 'package:app/di/di.dart';
import 'package:app/feature/wallet/widgets/account_settings/widgets/change_color_bottom_sheet/change_color_bottom_sheet.dart';
import 'package:app/feature/wallet/widgets/account_settings/widgets/change_color_button/account_settings_change_color_button.dart';
import 'package:app/feature/wallet/widgets/account_settings/widgets/change_color_button/account_settings_change_color_button_model.dart';
import 'package:elementary/elementary.dart';
import 'package:elementary_helper/elementary_helper.dart';
import 'package:flutter/widgets.dart';

/// Factory method for creating [AccountSettingsChangeColorButtonWidgetModel]
AccountSettingsChangeColorButtonWidgetModel
    defaultAccountSettingsChangeColorButtonWidgetModelFactory(
  BuildContext context,
) {
  return AccountSettingsChangeColorButtonWidgetModel(
    AccountSettingsChangeColorButtonModel(
      createPrimaryErrorHandler(context),
      inject(),
    ),
  );
}

/// [WidgetModel] для [AccountSettingsChangeColorButton]
class AccountSettingsChangeColorButtonWidgetModel extends CustomWidgetModel<
    AccountSettingsChangeColorButton, AccountSettingsChangeColorButtonModel> {
  AccountSettingsChangeColorButtonWidgetModel(
    super.model,
  );

  ListenableState<IdentifyIconData> get colorState => model.colorState;

  @override
  void initWidgetModel() {
    super.initWidgetModel();
    model.initListener(widget.address);
  }

  void onPressed() {
    showChangeColorBottomSheet(
      context: context,
      address: widget.address,
    );
  }
}
