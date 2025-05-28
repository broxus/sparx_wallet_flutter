import 'package:flutter/cupertino.dart';
import 'package:logging/logging.dart';

abstract interface class BrowserProgressIndicatorUi {
  Animation<double> get animation;

  void onProgressChanged(int progressValue);
}

class BrowserProgressIndicatorDelegate implements BrowserProgressIndicatorUi {
  BrowserProgressIndicatorDelegate(this.vsync);

  final TickerProvider vsync;

  final _logger = Logger('BrowserProgressIndicatorDelegate');

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
  void onProgressChanged(int progressValue) {
    _progressController.animateTo(progressValue / 100);
  }

  void reset() {
    try {
      _progressController.reset();
    } catch (e, s) {
      _logger.severe('reset call error', e, s);
    }
  }
}
