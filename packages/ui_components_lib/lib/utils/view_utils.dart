import 'package:flutter/widgets.dart';

final _view = WidgetsBinding.instance.platformDispatcher.views.single;
final _data = MediaQueryData.fromView(_view);

final double _devicePixelRatio = _data.devicePixelRatio;
final Size _physicalSize = _view.physicalSize;

final double physicalScreenWidth = _physicalSize.width;
final double physicalScreenHeight = _physicalSize.height;

final initialScreenSize = _physicalSize / _devicePixelRatio;
final initialScreenWidth = initialScreenSize.width;
final initialScreenHeight = initialScreenSize.height;

const double minTabletWidth = 660;
const double maxPhoneWidth = 915;

Size get currentScreenSize => _physicalSize / _devicePixelRatio;

double get currentScreenWidth => currentScreenSize.width;

double get currentScreenHeight => currentScreenSize.height;

/// Whether the screen is small or large.
/// true - small
/// false - large
/// At a height of 600, the layout looks unacceptable.
/// At a height of >820, the UX is acceptable.
/// Therefore, 800 was chosen as the minimum acceptable value.
bool get isSmallScreenHeight => currentScreenHeight < 800;
