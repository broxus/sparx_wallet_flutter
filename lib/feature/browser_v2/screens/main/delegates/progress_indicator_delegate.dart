import 'package:flutter/cupertino.dart';

class BrowserProgressIndicatorDelegate {
  BrowserProgressIndicatorDelegate(this.vsync);

  final TickerProvider vsync;

  late final _progressController = AnimationController(
    vsync: vsync,
    duration: const Duration(milliseconds: 100),
  );

  Animation<double> get animation => _progressController;

  void dispose() {
    _progressController.dispose();
  }

  void onProgressChanged(double progressValue) {
    _progressController.animateTo(progressValue / 100);
  }

  void reset() {
    _progressController.reset();
  }
}
