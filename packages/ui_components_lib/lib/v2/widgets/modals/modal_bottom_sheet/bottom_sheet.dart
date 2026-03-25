// ignore_for_file: avoid_positional_boolean_parameters
// ignore_for_file: avoid_void_async
// ignore_for_file: cast_nullable_to_non_nullable
// ignore_for_file: prefer_asserts_with_message
// ignore_for_file: prefer_int_literals
// ignore_for_file: unawaited_futures

import 'dart:async';

import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:ui_components_lib/v2/widgets/modals/modal_bottom_sheet/utils/bottom_sheet_suspended_curve.dart';
import 'package:ui_components_lib/v2/widgets/modals/modal_bottom_sheet/utils/scroll_to_top_status_bar.dart';

const Curve _decelerateEasing = Cubic(0.0, 0.0, 0.2, 1.0);
const Duration _bottomSheetDuration = Duration(milliseconds: 400);
const double _minFlingVelocity = 500.0;
const double _closeProgressThreshold = 0.6;
const double _willPopThreshold = 0.8;

typedef WidgetWithChildBuilder =
    Widget Function(
      BuildContext context,
      Animation<double> animation,
      Widget child,
    );

class ModalBottomSheet extends StatefulWidget {
  const ModalBottomSheet({
    required this.animationController,
    required this.scrollController,
    required this.expanded,
    required this.onClosing,
    required this.child,
    this.animationCurve,
    this.enableDrag = true,
    this.containerBuilder,
    this.bounce = true,
    this.shouldClose,
    this.minFlingVelocity = _minFlingVelocity,
    double? closeProgressThreshold,
    @Deprecated('Use preventPopThreshold instead') double? willPopThreshold,
    double? preventPopThreshold,
    super.key,
  }) : preventPopThreshold =
           preventPopThreshold ?? willPopThreshold ?? _willPopThreshold,
       closeProgressThreshold =
           closeProgressThreshold ?? _closeProgressThreshold;

  final double closeProgressThreshold;
  final AnimationController animationController;
  final Curve? animationCurve;
  final bool bounce;
  final bool expanded;
  final WidgetWithChildBuilder? containerBuilder;
  final VoidCallback onClosing;
  final Future<bool> Function()? shouldClose;
  final Widget child;
  final bool enableDrag;
  final ScrollController scrollController;
  final double minFlingVelocity;
  final double preventPopThreshold;

  @override
  ModalBottomSheetState createState() => ModalBottomSheetState();

  static AnimationController createAnimationController(
    TickerProvider vsync, {
    Duration? duration,
  }) {
    return AnimationController(
      duration: duration ?? _bottomSheetDuration,
      debugLabel: 'BottomSheet',
      vsync: vsync,
    );
  }
}

class ModalBottomSheetState extends State<ModalBottomSheet>
    with TickerProviderStateMixin {
  final GlobalKey _childKey = GlobalKey(debugLabel: 'BottomSheet child');

  ScrollController get _scrollController => widget.scrollController;

  late AnimationController _bounceDragController;

  double? get _childHeight {
    final childContext = _childKey.currentContext;
    if (childContext == null) return null;

    final renderObject = childContext.findRenderObject();
    if (renderObject is! RenderBox || !renderObject.hasSize) return null;

    return renderObject.size.height;
  }

  bool get _dismissUnderway =>
      widget.animationController.status == AnimationStatus.reverse;

  bool isDragging = false;

  bool get hasReachedWillPopThreshold =>
      widget.animationController.value < widget.preventPopThreshold;

  bool get hasReachedCloseThreshold =>
      widget.animationController.value < widget.closeProgressThreshold;

  void _close() {
    isDragging = false;
    widget.onClosing();
  }

  void _cancelClose() {
    widget.animationController.forward().then((_) {
      if (!widget.animationController.isCompleted) {
        widget.animationController.value = 1;
      }
    });
    _bounceDragController.reverse();
  }

  bool _isCheckingShouldClose = false;

  FutureOr<bool> shouldClose() async {
    if (_isCheckingShouldClose) return false;
    if (widget.shouldClose == null) return false;
    _isCheckingShouldClose = true;
    final result = await widget.shouldClose?.call();
    _isCheckingShouldClose = false;
    return result ?? false;
  }

  ParametricCurve<double> animationCurve = Curves.linear;

  void _handleDragUpdate(double primaryDelta) async {
    animationCurve = Curves.linear;
    assert(widget.enableDrag, 'Dragging is disabled');

    if (_dismissUnderway) return;
    isDragging = true;

    final progress = primaryDelta / (_childHeight ?? primaryDelta);

    if (widget.shouldClose != null && hasReachedWillPopThreshold) {
      _cancelClose();
      final canClose = await shouldClose();
      if (canClose) {
        _close();
        return;
      } else {
        _cancelClose();
      }
    }

    final bounce = widget.bounce == true;
    final shouldBounce = _bounceDragController.value > 0;
    final isBouncing = (widget.animationController.value - progress) > 1;
    if (bounce && (shouldBounce || isBouncing)) {
      _bounceDragController.value -= progress * 10;
      return;
    }

    widget.animationController.value -= progress;
  }

  void _handleDragEnd(double velocity) async {
    assert(widget.enableDrag, 'Dragging is disabled');

    animationCurve = BottomSheetSuspendedCurve(
      widget.animationController.value,
      curve: _defaultCurve,
    );

    if (_dismissUnderway || !isDragging) return;
    isDragging = false;
    _bounceDragController.reverse();

    Future<void> tryClose() async {
      if (widget.shouldClose != null) {
        _cancelClose();
        final canClose = await shouldClose();
        if (canClose) {
          _close();
        }
      } else {
        _close();
      }
    }

    if (velocity > widget.minFlingVelocity) {
      tryClose();
    } else if (hasReachedCloseThreshold) {
      if (widget.animationController.value > 0.0) {
        widget.animationController.fling(velocity: -1.0);
      }
      tryClose();
    } else {
      _cancelClose();
    }
  }

  VelocityTracker? _velocityTracker;
  DateTime? _startTime;

  void _handleScrollUpdate(ScrollNotification notification) {
    assert(notification.context != null);
    if (!_scrollController.hasClients) return;

    ScrollPosition scrollPosition;

    if (_scrollController.positions.length > 1) {
      scrollPosition = _scrollController.positions.firstWhere(
        (p) => p.isScrollingNotifier.value,
        orElse: () => _scrollController.positions.first,
      );
    } else {
      scrollPosition = _scrollController.position;
    }

    if (scrollPosition.axis == Axis.horizontal) return;

    final isScrollReversed = scrollPosition.axisDirection == AxisDirection.down;
    final offset = isScrollReversed
        ? scrollPosition.pixels
        : scrollPosition.maxScrollExtent - scrollPosition.pixels;

    if (offset <= 0) {
      if (notification is ScrollEndNotification) {
        final dragDetails = notification.dragDetails;
        if (dragDetails != null) {
          _handleDragEnd(dragDetails.primaryVelocity ?? 0);
          _velocityTracker = null;
          _startTime = null;
          return;
        }
      }

      if (_velocityTracker == null) {
        final pointerKind = defaultPointerDeviceKind(context);
        _velocityTracker = VelocityTracker.withKind(pointerKind);
        _startTime = DateTime.now();
      }

      DragUpdateDetails? dragDetails;
      if (notification is ScrollUpdateNotification) {
        dragDetails = notification.dragDetails;
      }
      if (notification is OverscrollNotification) {
        dragDetails = notification.dragDetails;
      }

      assert(_velocityTracker != null);
      assert(_startTime != null);
      final startTime = _startTime!;
      final velocityTracker = _velocityTracker!;
      if (dragDetails != null) {
        final duration = startTime.difference(DateTime.now());
        velocityTracker.addPosition(duration, Offset(0, offset));
        _handleDragUpdate(dragDetails.delta.dy);
      } else if (isDragging) {
        final velocity = velocityTracker.getVelocity().pixelsPerSecond.dy;
        _velocityTracker = null;
        _startTime = null;
        _handleDragEnd(velocity);
      }
    }
  }

  Curve get _defaultCurve => widget.animationCurve ?? _decelerateEasing;

  @override
  void initState() {
    animationCurve = _defaultCurve;
    _bounceDragController = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 300),
    );
    super.initState();
  }

  @override
  void dispose() {
    _bounceDragController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final bounceAnimation = CurvedAnimation(
      parent: _bounceDragController,
      curve: Curves.easeOutSine,
    );

    var child = widget.child;
    if (widget.containerBuilder != null) {
      child = widget.containerBuilder!(
        context,
        widget.animationController,
        child,
      );
    }

    child = AnimatedBuilder(
      animation: widget.animationController,
      child: RepaintBoundary(child: child),
      builder: (context, child) {
        assert(child != null);
        final animationValue = animationCurve.transform(
          widget.animationController.value,
        );

        final draggableChild = !widget.enableDrag
            ? child
            : KeyedSubtree(
                key: _childKey,
                child: AnimatedBuilder(
                  animation: bounceAnimation,
                  builder: (context, _) => CustomSingleChildLayout(
                    delegate: _CustomBottomSheetLayout(bounceAnimation.value),
                    child: GestureDetector(
                      excludeFromSemantics: true,
                      onVerticalDragUpdate: (details) {
                        _handleDragUpdate(details.delta.dy);
                      },
                      onVerticalDragEnd: (details) {
                        _handleDragEnd(details.primaryVelocity ?? 0);
                      },
                      child: NotificationListener<ScrollNotification>(
                        onNotification: (notification) {
                          _handleScrollUpdate(notification);
                          return false;
                        },
                        child: child!,
                      ),
                    ),
                  ),
                ),
              );

        return ClipRect(
          child: CustomSingleChildLayout(
            delegate: _ModalBottomSheetLayout(animationValue, widget.expanded),
            child: draggableChild,
          ),
        );
      },
    );

    return StatusBarGestureDetector(
      onTap: (context) {
        _scrollController.animateTo(
          0.0,
          duration: const Duration(milliseconds: 1000),
          curve: Curves.easeOutCirc,
        );
      },
      child: child,
    );
  }
}

class _ModalBottomSheetLayout extends SingleChildLayoutDelegate {
  _ModalBottomSheetLayout(this.progress, this.expand);

  final double progress;
  final bool expand;

  @override
  BoxConstraints getConstraintsForChild(BoxConstraints constraints) {
    return BoxConstraints(
      minWidth: constraints.maxWidth,
      maxWidth: constraints.maxWidth,
      minHeight: expand ? constraints.maxHeight : 0,
      maxHeight: expand ? constraints.maxHeight : constraints.minHeight,
    );
  }

  @override
  Offset getPositionForChild(Size size, Size childSize) {
    return Offset(0.0, size.height - childSize.height * progress);
  }

  @override
  bool shouldRelayout(_ModalBottomSheetLayout oldDelegate) {
    return progress != oldDelegate.progress;
  }
}

class _CustomBottomSheetLayout extends SingleChildLayoutDelegate {
  _CustomBottomSheetLayout(this.progress);

  final double progress;
  double? childHeight;

  @override
  BoxConstraints getConstraintsForChild(BoxConstraints constraints) {
    return BoxConstraints(
      minWidth: constraints.maxWidth,
      maxWidth: constraints.maxWidth,
      minHeight: constraints.minHeight,
      maxHeight: constraints.maxHeight + progress * 8,
    );
  }

  @override
  Offset getPositionForChild(Size size, Size childSize) {
    childHeight ??= childSize.height;
    return Offset(0.0, size.height - childSize.height);
  }

  @override
  bool shouldRelayout(_CustomBottomSheetLayout oldDelegate) {
    if (progress != oldDelegate.progress) {
      childHeight = oldDelegate.childHeight;
      return true;
    }
    return false;
  }
}

PointerDeviceKind defaultPointerDeviceKind(BuildContext context) {
  final platform = Theme.of(context).platform;
  switch (platform) {
    case TargetPlatform.iOS:
    case TargetPlatform.android:
      return PointerDeviceKind.touch;
    case TargetPlatform.linux:
    case TargetPlatform.macOS:
    case TargetPlatform.windows:
      return PointerDeviceKind.mouse;
    case TargetPlatform.fuchsia:
      return PointerDeviceKind.unknown;
  }
}
