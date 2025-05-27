import 'dart:io';

import 'package:app/feature/browser_v2/data/tabs/browser_tab.dart';
import 'package:app/feature/browser_v2/screens/create_group/create_browser_group_screen_wm.dart';
import 'package:app/feature/browser_v2/screens/create_group/widgets/group_title_text_field.dart';
import 'package:app/generated/generated.dart';
import 'package:elementary/elementary.dart';
import 'package:elementary_helper/elementary_helper.dart';
import 'package:flutter/material.dart';
import 'package:ui_components_lib/components/button/app_bar_back_button.dart';
import 'package:ui_components_lib/ui_components_lib.dart';

class CreateBrowserGroupScreen
    extends ElementaryWidget<CreateBrowserGroupScreenWidgetModel> {
  CreateBrowserGroupScreen({
    String? tabId,
    WidgetModelFactory<CreateBrowserGroupScreenWidgetModel>? wmFactory,
    super.key,
  }) : super(
          wmFactory ??
              (ctx) => defaultCreateBrowserGroupScreenWidgetModelFactory(
                    ctx,
                    tabId: tabId,
                  ),
        );

  @override
  Widget build(CreateBrowserGroupScreenWidgetModel wm) {
    return Scaffold(
      backgroundColor: wm.colors.background0,
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.symmetric(
            vertical: DimensSizeV2.d12,
            horizontal: DimensSizeV2.d16,
          ),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              Flexible(
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    AppBarBackButton(onPressed: wm.onPressedBack),
                    Flexible(
                      child: Padding(
                        padding: const EdgeInsets.symmetric(
                          horizontal: DimensSizeV2.d10,
                        ),
                        child: GroupTitleTextField(
                          onEditingComplete: wm.onEditingComplete,
                        ),
                      ),
                    ),
                    const SizedBox(
                      width: DimensSizeV2.d48,
                    ),
                  ],
                ),
              ),
              DoubleSourceBuilder<BrowserTab?, File?>(
                firstSource: wm.tabState,
                secondSource: wm.screenShotState,
                builder: (_, BrowserTab? tab, File? file) {
                  if (tab == null) {
                    return const SizedBox.shrink();
                  }

                  return Align(
                    alignment: Alignment.topLeft,
                    child: Padding(
                      padding: const EdgeInsets.only(top: DimensSizeV2.d28),
                      child: _BrowserItem(
                        title: tab.title,
                        file: file,
                      ),
                    ),
                  );
                },
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class _BrowserItem extends StatelessWidget {
  const _BrowserItem({
    this.title,
    this.file,
  });

  final String? title;
  final File? file;

  @override
  Widget build(BuildContext context) {
    final themeStyle = context.themeStyleV2;
    final textStyles = themeStyle.textStyles;
    final colors = context.themeStyleV2.colors;

    return SizedBox(
      width: DimensSizeV2.d168,
      height: DimensSizeV2.d200,
      child: Material(
        shape: SquircleShapeBorder(
          borderWidth: DimensSizeV2.d2,
          cornerRadius: DimensRadiusV2.radius16,
          borderColor: colors.primaryA.withAlpha(25),
        ),
        clipBehavior: Clip.antiAlias,
        color: colors.background1,
        child: Stack(
          children: [
            OverflowBox(
              alignment: Alignment.topCenter,
              maxHeight: 1000,
              child: file == null
                  ? Assets.images.bgNetwork.image(width: double.infinity)
                  : Image.file(
                      file!,
                      fit: BoxFit.scaleDown,
                      errorBuilder: (_, __, ___) => const SizedBox(),
                    ),
            ),
            SizedBox(
              width: double.infinity,
              height: DimensSizeV2.d36,
              child: DecoratedBox(
                decoration: BoxDecoration(
                  color: colors.background2,
                ),
                child: Align(
                  alignment: Alignment.centerLeft,
                  child: Padding(
                    padding: const EdgeInsets.only(left: DimensSizeV2.d12),
                    child: Text(
                      title ?? '',
                      style: textStyles.labelXSmall.copyWith(
                        color: colors.content2,
                      ),
                      maxLines: 1,
                      overflow: TextOverflow.ellipsis,
                      softWrap: false,
                    ),
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
