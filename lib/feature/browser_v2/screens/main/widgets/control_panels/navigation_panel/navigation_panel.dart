import 'package:app/core/wm/not_null_listenable_state.dart';
import 'package:app/feature/browser_v2/data/tabs/browser_tab.dart';
import 'package:app/feature/browser_v2/screens/main/widgets/control_panels/navigation_panel/address_bar.dart';
import 'package:app/utils/types/fuction_types.dart';
import 'package:elementary_helper/elementary_helper.dart';
import 'package:flutter/material.dart';
import 'package:ui_components_lib/v2/ui_components_lib_v2.dart';

class BrowserNavigationPanel extends StatefulWidget {
  const BrowserNavigationPanel({
    required this.panelWidth,
    required this.urlWidth,
    required this.urlSliderController,
    required this.tabsState,
    required this.onPressedCurrentUrlMenu,
    required this.onPressedRefresh,
    required this.onEditingCompleteUrl,
    required this.onPageChanged,
    super.key,
  });

  static const height = DimensSizeV2.d48;

  final double panelWidth;
  final double urlWidth;
  final PageController urlSliderController;
  final ListenableState<List<NotNullListenableState<BrowserTab>>?> tabsState;
  final ValueChanged<String> onPressedCurrentUrlMenu;
  final ValueChanged<String> onPressedRefresh;
  final DoubleValueCallback<String, String> onEditingCompleteUrl;
  final ValueChanged<int> onPageChanged;

  @override
  State<BrowserNavigationPanel> createState() =>
      _BrowserTabViewMenuUrlPanelState();
}

class _BrowserTabViewMenuUrlPanelState extends State<BrowserNavigationPanel>
    with TickerProviderStateMixin {
  late final _pageViewController = widget.urlSliderController;

  int _currentPage = 0;
  late int? _pagesCount = widget.tabsState.value?.length;
  bool _isTouch = false;
  final _duration = const Duration(milliseconds: 300);

  late final _animationLeftController = AnimationController(
    vsync: this,
    duration: _duration,
  );

  late final _offsetAnimation =
      Tween<double>(begin: -10, end: 10).animate(_animationLeftController);

  @override
  void initState() {
    super.initState();
    _animate();
    widget.tabsState.addListener(_handleChange);
  }

  @override
  void dispose() {
    _animationLeftController.dispose();
    widget.tabsState.removeListener(_handleChange);
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: widget.panelWidth,
      height: BrowserNavigationPanel.height,
      child: StateNotifierBuilder<List<NotNullListenableState<BrowserTab>>?>(
        listenableState: widget.tabsState,
        builder: (_, List<NotNullListenableState<BrowserTab>>? list) {
          if (list == null) {
            return const SizedBox.shrink();
          }

          return Listener(
            // onPointerDown: _onPointerDown,
            // onPointerUp: _onPointerUp,
            onPointerMove: _onPointerMove,
            // onPointerCancel: _onPointerCancel,
            child: AnimatedBuilder(
              animation: _offsetAnimation,
              builder: (
                _,
                Widget? child,
              ) {
                return Transform.translate(
                  offset: Offset(_offsetAnimation.value, 0),
                  child: child,
                );
              },
              child: NotificationListener(
                onNotification: _onNotification,
                child: PageView.builder(
                  physics: const ClampingScrollPhysics(),
                  controller: _pageViewController,
                  itemCount: list.length,
                  onPageChanged: _animateTranslate,
                  itemBuilder: (_, int index) {
                    return BrowserAddressBar(
                      key: ValueKey(list[index].value.id),
                      width: widget.urlWidth,
                      listenable: list[index],
                      onPressedCurrentUrlMenu: widget.onPressedCurrentUrlMenu,
                      onPressedRefresh: widget.onPressedRefresh,
                      onEditingComplete: widget.onEditingCompleteUrl,
                    );
                  },
                ),
              ),
            ),
          );
        },
      ),
    );
  }

  void _onPointerMove(_) {
    _isTouch = true;
  }

  bool _onNotification(ScrollNotification notification) {
    if (notification is ScrollUpdateNotification) {
      _handleScrollUpdate(notification);
    } else if (notification is ScrollEndNotification) {
      _isTouch = false;
    }
    return false;
  }

  void _handleScrollUpdate(ScrollUpdateNotification notification) {
    final page = _pageViewController.page ?? 0;
    final delta = (page - _currentPage).abs();

    if (delta <= .7) {
      return;
    }

    if (delta == 1) {
      final targetPage =
          page.round().clamp(0, (widget.tabsState.value?.length ?? 1) - 1);
      if (_isTouch) {
        widget.onPageChanged(targetPage);
      }
      _pageViewController.animateToPage(
        targetPage,
        duration: const Duration(milliseconds: 300),
        curve: Curves.easeOut,
      );
      _currentPage = targetPage;
      _animateTranslate(targetPage);
    }
  }

  void _animateTranslate(num page) {
    final count = widget.tabsState.value?.length;
    final value = _animationLeftController.value;

    double? newValue;
    if (count == null) {
      return;
    }

    if (count > 1 && page == 0) {
      newValue = 0;
    }
    if (count == 1 || page > 0 && page != count - 1) {
      newValue = .5;
    } else if (count > 0 && page == count - 1) {
      newValue = 1;
    }

    if (newValue == null || value == newValue) {
      return;
    }

    _animationLeftController.animateTo(
      newValue,
      duration: _isTouch ? _duration : Duration.zero,
    );
  }

  void _handleChange() {
    final currentCount = widget.tabsState.value?.length;

    if (_pagesCount != currentCount) {
      _animate();
    }

    _pagesCount = currentCount;
  }

  void _animate() {
    WidgetsBinding.instance.addPostFrameCallback((_) {
      if (_pageViewController.hasClients) {
        final page = _pageViewController.page;
        if (page != null) {
          _animateTranslate(page);
        }
      }
    });
  }
}
