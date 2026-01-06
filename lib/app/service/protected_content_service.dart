import 'dart:async';
import 'dart:io';
import 'dart:math';
import 'dart:ui';

import 'package:app/app/service/app_lifecycle_service.dart';
import 'package:app/core/app_build_type.dart';
import 'package:fraud_protection/fraud_protection.dart';
import 'package:injectable/injectable.dart';
import 'package:logging/logging.dart';
import 'package:mutex/mutex.dart';
import 'package:no_screenshot/no_screenshot.dart';

@singleton
class ProtectedContentService {
  ProtectedContentService(this._appLifecycleService, this._appBuildType) {
    _lifecycleSubscription = _appLifecycleService.appLifecycleStateStream
        .listen(_handleAppLifecycle);
  }

  final AppLifecycleService _appLifecycleService;
  final AppBuildType _appBuildType;

  final _logger = Logger('ProtectedContentService');
  final _mutex = Mutex();
  int _counter = 0;
  StreamSubscription<AppLifecycleState>? _lifecycleSubscription;

  bool get _isEnabled => _appBuildType == AppBuildType.production;

  @disposeMethod
  void dispose() {
    _lifecycleSubscription?.cancel();
  }

  Future<void> enableProtectedContent() async {
    if (!_isEnabled) return;

    await _mutex.acquire();
    try {
      _counter++;
      await _disableScreenshot();
      await _setHideOverlayWindows(true);
    } finally {
      _mutex.release();
    }
  }

  Future<void> disableProtectedContent() async {
    if (!_isEnabled) return;

    await _mutex.acquire();
    try {
      _counter = max(_counter - 1, 0);
      if (_counter == 0) {
        await _enableScreenshot();
        await _setHideOverlayWindows(false);
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

  // ignore: avoid_positional_boolean_parameters
  Future<void> _setHideOverlayWindows(bool shouldHideOverlayWindows) async {
    if (!Platform.isAndroid) return;

    try {
      await FraudProtection.setHideOverlayWindows(shouldHideOverlayWindows);
    } catch (e, st) {
      _logger.warning('Failed to set hide overlay windows', e, st);
    }
  }
}
