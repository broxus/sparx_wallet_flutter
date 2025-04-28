import 'package:app/utils/common_utils.dart';
import 'package:flutter/cupertino.dart';

abstract interface class BrowserPageSlideUi {
  ScrollController get viewTabScrollController;

  ScrollController get urlSliderController;

  bool onScrollNotification(ScrollNotification notification);
}

class BrowserPageSlideDelegate implements BrowserPageSlideUi {
  BrowserPageSlideDelegate({
    required this.screenWidth,
    required this.urlWidth,
    required this.onChangeSlideIndex,
  }) {
    _init();
  }

  @override
  final viewTabScrollController = ScrollController();
  @override
  final urlSliderController = ScrollController();

  final double screenWidth;
  final double urlWidth;
  final ValueChanged<int> onChangeSlideIndex;

  void dispose() {
    viewTabScrollController.dispose();
    urlSliderController.dispose();
  }

  void slideTo(double value) {
    callWithDelay(() {
      urlSliderController.jumpTo(value);
    });
  }

  void _init() {
    urlSliderController.addListener(_handleUrlPanelScroll);
  }

  @override
  bool onScrollNotification(ScrollNotification notification) {
    if (notification is ScrollEndNotification) {
      _snapViewScroll();
    }

    return false;
  }

  void _handleUrlPanelScroll() {
    final urlOffset = urlSliderController.offset;
    final urlMax = urlSliderController.position.maxScrollExtent;
    final viewMax = viewTabScrollController.position.maxScrollExtent;
    final tabIndex = ((viewMax - (viewMax - urlOffset)) / urlWidth).round();

    onChangeSlideIndex(tabIndex);

    final x = viewMax * urlOffset / urlMax;

    if (x == 0) {
      viewTabScrollController.animateTo(
        0,
        duration: const Duration(milliseconds: 250),
        curve: Curves.linear,
      );
    } else if (!x.isNaN) {
      viewTabScrollController.jumpTo(x);
    }
  }

  void _snapViewScroll() {
    final urlOffset = urlSliderController.offset;
    final tabIndex = (urlOffset / urlWidth).round();
    final targetOffset = tabIndex * screenWidth;

    viewTabScrollController.jumpTo(
      targetOffset,
    );

    onChangeSlideIndex(tabIndex);
  }
}
