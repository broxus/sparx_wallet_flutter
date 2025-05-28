import 'dart:io';

import 'package:app/feature/browser_v2/data/tabs/browser_tab.dart';
import 'package:app/feature/browser_v2/screens/create_group/create_browser_group_screen_wm.dart';
import 'package:app/feature/browser_v2/screens/create_group/widgets/group_title_text_field.dart';
import 'package:app/generated/generated.dart';
import 'package:elementary/elementary.dart';
import 'package:elementary_helper/elementary_helper.dart';
import 'package:flutter/material.dart';
import 'package:lucide_icons_flutter/lucide_icons.dart';
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
          child: SizedBox(
            height: wm.screenHeight,
            child: Stack(
              children: [
                Column(
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
                                onChangeText: wm.onChangeText,
                                onEditingComplete: wm.onEditingComplete,
                                onOverflowLength: wm.onOverflowLength,
                                maxLength: wm.maxLength,
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
                            padding:
                                const EdgeInsets.only(top: DimensSizeV2.d28),
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
                Positioned(
                  bottom: 0,
                  left: 0,
                  right: 0,
                  child: StateNotifierBuilder<bool>(
                    listenableState: wm.errorState,
                    builder: (_, bool? isShowError) {
                      isShowError ??= false;
                      return isShowError
                          ? _Error(
                              LocaleKeys.maxCharactersAllowed.tr(
                                args: [
                                  wm.maxLength.toString(),
                                ],
                              ),
                            )
                          : const SizedBox.shrink();
                    },
                  ),
                ),
              ],
            ),
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

class _Error extends StatelessWidget {
  const _Error(
    this.errorText,
  );

  final String errorText;

  @override
  Widget build(BuildContext context) {
    final theme = context.themeStyleV2;

    return SizedBox(
      width: double.infinity,
      height: DimensSizeV2.d48,
      child: DecoratedBox(
        decoration: BoxDecoration(
          color: ColorsResV2.e15,
          borderRadius: BorderRadius.circular(DimensRadiusV2.radius8),
        ),
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: DimensSizeV2.d16),
          child: Row(
            spacing: DimensSizeV2.d12,
            children: [
              const Icon(
                LucideIcons.circleCheck,
                size: DimensSizeV2.d24,
                color: ColorsResV2.e50,
              ),
              Text(
                errorText,
                style: theme.textStyles.labelMedium.copyWith(
                  color: ColorsResV2.e50,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
