import 'dart:io';

import 'package:app/feature/browser_v2/data/tabs/browser_tab.dart';
import 'package:app/generated/generated.dart';
import 'package:elementary_helper/elementary_helper.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:lucide_icons_flutter/lucide_icons.dart';
import 'package:ui_components_lib/ui_components_lib.dart';

const _radius = Radius.circular(DimensRadiusV2.radius16);

class BrowserTabsListItemBody extends StatelessWidget {
  const BrowserTabsListItemBody({
    required this.tabNotifier,
    required this.screenShotState,
    this.activeState,
    this.onPressed,
    this.onClosePressed,
    super.key,
  });

  final ListenableState<bool?>? activeState;
  final ValueListenable<BrowserTab?> tabNotifier;
  final ListenableState<File?> screenShotState;

  final VoidCallback? onPressed;
  final VoidCallback? onClosePressed;

  @override
  Widget build(BuildContext context) {
    final colors = context.themeStyleV2.colors;

    return ClipRRect(
      borderRadius: const BorderRadius.all(_radius),
      child: _ReactiveShapeWidget(
        activeState: activeState,
        activeColor: ColorsResV2.p75,
        inactiveColor: colors.primaryA.withAlpha(25),
        child: InkWell(
          onTap: onPressed,
          child: Stack(
            children: [
              SizedBox(
                width: double.infinity,
                child: StateNotifierBuilder<File?>(
                  listenableState: screenShotState,
                  builder: (_, File? file) {
                    return file == null
                        ? const _EmptyContent()
                        : Image.file(
                            file,
                            fit: BoxFit.cover,
                            errorBuilder: (_, __, ___) => const _ErrorContent(),
                          );
                  },
                ),
              ),
              _Header(
                tabNotifier: tabNotifier,
                onPressedClose: onClosePressed,
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class _Header extends StatelessWidget {
  const _Header({
    required this.tabNotifier,
    this.onPressedClose,
  });

  final ValueListenable<BrowserTab?> tabNotifier;
  final VoidCallback? onPressedClose;

  @override
  Widget build(BuildContext context) {
    final textStyles = context.themeStyleV2.textStyles;
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
                child: ValueListenableBuilder(
                  valueListenable: tabNotifier,
                  builder: (_, tab, __) {
                    return Text(
                      tab?.title ?? LocaleKeys.startPage.tr(),
                      style: textStyles.labelXSmall.copyWith(
                        color: colors.content2,
                      ),
                      maxLines: 1,
                      overflow: TextOverflow.ellipsis,
                    );
                  },
                ),
              ),
            ),
            if (onPressedClose != null)
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
    return Assets.images.bgNetwork.image(
      width: double.infinity,
      height: double.infinity,
      fit: BoxFit.cover,
    );
  }
}

class _ErrorContent extends StatelessWidget {
  const _ErrorContent();

  @override
  Widget build(BuildContext context) {
    return const SizedBox.expand(
      child: ColoredBox(
        color: Colors.white,
      ),
    );
  }
}

class _ReactiveShapeWidget extends SingleChildRenderObjectWidget {
  const _ReactiveShapeWidget({
    required this.activeColor,
    required this.inactiveColor,
    required Widget child,
    this.activeState,
  }) : super(child: child);

  final ListenableState<bool?>? activeState;
  final Color activeColor;
  final Color inactiveColor;

  @override
  RenderObject createRenderObject(BuildContext context) {
    return _ReactiveShapeRenderBox(
      activeState,
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
      ..activeColor = activeColor
      ..inactiveColor = inactiveColor;

    if (activeState == null) {
      renderObject.markNeedsPaint();
    }
  }
}

class _ReactiveShapeRenderBox extends RenderProxyBox {
  _ReactiveShapeRenderBox(
    this.activeState,
    this.activeColor,
    this.inactiveColor,
  ) {
    activeState?.addListener(_onChanged);
  }

  final ListenableState<bool?>? activeState;
  Color activeColor;
  Color inactiveColor;

  void _onChanged() {
    markNeedsPaint();
  }

  @override
  void detach() {
    activeState?.removeListener(_onChanged);
    super.detach();
  }

  @override
  void paint(PaintingContext context, Offset offset) {
    super.paint(context, offset);
    final canvas = context.canvas;
    final isActive = activeState?.value ?? false;

    final borderWidth = isActive ? DimensSizeV2.d4 : DimensSizeV2.d2;
    final rect = offset & size;
    final rRect = RRect.fromRectAndRadius(offset & size, _radius);

    if (child != null) {
      context.pushClipRRect(
        needsCompositing,
        offset,
        rect,
        rRect,
        (innerContext, innerOffset) {
          child!.paint(innerContext, innerOffset);
        },
      );
    }

    final borderPaint = Paint()
      ..color = isActive ? activeColor : inactiveColor
      ..style = PaintingStyle.stroke
      ..strokeWidth = borderWidth;

    canvas.drawRRect(rRect.deflate(borderWidth / 2), borderPaint);
  }
}
