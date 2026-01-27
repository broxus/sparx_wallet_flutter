import 'dart:async';

import 'package:flutter/foundation.dart';
import 'package:injectable/injectable.dart';
import 'package:logging/logging.dart';
import 'package:shared_preferences/shared_preferences.dart';

@singleton
class CrashDetectorService {
  static const _sessionKey = 'app_session_active';
  static const _crashDetectedKey = 'app_crash_detected';

  final _log = Logger('CrashDetectorService');

  Future<void> startSession({required bool setCrashDetected}) async {
    final prefs = await SharedPreferences.getInstance();

    final crashDetected =
        setCrashDetected && (prefs.getBool(_sessionKey) ?? false);
    await prefs.setBool(_sessionKey, true);
    await prefs.setBool(_crashDetectedKey, crashDetected);

    if (crashDetected) {
      if (kDebugMode) {
        _log.info(
          'appStartSession: crash detected, '
          'but maybe it was stop in debug mode',
        );
      } else {
        _log.severe('appStartSession: crash detected');
      }
    }
  }

  Future<void> stopSession() async {
    final prefs = await SharedPreferences.getInstance();

    unawaited(prefs.setBool(_sessionKey, false));
    unawaited(prefs.setBool(_crashDetectedKey, false));
  }

  Future<bool> checkCrashDetected() async {
    final prefs = await SharedPreferences.getInstance();

    final crashDetected = prefs.getBool(_crashDetectedKey) ?? false;

    if (!crashDetected) {
      return false;
    }

    // Don't bother with crash detection in debug mode because every time we
    // restart the app after stopping it in debug mode, it will be detected as a
    // crash.
    if (kDebugMode) {
      _log.info(
        'appGetCrashDetected: detected crash not indicated in debug mode',
      );

      return false;
    }

    _log.severe('appGetCrashDetected: detected crash indicated');

    await prefs.setBool(_crashDetectedKey, false);

    return true;
  }
}
