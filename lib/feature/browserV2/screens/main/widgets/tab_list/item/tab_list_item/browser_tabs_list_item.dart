import 'dart:io';

import 'package:app/feature/browserV2/models/tab/browser_tab.dart';
import 'package:app/feature/browserV2/screens/main/widgets/tab_list/item/tab_list_item/browser_tabs_list_item_wm.dart';
import 'package:app/generated/generated.dart';
import 'package:elementary/elementary.dart';
import 'package:elementary_helper/elementary_helper.dart';
import 'package:flutter/material.dart';
import 'package:ui_components_lib/ui_components_lib.dart';

class BrowserTabsListItem
    extends ElementaryWidget<BrowserTabsListItemWidgetModel> {
  const BrowserTabsListItem({
    required this.tab,
    this.onPressed,
    this.onClosePressed,
    super.key,
    WidgetModelFactory<BrowserTabsListItemWidgetModel> wmFactory =
        defaultBrowserTabsListItemWidgetModelFactory,
  }) : super(wmFactory);

  final BrowserTab tab;
  final VoidCallback? onPressed;
  final VoidCallback? onClosePressed;

  @override
  Widget build(BrowserTabsListItemWidgetModel wm) {
    return SizedBox(
      child: Material(
        shape: const SquircleShapeBorder(cornerRadius: DimensRadius.medium),
        clipBehavior: Clip.antiAlias,
        color: wm.colors.background1,
        child: InkWell(
          onTap: onPressed,
          child: StateNotifierBuilder<bool?>(
            listenableState: wm.activeState,
            builder: (_, bool? isActive) {
              return DecoratedBox(
                decoration: BoxDecoration(
                  border: Border.all(
                    // todo color
                    color: isActive ?? false ? Colors.red : Colors.transparent,
                  ),
                ),
                child: Stack(
                  children: [
                    OverflowBox(
                      alignment: Alignment.topCenter,
                      maxHeight: 1000,
                      child: StateNotifierBuilder<File?>(
                        listenableState: wm.screenShotState,
                        builder: (_, File? file) {
                          return file == null
                              ? const _EmptyContent()
                              : Image.file(
                                  file,
                                  fit: BoxFit.scaleDown,
                                  errorBuilder: (_, __, ___) =>
                                      const SizedBox(),
                                );
                        },
                      ),
                    ),
                    _Header(
                      titleState: wm.titleState,
                      onPressedClose: onClosePressed,
                    ),
                  ],
                ),
              );
            },
          ),
        ),
      ),
    );
  }
}

class _Header extends StatelessWidget {
  const _Header({
    required this.titleState,
    this.onPressedClose,
  });

  final ListenableState<String?> titleState;

  final VoidCallback? onPressedClose;

  @override
  Widget build(BuildContext context) {
    final themeStyle = context.themeStyleV2;
    final textStyles = themeStyle.textStyles;
    final colors = context.themeStyleV2.colors;

    return SizedBox(
      height: DimensSizeV2.d36,
      child: DecoratedBox(
        decoration: BoxDecoration(
          border: Border(
            top: BorderSide(color: colors.borderAlpha),
            left: BorderSide(color: colors.borderAlpha),
            right: BorderSide(color: colors.borderAlpha),
          ),
          borderRadius: const BorderRadius.only(
            topLeft: Radius.circular(DimensRadiusV2.radius16),
            topRight: Radius.circular(DimensRadiusV2.radius16),
          ),
        ),
        child: Row(
          children: [
            Expanded(
              child: Padding(
                padding: const EdgeInsets.only(left: DimensSizeV2.d12),
                child: StateNotifierBuilder<String?>(
                  listenableState: titleState,
                  builder: (_, String? title) {
                    return Text(
                      title ?? '',
                      style: textStyles.labelXSmall,
                      maxLines: 1,
                      overflow: TextOverflow.ellipsis,
                      softWrap: false,
                    );
                  },
                ),
              ),
            ),
            GestureDetector(
              onTap: onPressedClose,
              child: Padding(
                padding: const EdgeInsets.symmetric(
                  vertical: DimensSizeV2.d11,
                  horizontal: DimensSizeV2.d15,
                ),
                child: CommonIconWidget.svg(
                  svg: Assets.images.closeAnother.path,
                  size: DimensSizeV2.d20,
                  color: colors.content3,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class _EmptyContent extends StatelessWidget {
  const _EmptyContent({super.key});

  @override
  Widget build(BuildContext context) {
    return Assets.images.bgNetwork.image(width: double.infinity);
  }
}
