import 'package:flutter/cupertino.dart';

abstract interface class BrowserProgressIndicatorUi {
  Animation<double> get animation;

  void onProgressChanged(double progressValue);
}

class BrowserProgressIndicatorDelegate implements BrowserProgressIndicatorUi {
  BrowserProgressIndicatorDelegate(this.vsync);

  final TickerProvider vsync;

  late final _progressController = AnimationController(
    vsync: vsync,
    duration: const Duration(milliseconds: 100),
  );

  @override
  Animation<double> get animation => _progressController;

  void dispose() {
    _progressController.dispose();
  }

  @override
  void onProgressChanged(double progressValue) {
    _progressController.animateTo(progressValue / 100);
  }

  void reset() {
    _progressController.reset();
  }
}
