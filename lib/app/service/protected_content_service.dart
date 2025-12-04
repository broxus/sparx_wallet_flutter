import 'dart:async';
import 'dart:math';
import 'dart:ui';

import 'package:app/app/service/app_lifecycle_service.dart';
import 'package:injectable/injectable.dart';
import 'package:logging/logging.dart';
import 'package:mutex/mutex.dart';
import 'package:no_screenshot/no_screenshot.dart';

@singleton
class ProtectedContentService {
  ProtectedContentService(this._appLifecycleService) {
    _lifecycleSubscription = _appLifecycleService.appLifecycleStateStream
        .listen(_handleAppLifecycle);
  }

  final AppLifecycleService _appLifecycleService;

  final _logger = Logger('ProtectedContentService');
  final _mutex = Mutex();
  int _counter = 0;
  StreamSubscription<AppLifecycleState>? _lifecycleSubscription;

  @disposeMethod
  void dispose() {
    _lifecycleSubscription?.cancel();
  }

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

  Future<void> _handleAppLifecycle(AppLifecycleState state) async {
    if (state != AppLifecycleState.resumed) return;
    if (_counter == 0) return;

    await _mutex.acquire();
    try {
      if (_counter > 0) {
        await _disableScreenshot();
      }
    } finally {
      _mutex.release();
    }
  }
}
