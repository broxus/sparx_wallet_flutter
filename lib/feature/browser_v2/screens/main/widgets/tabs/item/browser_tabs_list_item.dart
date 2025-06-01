import 'dart:io';

import 'package:app/core/wm/not_null_listenable_state.dart';
import 'package:app/feature/browser_v2/data/tabs/browser_tab.dart';
import 'package:app/feature/browser_v2/screens/main/widgets/tabs/item/browser_tabs_list_item_wm.dart';
import 'package:app/generated/generated.dart';
import 'package:elementary/elementary.dart';
import 'package:elementary_helper/elementary_helper.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:lucide_icons_flutter/lucide_icons.dart';
import 'package:render_metrics/render_metrics.dart';
import 'package:ui_components_lib/ui_components_lib.dart';

class BrowserTabsListItem
    extends ElementaryWidget<BrowserTabsListItemWidgetModel> {
  BrowserTabsListItem({
    required NotNullListenableState<BrowserTab> tabNotifier,
    required this.renderManager,
    required this.onPressedTabMenu,
    this.onPressed,
    this.onClosePressed,
    super.key,
    WidgetModelFactory<BrowserTabsListItemWidgetModel>? wmFactory,
  }) : super(
          wmFactory ??
              (ctx) => defaultBrowserTabsListItemWidgetModelFactory(
                    ctx,
                    tabNotifier: tabNotifier,
                  ),
        );

  final RenderManager<String> renderManager;
  final VoidCallback onPressedTabMenu;
  final VoidCallback? onPressed;
  final VoidCallback? onClosePressed;

  @override
  Widget build(BrowserTabsListItemWidgetModel wm) {
    return RenderMetricsObject(
      id: wm.id,
      manager: renderManager,
      child: Stack(
        children: [
          _ReactiveShapeWidget(
            activeState: wm.activeState,
            backgroundColor: wm.colors.background1,
            activeColor: ColorsResV2.p75,
            inactiveColor: wm.colors.primaryA.withAlpha(25),
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
                                errorBuilder: (_, __, ___) => const SizedBox(),
                              );
                      },
                    ),
                  ),
                  _Header(
                    tabNotifier: wm.tabNotifier,
                    onPressedClose: onClosePressed,
                  ),
                ],
              ),
            ),
          ),
          Positioned(
            bottom: 0,
            right: 0,
            child: _Menu(
              onPressed: onPressedTabMenu,
            ),
          ),
        ],
      ),
    );
  }
}

class _Header extends StatelessWidget {
  const _Header({
    required this.tabNotifier,
    this.onPressedClose,
  });

  final NotNullListenableState<BrowserTab> tabNotifier;

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
                child: StateNotifierBuilder<BrowserTab?>(
                  listenableState: tabNotifier,
                  builder: (_, BrowserTab? tab) {
                    return Text(
                      tab?.title ?? '',
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

class _ReactiveShapeWidget extends SingleChildRenderObjectWidget {
  const _ReactiveShapeWidget({
    required this.activeState,
    required this.backgroundColor,
    required this.activeColor,
    required this.inactiveColor,
    required Widget child,
  }) : super(child: child);

  // shape: SquircleShapeBorder(
  // borderColor: isActive
  // ? ColorsResV2.p75
  //     : wm.colors.primaryA.withAlpha(25),
  // ),
  // clipBehavior: Clip.antiAlias,
  // color: wm.colors.background1,

  final ListenableState<bool?> activeState;
  final Color backgroundColor;
  final Color activeColor;
  final Color inactiveColor;

  @override
  RenderObject createRenderObject(BuildContext context) {
    return _ReactiveShapeRenderBox(
      activeState,
      backgroundColor,
      activeColor,
      inactiveColor,
    );
  }

  @override
  void updateRenderObject(
    BuildContext context,
    covariant _ReactiveShapeRenderBox renderObject,
  ) {
    renderObject
      ..backgroundColor = backgroundColor
      ..activeColor = activeColor
      ..inactiveColor = inactiveColor;
  }
}

class _ReactiveShapeRenderBox extends RenderProxyBox {
  _ReactiveShapeRenderBox(
    this.activeState,
    this.backgroundColor,
    this.activeColor,
    this.inactiveColor,
  ) {
    activeState.addListener(_onChanged);
  }

  final ListenableState<bool?> activeState;
  Color backgroundColor;
  Color activeColor;
  Color inactiveColor;
  final _radius = const Radius.circular(DimensRadiusV2.radius16);

  void _onChanged() {
    markNeedsPaint();
  }

  @override
  void detach() {
    activeState.removeListener(_onChanged);
    super.detach();
  }

  @override
  void paint(PaintingContext context, Offset offset) {
    final canvas = context.canvas;

    final fillPaint = Paint()
      ..color = backgroundColor
      ..style = PaintingStyle.fill;

    final borderWidth =
        (activeState.value ?? false) ? DimensSizeV2.d4 : DimensSizeV2.d2;
    final borderPaint = Paint()
      ..color = (activeState.value ?? false) ? activeColor : inactiveColor
      ..style = PaintingStyle.stroke
      ..strokeWidth = borderWidth;

    final rRect = RRect.fromRectAndRadius(
      offset & size,
      _radius,
    );

    canvas
      ..drawRRect(rRect, fillPaint)
      ..drawRRect(rRect.deflate(borderWidth / 2), borderPaint);

    super.paint(context, offset);
  }
}
