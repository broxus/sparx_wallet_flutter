import 'dart:math';

import 'package:injectable/injectable.dart';
import 'package:logging/logging.dart';
import 'package:mutex/mutex.dart';
import 'package:no_screenshot/no_screenshot.dart';

@singleton
class ProtectedContentService {
  final _logger = Logger('ProtectedContentService');
  final _mutex = Mutex();
  int _counter = 0;

  Future<void> enableProtectedContent() async {
    await _mutex.acquire();
    try {
      _counter++;
      await _disableScreenshot();
    } finally {
      _mutex.release();
    }
  }

  Future<void> disableProtectedContent() async {
    await _mutex.acquire();
    try {
      _counter = max(_counter - 1, 0);
      if (_counter == 0) {
        await _enableScreenshot();
      }
    } finally {
      _mutex.release();
    }
  }

  Future<void> _disableScreenshot() async {
    try {
      final result = await NoScreenshot.instance.screenshotOff();

      if (!result) {
        _logger.warning('Failed to disable screenshot');
      }
    } catch (e, st) {
      _logger.warning('Failed to disable screenshot', e, st);
    }
  }

  Future<void> _enableScreenshot() async {
    try {
      await NoScreenshot.instance.screenshotOn();
    } catch (e, st) {
      _logger.warning('Failed to enable screenshot', e, st);
    }
  }
}
