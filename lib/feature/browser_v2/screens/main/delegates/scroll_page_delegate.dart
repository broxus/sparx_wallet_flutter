import 'package:flutter/foundation.dart';
import 'package:flutter/gestures.dart';

class BrowserPageScrollDelegate {
  int _prevYScroll = 0;
  bool _isTouch = false;
  Offset? _downPosition;

  void onPointerDown(PointerDownEvent event) {
    _downPosition = event.position;
    _isTouch = true;
  }

  void onPointerUp(
    PointerUpEvent event, {
    required VoidCallback onSuccess,
  }) {
    _isTouch = false;
    if (_downPosition == null) {
      return;
    }

    if (event.position.dx > _downPosition!.dx + 10 ||
        event.position.dx < _downPosition!.dx - 10 ||
        event.position.dy > _downPosition!.dy + 10 ||
        event.position.dy < _downPosition!.dy - 10) {
      return;
    }

    onSuccess();
  }

  void onPointerCancel() {
    _isTouch = false;
  }

  void onWebPageScrollChanged(
    int y, {
    required ValueChanged<bool> onSuccess,
  }) {
    if (!_isTouch) {
      return;
    }

    final diff = _prevYScroll - y;

    if (diff > -100 && diff < 100) {
      return;
    }

    onSuccess(diff >= 0);

    _prevYScroll = y;
  }

  void onOverScrolled(
    int y, {
    required VoidCallback onSuccess,
  }) {
    if (y <= 0) {
      return;
    }

    onSuccess();
  }

  void resetVerticalScroll() {
    _prevYScroll = 0;
  }
}
