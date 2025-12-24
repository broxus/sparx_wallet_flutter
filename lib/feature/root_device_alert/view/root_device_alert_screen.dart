import 'package:app/core/wm/custom_wm.dart';
import 'package:app/feature/root_device_alert/view/root_device_alert_screen_wm.dart';
import 'package:elementary_helper/elementary_helper.dart';
import 'package:flutter/material.dart';
import 'package:ui_components_lib/components/input/common_checkbox.dart';
import 'package:ui_components_lib/v2/ui_components_lib_v2.dart';

class RootDeviceAlertScreen
    extends InjectedElementaryWidget<RootDeviceAlertScreenWidgetModel> {
  const RootDeviceAlertScreen({super.key});

  @override
  Widget build(RootDeviceAlertScreenWidgetModel wm) {
    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.all(DimensSizeV2.d20),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            const Text('TODO App is Root'),
            const SizedBox(height: DimensSizeV2.d8),
            GestureDetector(
              behavior: HitTestBehavior.opaque,
              onTap: wm.onChangedCheckBox,
              child: Row(
                children: [
                  StateNotifierBuilder(
                    listenableState: wm.understandState,
                    builder: (_, bool? isSelected) {
                      return CommonCheckbox(checked: isSelected ?? false);
                    },
                  ),
                  const Text('TODO I understand'),
                ],
              ),
            ),
            const SizedBox(height: DimensSizeV2.d8),
            StateNotifierBuilder(
              listenableState: wm.understandState,
              builder: (_, bool? isSelected) {
                isSelected ??= false;
                return PrimaryButton(
                  buttonShape: ButtonShape.pill,
                  title: 'TODO next',
                  onPressed: isSelected ? wm.onPressedNext : null,
                );
              },
            ),
          ],
        ),
      ),
    );
  }
}
