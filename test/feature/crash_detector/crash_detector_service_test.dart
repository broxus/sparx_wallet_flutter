import 'package:app/feature/crash_detector/domain/crash_detector_service.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:shared_preferences/shared_preferences.dart';

void main() {
  const sessionKey = 'app_session_active';
  const crashDetectedKey = 'app_crash_detected';

  setUp(() async {
    TestWidgetsFlutterBinding.ensureInitialized();
    SharedPreferences.setMockInitialValues({});
  });

  group('CrashDetectorService', () {
    test(
      'startSession marks session active without crash when tracking disabled',
      () async {
        // Arrange
        final service = CrashDetectorService();

        // Act
        await service.startSession(setCrashDetected: false);
        final prefs = await SharedPreferences.getInstance();

        // Assert
        expect(prefs.getBool(sessionKey), isTrue);
        expect(prefs.getBool(crashDetectedKey), isFalse);
      },
    );

    test(
      // ignore: lines_longer_than_80_chars
      'startSession marks crash when previous session was active and tracking enabled',
      () async {
        // Arrange
        SharedPreferences.setMockInitialValues({sessionKey: true});
        final service = CrashDetectorService();

        // Act
        await service.startSession(setCrashDetected: true);
        final prefs = await SharedPreferences.getInstance();

        // Assert
        expect(prefs.getBool(sessionKey), isTrue);
        expect(prefs.getBool(crashDetectedKey), isTrue);
      },
    );

    test(
      'startSession does not mark crash when previous session was inactive',
      () async {
        // Arrange
        SharedPreferences.setMockInitialValues({sessionKey: false});
        final service = CrashDetectorService();

        // Act
        await service.startSession(setCrashDetected: true);
        final prefs = await SharedPreferences.getInstance();

        // Assert
        expect(prefs.getBool(sessionKey), isTrue);
        expect(prefs.getBool(crashDetectedKey), isFalse);
      },
    );

    test('stopSession clears session and crash flags', () async {
      // Arrange
      SharedPreferences.setMockInitialValues({
        sessionKey: true,
        crashDetectedKey: true,
      });
      final service = CrashDetectorService();

      // Act
      await service.stopSession();
      await Future<void>.delayed(
        Duration.zero,
      ); // Allow unawaited set operations.
      final prefs = await SharedPreferences.getInstance();

      // Assert
      expect(prefs.getBool(sessionKey), isFalse);
      expect(prefs.getBool(crashDetectedKey), isFalse);
    });

    test(
      'checkCrashDetected returns false when no crash is recorded',
      () async {
        // Arrange
        final service = CrashDetectorService();

        // Act
        final detected = await service.checkCrashDetected();

        // Assert
        expect(detected, isFalse);
      },
    );

    test(
      'checkCrashDetected returns false in debug mode and leaves flag intact',
      () async {
        // Arrange
        SharedPreferences.setMockInitialValues({crashDetectedKey: true});
        final service = CrashDetectorService();

        // Act
        final detected = await service.checkCrashDetected();
        final prefs = await SharedPreferences.getInstance();

        // Assert
        expect(detected, isFalse);
        expect(prefs.getBool(crashDetectedKey), isTrue);
      },
    );
  });
}
