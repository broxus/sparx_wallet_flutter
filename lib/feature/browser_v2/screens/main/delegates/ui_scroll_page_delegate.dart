import 'package:app/utils/focus_utils.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/gestures.dart';

abstract interface class BrowserPageScrollUi {
  void onPointerDown(PointerDownEvent event);

  void onPointerCancel(PointerCancelEvent event);

  void onWebPageScrollChanged(int y);

  void onPointerUp(PointerUpEvent event);

  void onPointerMove(PointerMoveEvent event);
}

class BrowserPageScrollUiDelegate implements BrowserPageScrollUi {
  BrowserPageScrollUiDelegate({
    required this.onPageScrollChange,
  });

  final ValueChanged<bool> onPageScrollChange;

  double _prevYMove = 0;
  double _moveDiff = 0;
  bool _isTouch = false;
  Offset? _downPosition;

  @override
  void onPointerDown(PointerDownEvent event) {
    _downPosition = event.position;
    _isTouch = true;
  }

  @override
  void onPointerUp(PointerUpEvent event) {
    _isTouch = false;
    if (_downPosition == null) {
      return;
    }

    if (event.position.dx < _downPosition!.dx + 3 &&
        event.position.dx > _downPosition!.dx - 3 &&
        event.position.dy < _downPosition!.dy + 3 &&
        event.position.dy > _downPosition!.dy - 3) {
      resetFocus();
    }
  }

  @override
  void onPointerMove(PointerMoveEvent event) {
    final dy = event.position.dy;
    _moveDiff = dy - _prevYMove;
    _prevYMove = dy;
  }

  @override
  void onPointerCancel(PointerCancelEvent event) {
    _isTouch = false;
  }

  @override
  void onWebPageScrollChanged(int y) {
    if (!_isTouch) {
      return;
    }

    onPageScrollChange(_moveDiff >= 0);
  }

  void reset() {
    _moveDiff = 0;
    _prevYMove = 0;
  }
}
