import 'package:flutter/foundation.dart';

@immutable
class ToolbarData {
  ToolbarData({
    bool? isCanGoBack,
    bool? isCanGoForward,
  })  : isCanGoBack = isCanGoBack ?? false,
        isCanGoForward = isCanGoForward ?? false;

  final bool isCanGoBack;
  final bool isCanGoForward;

  @override
  bool operator ==(Object other) {
    return other is ToolbarData &&
        other.isCanGoBack == isCanGoBack &&
        other.isCanGoForward == isCanGoForward;
  }

  @override
  late final hashCode = Object.hash(isCanGoBack, isCanGoForward);
}
