import 'package:app/app/service/identify/identy_icon_data.dart';
import 'package:app/core/wm/custom_wm.dart';
import 'package:app/feature/wallet/widgets/account_settings/widgets/account_settings_button.dart';
import 'package:app/feature/wallet/widgets/account_settings/widgets/change_color_button/account_settings_change_color_button_wm.dart';
import 'package:app/generated/generated.dart';
import 'package:elementary_helper/elementary_helper.dart';
import 'package:flutter/material.dart';
import 'package:ui_components_lib/v2/dimens_v2.dart';

class AccountSettingsChangeColorButton
    extends InjectedElementaryParametrizedWidget<
        AccountSettingsChangeColorButtonWidgetModel, String> {
  const AccountSettingsChangeColorButton({
    required String address,
    super.key,
  }) : super(
          wmFactoryParam: address,
        );

  @override
  Widget build(AccountSettingsChangeColorButtonWidgetModel wm) {
    return StateNotifierBuilder<IdentifyIconData>(
      listenableState: wm.colorState,
      builder: (_, IdentifyIconData? ic) {
        return AccountSettingsButton(
          label: LocaleKeys.changeAvatarColor.tr(),
          iconWidget: SizedBox(
            width: DimensSizeV2.d18,
            height: DimensSizeV2.d18,
            child: DecoratedBox(
              decoration: BoxDecoration(
                color: ic?.color,
                borderRadius: BorderRadius.circular(DimensSizeV2.d18),
              ),
            ),
          ),
          onTap: wm.onPressed,
        );
      },
    );
  }
}
