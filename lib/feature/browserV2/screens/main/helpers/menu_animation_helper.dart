import 'package:app/feature/browserV2/screens/main/data/menu_data.dart';
import 'package:app/feature/browserV2/screens/main/widgets/menu/menu_view_tab/menu_view_tab.dart';
import 'package:flutter/material.dart';

abstract interface class MenuAnimationHelper {
  Animation<double> get listMenuAnimation;

  Animation<double> get viewMenuAnimation;

  Animation<double> get urlMenuAnimation;

  Animation<Offset> get listMenuOffsetAnimation;

  Animation<Offset> get viewMenuOffsetAnimation;

  Animation<Offset> get urlMenuOffsetAnimation;

  Animation<double> get listMenuOpacityAnimation;

  Animation<double> get viewMenuOpacityAnimation;

  Animation<double> get urlMenuOpacityAnimation;
}

class MenuAnimationHelperImpl implements MenuAnimationHelper {
  MenuAnimationHelperImpl(this._vsync);

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

  final TickerProvider _vsync;

  static const _duration = Duration(milliseconds: 250);

  late final _offsetTween = Tween<Offset>(
    begin: Offset.zero,
    end: const Offset(0, BrowserTabViewMenu.minHeight),
  );

  late final _opacityTween = Tween<double>(
    begin: 1,
    end: 0,
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
        return;
      case MenuType.url:
        _listMenuController.animateTo(1);
        _viewMenuController.animateTo(1);
        _urlMenuController.animateTo(0);
        return;
      case null:
        return;
    }
  }
}
