import 'package:flutter/cupertino.dart';

EdgeInsets getViewPadding() {
  final data = WidgetsBinding.instance.platformDispatcher.views.first;
  final mediaQueryData = MediaQueryData.fromView(data);
  return mediaQueryData.viewPadding;
}
