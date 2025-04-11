import 'package:app/feature/browser_v2/screens/main/data/menu_data.dart';
import 'package:app/feature/browser_v2/screens/main/widgets/control_panels/navigation_panel/host_panel.dart';
import 'package:app/feature/browser_v2/screens/main/widgets/control_panels/page_control_panel.dart';
import 'package:flutter/material.dart';

abstract interface class BrowserMenuAnimationUi {
  Animation<double> get listMenuAnimation;

  Animation<double> get viewMenuAnimation;

  Animation<double> get urlMenuAnimation;

  Animation<Offset> get listMenuOffsetAnimation;

  Animation<Offset> get viewMenuOffsetAnimation;

  Animation<Offset> get urlMenuOffsetAnimation;

  Animation<double> get listMenuOpacityAnimation;

  Animation<double> get viewMenuOpacityAnimation;

  Animation<double> get urlMenuOpacityAnimation;

  Animation<double> get paddingPageAnimation;
}

class BrowserMenuAnimationDelegate implements BrowserMenuAnimationUi {
  BrowserMenuAnimationDelegate(this._vsync);

  @override
  late final listMenuOffsetAnimation =
      _offsetTween.animate(_listMenuController);

  @override
  late final viewMenuOffsetAnimation =
      _offsetTween.animate(_viewMenuController);

  @override
  late final urlMenuOffsetAnimation = _offsetTween.animate(_urlMenuController);

  @override
  late final listMenuOpacityAnimation =
      _opacityTween.animate(_listMenuController);

  @override
  late final viewMenuOpacityAnimation =
      _opacityTween.animate(_viewMenuController);

  @override
  late final urlMenuOpacityAnimation =
      _opacityTween.animate(_urlMenuController);

  @override
  late final paddingPageAnimation =
      _paddingPageTween.animate(_paddingPageController);

  final TickerProvider _vsync;

  static const _duration = Duration(milliseconds: 250);

  late final _offsetTween = Tween<Offset>(
    begin: Offset.zero,
    end: const Offset(0, BrowserPageControlPanel.minHeight),
  );

  late final _opacityTween = Tween<double>(
    begin: 1,
    end: 0,
  );

  late final _paddingPageTween = Tween<double>(
    begin: 0,
    end: HostPanel.height,
  );

  late final _listMenuController = AnimationController(
    vsync: _vsync,
    duration: _duration,
  );
  late final _viewMenuController = AnimationController(
    vsync: _vsync,
    duration: _duration,
  );
  late final _urlMenuController = AnimationController(
    vsync: _vsync,
    duration: _duration,
  );
  late final _paddingPageController = AnimationController(
    vsync: _vsync,
    duration: _duration,
  );

  @override
  Animation<double> get listMenuAnimation => _listMenuController;

  @override
  Animation<double> get viewMenuAnimation => _viewMenuController;

  @override
  Animation<double> get urlMenuAnimation => _urlMenuController;

  void dispose() {
    _listMenuController.dispose();
    _viewMenuController.dispose();
    _urlMenuController.dispose();
    _paddingPageController.dispose();
  }

  void handleMenuType(MenuType? type) {
    switch (type) {
      case MenuType.list:
        _listMenuController.animateTo(0);
        _viewMenuController.animateTo(1);
        _urlMenuController.animateTo(1);
        return;
      case MenuType.view:
        _listMenuController.animateTo(1);
        _viewMenuController.animateTo(0);
        _urlMenuController.animateTo(1);
        _paddingPageController.animateTo(0);
        return;
      case MenuType.url:
        _listMenuController.animateTo(1);
        _viewMenuController.animateTo(1);
        _urlMenuController.animateTo(0);
        _paddingPageController.animateTo(1);
        return;
      case MenuType.none:
      case null:
        _listMenuController.animateTo(1);
        _viewMenuController.animateTo(1);
        _paddingPageController.animateTo(1);
        return;
    }
  }
}
