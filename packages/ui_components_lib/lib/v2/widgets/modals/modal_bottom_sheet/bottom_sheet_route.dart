// ignore_for_file: always_put_required_named_parameters_first
// ignore_for_file: deprecated_member_use
// ignore_for_file: prefer_asserts_with_message

import 'dart:async';

import 'package:flutter/material.dart';
import 'package:ui_components_lib/v2/widgets/modals/modal_bottom_sheet/bottom_sheet.dart';
import 'package:ui_components_lib/v2/widgets/modals/modal_bottom_sheet/utils/modal_scroll_controller.dart';

const Duration _bottomSheetDuration = Duration(milliseconds: 400);

class _ModalBottomSheet<T> extends StatefulWidget {
  const _ModalBottomSheet({
    this.closeProgressThreshold,
    required this.route,
    this.secondAnimationController,
    this.bounce = false,
    this.expanded = false,
    this.enableDrag = true,
    this.animationCurve,
  });

  final double? closeProgressThreshold;
  final ModalSheetRoute<T> route;
  final bool expanded;
  final bool bounce;
  final bool enableDrag;
  final AnimationController? secondAnimationController;
  final Curve? animationCurve;

  @override
  State<_ModalBottomSheet<T>> createState() => _ModalBottomSheetState<T>();
}

class _ModalBottomSheetState<T> extends State<_ModalBottomSheet<T>> {
  ScrollController? _scrollController;

  @override
  void initState() {
    widget.route.animation?.addListener(updateController);
    super.initState();
  }

  @override
  void dispose() {
    widget.route.animation?.removeListener(updateController);
    _scrollController?.dispose();
    super.dispose();
  }

  void updateController() {
    final animation = widget.route.animation;
    if (animation != null) {
      widget.secondAnimationController?.value = animation.value;
    }
  }

  @override
  Widget build(BuildContext context) {
    assert(debugCheckHasMediaQuery(context));
    assert(widget.route._animationController != null);
    final scrollController =
        PrimaryScrollController.maybeOf(context) ??
        widget.route.scrollController ??
        (_scrollController ??= ScrollController());

    return ModalScrollController(
      controller: scrollController,
      child: Builder(
        builder: (context) => AnimatedBuilder(
          animation: widget.route._animationController!,
          builder: (context, child) {
            assert(child != null);
            return ModalBottomSheet(
              closeProgressThreshold: widget.closeProgressThreshold,
              expanded: widget.route.expanded,
              containerBuilder: widget.route.containerBuilder,
              animationController: widget.route._animationController!,
              shouldClose: widget.route._hasScopedWillPopCallback
                  ? () async {
                      final willPop = await widget.route.willPop();
                      return willPop != RoutePopDisposition.doNotPop;
                    }
                  : null,
              onClosing: () {
                if (widget.route.isCurrent) {
                  Navigator.of(context).pop();
                }
              },
              enableDrag: widget.enableDrag,
              bounce: widget.bounce,
              scrollController: scrollController,
              animationCurve: widget.animationCurve,
              child: child!,
            );
          },
          child: widget.route.builder(context),
        ),
      ),
    );
  }
}

class ModalSheetRoute<T> extends PageRoute<T> {
  ModalSheetRoute({
    this.closeProgressThreshold,
    this.containerBuilder,
    required this.builder,
    this.scrollController,
    this.barrierLabel,
    this.secondAnimationController,
    this.modalBarrierColor,
    this.isDismissible = true,
    this.enableDrag = true,
    required this.expanded,
    this.bounce = false,
    this.animationCurve,
    Duration? duration,
    super.settings,
  }) : duration = duration ?? _bottomSheetDuration;

  final double? closeProgressThreshold;
  final WidgetWithChildBuilder? containerBuilder;
  final WidgetBuilder builder;
  final bool expanded;
  final bool bounce;
  final Color? modalBarrierColor;
  final bool isDismissible;
  final bool enableDrag;
  final ScrollController? scrollController;
  final Duration duration;
  final AnimationController? secondAnimationController;
  final Curve? animationCurve;

  @override
  Duration get transitionDuration => duration;

  @override
  bool get barrierDismissible => isDismissible;

  @override
  bool get maintainState => true;

  @override
  bool get opaque => false;

  @override
  final String? barrierLabel;

  @override
  Color get barrierColor =>
      modalBarrierColor ?? Colors.black.withValues(alpha: 0.35);

  AnimationController? _animationController;

  @override
  AnimationController createAnimationController() {
    assert(_animationController == null);
    _animationController = ModalBottomSheet.createAnimationController(
      navigator!,
      duration: transitionDuration,
    );
    return _animationController!;
  }

  bool get _hasScopedWillPopCallback => hasScopedWillPopCallback;

  @override
  Widget buildPage(
    BuildContext context,
    Animation<double> animation,
    Animation<double> secondaryAnimation,
  ) {
    return MediaQuery.removePadding(
      context: context,
      child: _ModalBottomSheet<T>(
        closeProgressThreshold: closeProgressThreshold,
        route: this,
        secondAnimationController: secondAnimationController,
        expanded: expanded,
        bounce: bounce,
        enableDrag: enableDrag,
        animationCurve: animationCurve,
      ),
    );
  }

  @override
  bool canTransitionTo(TransitionRoute<dynamic> nextRoute) =>
      nextRoute is ModalSheetRoute;

  @override
  bool canTransitionFrom(TransitionRoute<dynamic> previousRoute) =>
      previousRoute is ModalSheetRoute || previousRoute is PageRoute;

  Widget getPreviousRouteTransition(
    BuildContext context,
    Animation<double> secondAnimation,
    Widget child,
  ) {
    return child;
  }
}

Future<T?> showCustomModalBottomSheet<T>({
  required BuildContext context,
  required WidgetBuilder builder,
  required WidgetWithChildBuilder containerWidget,
  Color? barrierColor,
  bool bounce = false,
  bool expand = false,
  AnimationController? secondAnimation,
  Curve? animationCurve,
  bool useRootNavigator = false,
  bool isDismissible = true,
  bool enableDrag = true,
  Duration? duration,
  RouteSettings? settings,
  double? closeProgressThreshold,
}) async {
  assert(debugCheckHasMediaQuery(context));
  assert(debugCheckHasMaterialLocalizations(context));
  final hasMaterialLocalizations =
      Localizations.of<MaterialLocalizations>(context, MaterialLocalizations) !=
      null;
  final barrierLabel = hasMaterialLocalizations
      ? MaterialLocalizations.of(context).modalBarrierDismissLabel
      : '';

  final result = await Navigator.of(context, rootNavigator: useRootNavigator)
      .push(
        ModalSheetRoute<T>(
          builder: builder,
          closeProgressThreshold: closeProgressThreshold,
          containerBuilder: containerWidget,
          secondAnimationController: secondAnimation,
          bounce: bounce,
          expanded: expand,
          barrierLabel: barrierLabel,
          isDismissible: isDismissible,
          modalBarrierColor: barrierColor,
          enableDrag: enableDrag,
          animationCurve: animationCurve,
          duration: duration,
          settings: settings,
        ),
      );
  return result;
}
