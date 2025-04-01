import 'dart:io';

import 'package:app/core/error_handler_factory.dart';
import 'package:app/core/wm/custom_wm.dart';
import 'package:app/di/di.dart';
import 'package:app/feature/browser_v2/screens/main/widgets/tab_animated_view/tab_animated_view.dart';
import 'package:app/feature/browser_v2/screens/main/widgets/tab_animated_view/tab_animated_view_model.dart';
import 'package:app/feature/browser_v2/screens/main/widgets/tab_animated_view/tab_animation_type.dart';
import 'package:elementary/elementary.dart';
import 'package:elementary_helper/elementary_helper.dart';
import 'package:flutter/widgets.dart';
import 'package:ui_components_lib/ui_components_lib.dart';

/// Factory method for creating [TabAnimatedViewWidgetModel]
TabAnimatedViewWidgetModel defaultTabAnimatedViewWidgetModelFactory(
  BuildContext context,
) {
  return TabAnimatedViewWidgetModel(
    TabAnimatedViewModel(
      createPrimaryErrorHandler(context),
      inject(),
    ),
  );
}

/// [WidgetModel] для [TabAnimatedView]
class TabAnimatedViewWidgetModel
    extends CustomWidgetModel<TabAnimatedView, TabAnimatedViewModel>
    with SingleTickerProviderWidgetModelMixin {
  TabAnimatedViewWidgetModel(
    super.model,
  );

  late final widthAnimation = Tween<double>(
    begin: 168,
    end: _screenSize.width,
  ).animate(_animationController);

  late final heightAnimation = Tween<double>(
    begin: 200,
    end: _screenSize.height,
  ).animate(_animationController);

  late final borderRadiusAnimation = Tween<double>(
    begin: 0,
    end: DimensRadiusV2.radius16,
  ).animate(_animationController);

  late final opacityAnimation = Tween<double>(
    begin: 0,
    end: 1,
  ).animate(_animationController);

  final _positionXTween = Tween<double>(begin: 0, end: 0);
  final _positionYTween = Tween<double>(begin: 0, end: 0);

  Animation<double>? _topPositionAnimation;

  Animation<double>? _leftPositionAnimation;

  late final _screenshotStateState = createNotifier<File?>();

  late final _animationController = AnimationController(
    vsync: this,
    duration: const Duration(milliseconds: 250),
  )..value = 1;

  late final _screenSize = MediaQuery.of(context).size;

  bool _isRunning = false;

  Animation<double>? get topPositionAnimation => _topPositionAnimation;

  Animation<double>? get leftPositionAnimation => _leftPositionAnimation;

  Listenable get animationListenable => _animationController;

  ListenableState<TabAnimationType?> get showAnimationState =>
      widget.showAnimationState;

  ListenableState<File?> get screenshotStateState => _screenshotStateState;

  @override
  void initWidgetModel() {
    showAnimationState.addListener(_handleTabAnimationType);
    _animationController.addStatusListener(_handleAnimationStatus);
    super.initWidgetModel();
  }

  @override
  void dispose() {
    showAnimationState.removeListener(_handleTabAnimationType);
    _animationController.dispose();
    super.dispose();
  }

  void _handleTabAnimationType() {
    final animationType = showAnimationState.value;

    if (animationType == null) {
      return;
    }
    final tabX = animationType.tabX;
    final tabY = animationType.tabY;

    if (tabX == null || tabY == null) {
      _onStart();
      _onEnd();

      return;
    }

    switch (animationType) {
      case ShowTabsAnimationType():
        _animationController.value = 1;
        _updateScreenshotFile();
        _updateAnimationPosition(tabX, tabY);
        _animationController.reverse();
      case ShowViewAnimationType():
        _animationController.value = 0;
        _updateScreenshotFile();
        _updateAnimationPosition(tabX, tabY);
        _animationController.forward();
    }
  }

  void _handleAnimationStatus(AnimationStatus status) {
    switch (status) {
      case AnimationStatus.forward:
      case AnimationStatus.reverse:
        _onStart();
      case AnimationStatus.dismissed:
      case AnimationStatus.completed:
        _onEnd();
    }
  }

  void _updateScreenshotFile() {
    final path = model.screenshotPath;

    _screenshotStateState.accept(
      path == null ? null : File(path),
    );
  }

  void _updateAnimationPosition(double tabX, double tabY) {
    _positionXTween.begin = tabX;
    _positionYTween.begin = tabY;
    _topPositionAnimation = _positionYTween.animate(_animationController);
    _leftPositionAnimation = _positionXTween.animate(_animationController);
  }

  void _onStart() {
    _isRunning = true;
    Future(() {
      widget.onAnimationStart();
    });
  }

  void _onEnd() {
    if (!_isRunning) {
      return;
    }
    _isRunning = false;
    Future(() {
      widget.onAnimationEnd();
    });
  }
}
