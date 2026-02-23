import 'package:app/core/wm/custom_wm.dart';
import 'package:app/core/wm/not_null_listenable_state.dart';
import 'package:app/feature/root_device_alert/view/root_device_alert_screen_wm.dart';
import 'package:app/generated/generated.dart';
import 'package:elementary_helper/elementary_helper.dart';
import 'package:flutter/material.dart';
import 'package:lucide_icons_flutter/lucide_icons.dart';
import 'package:ui_components_lib/components/input/common_checkbox.dart';
import 'package:ui_components_lib/dimens.dart';
import 'package:ui_components_lib/v2/ui_components_lib_v2.dart';

class RootDeviceAlertScreen
    extends InjectedElementaryWidget<RootDeviceAlertScreenWidgetModel> {
  const RootDeviceAlertScreen({super.key});

  @override
  Widget build(RootDeviceAlertScreenWidgetModel wm) {
    return Scaffold(
      body: SafeArea(
        child: Stack(
          children: [
            Assets.images.lockBg.lock.image(width: double.infinity),
            SizedBox(
              height: double.infinity,
              child: Padding(
                padding: const EdgeInsets.all(DimensSize.d16),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: [
                    Text(
                      LocaleKeys.rootDetectedTitle.tr(),
                      style: wm.titleStyle,
                    ),
                    const SizedBox(height: DimensSize.d8),
                    Text(
                      LocaleKeys.rootDetectedDescription.tr(),
                      style: wm.descriptionStyle,
                      textAlign: TextAlign.center,
                    ),
                    const SizedBox(height: DimensSize.d24),
                    _Info(
                      acceptState: wm.acceptState,
                      onPressedInfo: wm.onPressedInfo,
                      onPressedAccept: wm.onPressedAccept,
                    ),
                    const SizedBox(height: DimensSize.d24),
                    StateNotifierBuilder(
                      listenableState: wm.acceptState,
                      builder: (_, bool? isSelected) {
                        isSelected ??= false;
                        return AccentButton(
                          buttonShape: ButtonShape.pill,
                          title: LocaleKeys.continueWord.tr(),
                          onPressed: isSelected ? wm.onPressedNext : null,
                        );
                      },
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  // Widget build(RootDeviceAlertScreenWidgetModel wm) {
  //   return Scaffold(
  //     body: Padding(
  //       padding: const EdgeInsets.all(DimensSize.d20),
  //       child: Column(
  //         mainAxisAlignment: MainAxisAlignment.center,
  //         crossAxisAlignment: CrossAxisAlignment.stretch,
  //         children: [
  //           const Text('TODO App is Root'),
  //           const SizedBox(height: DimensSize.d8),
  //           GestureDetector(
  //             behavior: HitTestBehavior.opaque,
  //             onTap: wm.onChangedCheckBox,
  //             child: Row(
  //               children: [
  //                 StateNotifierBuilder(
  //                   listenableState: wm.understandState,
  //                   builder: (_, bool? isSelected) {
  //                     return CommonCheckbox(checked: isSelected ?? false);
  //                   },
  //                 ),
  //                 const Text('TODO I understand'),
  //               ],
  //             ),
  //           ),
  //           const SizedBox(height: DimensSize.d8),
  //           StateNotifierBuilder(
  //             listenableState: wm.understandState,
  //             builder: (_, bool? isSelected) {
  //               isSelected ??= false;
  //               return PrimaryButton(
  //                 buttonShape: ButtonShape.pill,
  //                 title: 'TODO next',
  //                 onPressed: isSelected ? wm.onPressedNext : null,
  //               );
  //             },
  //           ),
  //         ],
  //       ),
  //     ),
  //   );
  // }
}

class _Info extends StatelessWidget {
  const _Info({
    required this.acceptState,
    required this.onPressedInfo,
    required this.onPressedAccept,
  });

  final NotNullListenableState<bool> acceptState;

  final VoidCallback onPressedInfo;
  final VoidCallback onPressedAccept;

  @override
  Widget build(BuildContext context) {
    return PrimaryCard(
      color: context.themeStyleV2.colors.background2,
      padding: EdgeInsets.zero,
      borderRadius: BorderRadius.circular(DimensRadius.radius12),
      child: Column(
        children: [
          _InfoItem(
            padding: const EdgeInsets.symmetric(
              vertical: DimensSize.d12,
              horizontal: DimensSize.d16,
            ),
            title: LocaleKeys.rootDetectedRisk.tr(),
            label: const Icon(LucideIcons.info, size: DimensSize.d20),
            onPressed: onPressedInfo,
          ),
          const Divider(height: .5, color: ColorsResV2.gray55),
          _InfoItem(
            padding: const EdgeInsets.symmetric(
              vertical: DimensSize.d14,
              horizontal: DimensSize.d16,
            ),
            title: LocaleKeys.rootDetectedAccept.tr(),
            label: StateNotifierBuilder(
              listenableState: acceptState,
              builder: (_, bool? isSelected) {
                return CommonCheckbox(checked: isSelected ?? false);
              },
            ),

            onPressed: onPressedAccept,
          ),
        ],
      ),
    );
  }
}

class _InfoItem extends StatelessWidget {
  const _InfoItem({
    required this.padding,
    required this.title,
    required this.label,
    required this.onPressed,
  });

  final EdgeInsets padding;
  final String title;
  final Widget label;
  final VoidCallback onPressed;

  @override
  Widget build(BuildContext context) {
    final theme = context.themeStyleV2;

    return GestureDetector(
      behavior: HitTestBehavior.opaque,
      onTap: onPressed,
      child: Padding(
        padding: padding,
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(
              title,
              style: theme.textStyles.paragraphSmall.copyWith(
                color: theme.colors.primaryA,
              ),
            ),
            label,
          ],
        ),
      ),
    );
  }
}
