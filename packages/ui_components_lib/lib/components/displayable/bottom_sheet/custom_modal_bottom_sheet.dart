import 'package:flutter/material.dart';

typedef WidgetWithChildBuilder =
    Widget Function(
      BuildContext context,
      Animation<double> animation,
      Widget child,
    );

class ModalScrollController extends InheritedWidget {
  const ModalScrollController({
    required this.controller,
    required super.child,
    super.key,
  });

  final ScrollController controller;

  static ScrollController? of(BuildContext context) {
    return context
        .dependOnInheritedWidgetOfExactType<ModalScrollController>()
        ?.controller;
  }

  @override
  bool updateShouldNotify(ModalScrollController oldWidget) =>
      controller != oldWidget.controller;
}

class ModalSheetRoute<T> extends PopupRoute<T> {
  ModalSheetRoute({
    required this.builder,
    this.containerBuilder,
    this.expanded = false,
    this.isDismissible = true,
    this.modalBarrierColor,
    this.duration = _bottomSheetDuration,
    super.settings,
  });

  final WidgetBuilder builder;
  final WidgetWithChildBuilder? containerBuilder;
  final bool expanded;
  final bool isDismissible;
  final Color? modalBarrierColor;
  final Duration duration;

  static const Duration _bottomSheetDuration = Duration(milliseconds: 300);

  AnimationController? _animationController;

  @override
  Duration get transitionDuration => duration;

  @override
  bool get barrierDismissible => isDismissible;

  @override
  Color get barrierColor =>
      modalBarrierColor ?? Colors.black.withValues(alpha: 0.35);

  @override
  String? get barrierLabel => 'Dismiss';

  @override
  bool get maintainState => true;

  @override
  AnimationController createAnimationController() {
    assert(
      _animationController == null,
      'Animation controller must be created only once per route.',
    );
    _animationController = AnimationController(
      duration: duration,
      debugLabel: 'CustomModalBottomSheet',
      vsync: navigator!.overlay!,
    );
    return _animationController!;
  }

  @override
  Widget buildPage(
    BuildContext context,
    Animation<double> animation,
    Animation<double> secondaryAnimation,
  ) {
    return MediaQuery.removePadding(
      context: context,
      removeTop: true,
      child: _ModalSheetPage<T>(route: this, animation: animation),
    );
  }
}

Future<T?> showCustomModalBottomSheet<T>({
  required BuildContext context,
  required WidgetBuilder builder,
  required WidgetWithChildBuilder containerWidget,
  Color? barrierColor,
  bool expand = false,
  bool useRootNavigator = false,
  bool isDismissible = true,
  Duration? duration,
  RouteSettings? settings,
}) {
  return Navigator.of(context, rootNavigator: useRootNavigator).push(
    ModalSheetRoute<T>(
      builder: builder,
      containerBuilder: containerWidget,
      expanded: expand,
      isDismissible: isDismissible,
      modalBarrierColor: barrierColor,
      duration: duration ?? ModalSheetRoute._bottomSheetDuration,
      settings: settings,
    ),
  );
}

class _ModalSheetPage<T> extends StatefulWidget {
  const _ModalSheetPage({required this.route, required this.animation});

  final ModalSheetRoute<T> route;
  final Animation<double> animation;

  @override
  State<_ModalSheetPage<T>> createState() => _ModalSheetPageState<T>();
}

class _ModalSheetPageState<T> extends State<_ModalSheetPage<T>> {
  ScrollController? _scrollController;

  ScrollController get _controller =>
      _scrollController ??= ScrollController(debugLabel: 'ModalSheetScroll');

  @override
  void dispose() {
    _scrollController?.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final curvedAnimation = CurvedAnimation(
      parent: widget.animation,
      curve: Curves.easeOutCubic,
      reverseCurve: Curves.easeInCubic,
    );

    Widget child = Builder(
      builder: (context) => ModalScrollController(
        controller: _controller,
        child: widget.route.builder(context),
      ),
    );

    if (widget.route.containerBuilder != null) {
      child = widget.route.containerBuilder!(context, curvedAnimation, child);
    }

    return AnimatedBuilder(
      animation: curvedAnimation,
      child: child,
      builder: (context, child) {
        return ClipRect(
          child: CustomSingleChildLayout(
            delegate: _ModalBottomSheetLayout(
              progress: curvedAnimation.value,
              expand: widget.route.expanded,
            ),
            child: child,
          ),
        );
      },
    );
  }
}

class _ModalBottomSheetLayout extends SingleChildLayoutDelegate {
  const _ModalBottomSheetLayout({required this.progress, required this.expand});

  final double progress;
  final bool expand;

  @override
  BoxConstraints getConstraintsForChild(BoxConstraints constraints) {
    return BoxConstraints(
      minWidth: constraints.maxWidth,
      maxWidth: constraints.maxWidth,
      minHeight: expand ? constraints.maxHeight : 0,
      maxHeight: constraints.maxHeight,
    );
  }

  @override
  Offset getPositionForChild(Size size, Size childSize) {
    return Offset(0, size.height - childSize.height * progress);
  }

  @override
  bool shouldRelayout(_ModalBottomSheetLayout oldDelegate) {
    return progress != oldDelegate.progress || expand != oldDelegate.expand;
  }
}
