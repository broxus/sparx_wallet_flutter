import 'dart:ui' show SemanticsRole;

import 'package:flutter/material.dart';
import 'package:smooth_sheets/smooth_sheets.dart';
import 'package:ui_components_lib/ui_components_lib.dart';

const _kBottomSheetTransitionDuration = Duration(milliseconds: 400);
const _kBottomSheetTransitionCurve = Cubic(0, 0, 0.2, 1);
const _kDefaultBarrierColor = Color(0x59000000);

ModalRoute<T> createSmoothModalSheetRoute<T>({
  required WidgetBuilder builder,
  required bool dismissible,
  Color? barrierColor,
  String? label,
  bool expand = false,
  bool wrapIntoAnimatedSize = true,
  double viewInsetsBottomAddon = 0,
}) {
  return ModalSheetRoute<T>(
    barrierColor: barrierColor ?? _kDefaultBarrierColor,
    barrierDismissible: dismissible,
    swipeDismissible: dismissible,
    transitionDuration: _kBottomSheetTransitionDuration,
    transitionCurve: _kBottomSheetTransitionCurve,
    viewportBuilder: (context, child) => SheetViewport(
      padding: EdgeInsets.only(
        top: MediaQuery.paddingOf(context).top + DimensSize.d24,
      ),
      child: child,
    ),
    builder: (context) => CustomMediaQuery(
      viewInsetsBottomAddon: viewInsetsBottomAddon,
      child: BlockSemantics(
        child: Semantics(
          container: true,
          explicitChildNodes: true,
          scopesRoute: true,
          namesRoute: label != null,
          label: label,
          role: SemanticsRole.dialog,
          child: Sheet(
            scrollConfiguration: const SheetScrollConfiguration(),
            decoration: MaterialSheetDecoration(
              size: expand ? SheetSize.stretch : SheetSize.fit,
              color: Colors.transparent,
              borderRadius: const BorderRadius.vertical(
                top: Radius.circular(DimensRadius.large),
              ),
              clipBehavior: Clip.antiAlias,
            ),
            child: _SheetContainer(
              animated: wrapIntoAnimatedSize,
              child: dismissible
                  ? builder(context)
                  : PopScope<void>(canPop: false, child: builder(context)),
            ),
          ),
        ),
      ),
    ),
  );
}

class _SheetContainer extends StatelessWidget {
  const _SheetContainer({required this.child, required this.animated});

  final Widget child;
  final bool animated;

  @override
  Widget build(BuildContext context) {
    return MediaQuery.removePadding(
      context: context,
      removeTop: true,
      child: animated
          ? AnimatedSize(
              duration: kThemeAnimationDuration,
              reverseDuration: kThemeAnimationDuration,
              curve: Curves.decelerate,
              clipBehavior: Clip.none,
              alignment: Alignment.topCenter,
              child: child,
            )
          : child,
    );
  }
}
