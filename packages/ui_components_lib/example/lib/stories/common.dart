import 'package:flutter/material.dart';
import 'package:ui_components_lib/ui_components_lib.dart';

/// Page with all colors
class CommonStory extends StatelessWidget {
  const CommonStory({super.key});

  @override
  Widget build(BuildContext context) {
    final colors = context.themeStyle.colors;

    return Scaffold(
      appBar: const DefaultAppBar(titleText: 'CommonWidgets'),
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const SizedBox(height: 30),
            DefaultAppBar(
              leading: DecoratedBox(
                decoration: BoxDecoration(
                  shape: BoxShape.circle,
                  color: colors.backgroundPrimary,
                ),
                child: Icon(Icons.ac_unit, color: colors.textContrast),
              ),
              titleText: 'Center title',
              subtitleTopText: 'TopSubtitle',
              subtitleBottomText: 'BottomSubtitle',
              actions: [
                CommonButton(
                  height: appBarButtonSize,
                  fillWidth: false,
                  buttonType: EverButtonType.ghost,
                  text: 'Action',
                  // ignore: no-empty-block
                  onPressed: () {},
                ),
              ],
            ),
            const SizedBox(height: 30),
            DefaultAppBar(
              leading: DecoratedBox(
                decoration: BoxDecoration(
                  shape: BoxShape.circle,
                  color: colors.backgroundPrimary,
                ),
                child: Icon(Icons.ac_unit, color: colors.textContrast),
              ),
              centerTitle: false,
              titleText: 'Not centered title',
              subtitleTopText: 'TopSubtitle',
              subtitleBottomWidget: CommonButton(
                height: DimensSize.d20,
                padding: EdgeInsets.zero,
                buttonType: EverButtonType.ghost,
                fillWidth: false,
                text: 'SubtitleBottom button',
                // ignore: no-empty-block
                onPressed: () {},
              ),
              actions: [
                CommonButton(
                  height: appBarButtonSize,
                  fillWidth: false,
                  buttonType: EverButtonType.ghost,
                  text: 'Action',
                  // ignore: no-empty-block
                  onPressed: () {},
                ),
                CommonIconButton.icon(
                  innerPadding: appBarIconButtonInnerPadding,
                  icon: Icons.access_alarm_sharp,
                  buttonType: EverButtonType.primary,
                  // ignore: no-empty-block
                  onPressed: () {},
                ),
              ],
            ),
            const SizedBox(height: DimensSize.d28),
            CommonCard(
              titleText: 'Card Title',
              leadingText: 'leading',
              trailingChild: CommonButtonIconWidget.icon(icon: Icons.delete),
            ),
            const SizedBox(height: DimensSize.d8),
            CommonCard(
              titleText: 'Card Title',
              leadingChild:
                  CommonButtonIconWidget.icon(icon: Icons.access_alarm_sharp),
              borderColor: colors.alert,
              trailingChild: CommonButtonIconWidget.icon(icon: Icons.delete),
            ),
            const SizedBox(height: DimensSize.d8),
            const Row(
              children: [
                Expanded(child: CommonCard(titleText: 'Card fill width')),
              ],
            ),
            const SizedBox(height: DimensSize.d8),
            CommonCard(
              titleText: 'Card Title',
              topSubtitleText: 'TopSubtitle',
              leadingChild:
                  CommonButtonIconWidget.icon(icon: Icons.access_alarm_sharp),
              trailingChild: CommonButtonIconWidget.icon(icon: Icons.delete),
            ),
          ],
        ),
      ),
    );
  }
}
