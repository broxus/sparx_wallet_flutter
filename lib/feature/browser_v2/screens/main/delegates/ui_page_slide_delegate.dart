import 'package:flutter/cupertino.dart';

abstract interface class BrowserPageSlideUi {
  ScrollController get viewTabScrollController;

  PageController get urlSliderPageController;

  void onPageChanged(int index);
}

class BrowserPageSlideUiDelegate implements BrowserPageSlideUi {
  BrowserPageSlideUiDelegate({
    required this.screenWidth,
    required this.urlWidth,
    required this.onChangeSlideIndex,
  }) {
    _init();
  }

  @override
  final viewTabScrollController = ScrollController();
  @override
  final urlSliderPageController = PageController(viewportFraction: .94);

  final double screenWidth;
  final double urlWidth;
  final ValueChanged<int> onChangeSlideIndex;

  void dispose() {
    viewTabScrollController.dispose();
    urlSliderPageController.dispose();
  }

  void slideToPage(
    int page, {
    bool isAnimated = false,
  }) {
    if (!urlSliderPageController.hasClients) {
      return;
    }

    if (isAnimated) {
      urlSliderPageController.animateToPage(
        page,
        duration: const Duration(milliseconds: 250),
        curve: Curves.easeInOut,
      );
    } else {
      urlSliderPageController.jumpToPage(page);
    }
  }

  @override
  void onPageChanged(int index) {
    onChangeSlideIndex(index);
  }

  void _init() {
    urlSliderPageController.addListener(_handleUrlPanelScroll);
  }

  void _handleUrlPanelScroll() {
    final urlOffset = urlSliderPageController.offset;
    final urlMax = urlSliderPageController.position.maxScrollExtent;
    final viewMax = viewTabScrollController.position.maxScrollExtent;

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
}
