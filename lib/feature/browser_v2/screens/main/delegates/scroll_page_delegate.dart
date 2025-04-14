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

class BrowserPageScrollDelegate implements BrowserPageScrollUi {
  BrowserPageScrollDelegate({
    required this.onPageScrollChange,
  });

  final ValueChanged<bool> onPageScrollChange;

  int _prevYScroll = 0;
  double _prevYMove = 0;
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
    if (!_isTouch) {
      return;
    }
    final dy = event.position.dy;

    _handleScrollChange(dy - _prevYMove);

    _prevYMove = dy;
  }

  @override
  void onPointerCancel(PointerCancelEvent event) {
    _isTouch = false;
  }

  @override
  void onWebPageScrollChanged(int y) {
    if (_isTouch) {
      return;
    }
    _handleScrollChange(_prevYScroll - y);
    _prevYScroll = y;
  }

  void resetVerticalScroll() {
    _prevYScroll = 0;
  }

  void _handleScrollChange(num diff) {
    if (diff == 0) {
      return;
    }

    onPageScrollChange(diff >= 0);
  }
}
