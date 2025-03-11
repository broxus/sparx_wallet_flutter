import 'dart:io';

import 'package:app/feature/browserV2/models/tab/browser_tab.dart';
import 'package:app/feature/browserV2/screens/main/widgets/tab_list/item/browser_tabs_list_item_wm.dart';
import 'package:app/generated/generated.dart';
import 'package:elementary/elementary.dart';
import 'package:elementary_helper/elementary_helper.dart';
import 'package:flutter/material.dart';
import 'package:lucide_icons_flutter/lucide_icons.dart';
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
    return Stack(
      children: [
        StateNotifierBuilder<bool?>(
          listenableState: wm.activeState,
          builder: (_, bool? isActive) {
            isActive ??= false;

            return Material(
              shape: SquircleShapeBorder(
                borderWidth: isActive ? DimensSizeV2.d4 : DimensSizeV2.d2,
                cornerRadius: DimensRadiusV2.radius16,
                borderColor: isActive
                    ? ColorsResV2.p75
                    : wm.colors.primaryA.withAlpha(25),
              ),
              clipBehavior: Clip.antiAlias,
              color: wm.colors.background1,
              child: InkWell(
                onTap: onPressed,
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
              ),
            );
          },
        ),
        Positioned(
          bottom: 0,
          right: 0,
          child: _Menu(
            onPressed: wm.onPressedMenu,
          ),
        ),
      ],
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
          color: colors.background2,
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
                      style: textStyles.labelXSmall.copyWith(
                        color: colors.content2,
                      ),
                      maxLines: 1,
                      overflow: TextOverflow.ellipsis,
                      softWrap: false,
                    );
                  },
                ),
              ),
            ),
            GestureDetector(
              behavior: HitTestBehavior.opaque,
              onTap: onPressedClose,
              child: SizedBox(
                width: DimensSizeV2.d36,
                height: double.infinity,
                child: Icon(
                  LucideIcons.circleX,
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
  const _EmptyContent();

  @override
  Widget build(BuildContext context) {
    return Assets.images.bgNetwork.image(width: double.infinity);
  }
}

class _Menu extends StatelessWidget {
  const _Menu({
    required this.onPressed,
  });

  final VoidCallback onPressed;

  @override
  Widget build(BuildContext context) {
    final colors = context.themeStyleV2.colors;

    return GestureDetector(
      behavior: HitTestBehavior.opaque,
      onTap: onPressed,
      child: Padding(
        padding: const EdgeInsets.all(DimensSizeV2.d8),
        child: DecoratedBox(
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(DimensRadiusV2.radius8),
            // TODO(knightforce): add to color palette
            color: const Color(0xff353960),
          ),
          child: Padding(
            padding: const EdgeInsets.all(DimensSizeV2.d4),
            child: Center(
              child: Icon(
                LucideIcons.ellipsis,
                color: colors.primaryA,
              ),
            ),
          ),
        ),
      ),
    );
  }
}
