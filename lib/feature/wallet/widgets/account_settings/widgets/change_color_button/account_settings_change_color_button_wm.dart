import 'package:app/app/service/identify/identy_icon_data.dart';
import 'package:app/core/wm/custom_wm.dart';
import 'package:app/feature/wallet/widgets/account_settings/widgets/change_color_bottom_sheet/change_color_bottom_sheet.dart';
import 'package:app/feature/wallet/widgets/account_settings/widgets/change_color_button/account_settings_change_color_button.dart';
import 'package:app/feature/wallet/widgets/account_settings/widgets/change_color_button/account_settings_change_color_button_model.dart';
import 'package:elementary/elementary.dart';
import 'package:elementary_helper/elementary_helper.dart';
import 'package:injectable/injectable.dart';

/// [WidgetModel] для [AccountSettingsChangeColorButton]
@injectable
class AccountSettingsChangeColorButtonWidgetModel extends InjectedWidgetModel<
    AccountSettingsChangeColorButton,
    AccountSettingsChangeColorButtonModel,
    String> {
  AccountSettingsChangeColorButtonWidgetModel(
    super.model,
  );

  ListenableState<IdentifyIconData> get colorState => model.colorState;

  @override
  void initWidgetModel() {
    super.initWidgetModel();
    model.initListener(wmParams.value);
  }

  void onPressed() {
    showChangeColorBottomSheet(
      context: context,
      address: wmParams.value,
    );
  }
}
