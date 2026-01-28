import 'package:app/app/service/app_lifecycle_service.dart';
import 'package:app/app/service/protected_content_service.dart';
import 'package:app/core/core.dart';
import 'package:flutter/services.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:no_screenshot/constants.dart' as no_screenshot_constants;

void main() {
  TestWidgetsFlutterBinding.ensureInitialized();

  const noScreenshotChannel = MethodChannel(
    no_screenshot_constants.screenshotMethodChannel,
  );
  const fraudProtectionChannel = MethodChannel('fraud_protection');

  late AppLifecycleService lifecycleService;
  late ProtectedContentService service;

  var screenshotOffCalls = 0;
  var screenshotOnCalls = 0;
  var hideOverlayWindowsCalls = 0;

  var screenshotOffShouldThrow = false;
  var screenshotOnShouldThrow = false;
  var screenshotOffResult = true;

  setUp(() {
    screenshotOffCalls = 0;
    screenshotOnCalls = 0;
    hideOverlayWindowsCalls = 0;
    screenshotOffShouldThrow = false;
    screenshotOnShouldThrow = false;
    screenshotOffResult = true;

    TestDefaultBinaryMessengerBinding.instance.defaultBinaryMessenger
        .setMockMethodCallHandler(noScreenshotChannel, (methodCall) async {
          if (methodCall.method == no_screenshot_constants.screenShotOffConst) {
            screenshotOffCalls++;
            if (screenshotOffShouldThrow) {
              throw Exception('screenshotOff failed');
            }
            return screenshotOffResult;
          }

          if (methodCall.method == no_screenshot_constants.screenShotOnConst) {
            screenshotOnCalls++;
            if (screenshotOnShouldThrow) throw Exception('screenshotOn failed');
            return null;
          }

          return null;
        });

    TestDefaultBinaryMessengerBinding.instance.defaultBinaryMessenger
        .setMockMethodCallHandler(fraudProtectionChannel, (methodCall) async {
          if (methodCall.method == 'setHideOverlayWindows') {
            hideOverlayWindowsCalls++;
          }
          return null;
        });

    lifecycleService = AppLifecycleService();
    service = ProtectedContentService(
      lifecycleService,
      AppBuildType.production,
    );
  });

  tearDown(() {
    service.dispose();
    TestDefaultBinaryMessengerBinding.instance.defaultBinaryMessenger
        .setMockMethodCallHandler(noScreenshotChannel, null);
    TestDefaultBinaryMessengerBinding.instance.defaultBinaryMessenger
        .setMockMethodCallHandler(fraudProtectionChannel, null);
  });

  group('ProtectedContentService', () {
    test(
      'enableProtectedContent disables screenshots on first enable',
      () async {
        // Act
        await service.enableProtectedContent();

        // Assert
        expect(screenshotOffCalls, 1);
        expect(screenshotOnCalls, 0);
        expect(hideOverlayWindowsCalls, 0); // Platform is not Android in tests
      },
    );

    test(
      'disableProtectedContent re-enables screenshots when counter hits zero',
      () async {
        // Arrange
        await service.enableProtectedContent();
        screenshotOffCalls = 0;
        screenshotOnCalls = 0;

        // Act
        await service.disableProtectedContent();

        // Assert
        expect(screenshotOnCalls, 1);
        expect(screenshotOffCalls, 0);
      },
    );

    test(
      'disableProtectedContent keeps protection when still enabled elsewhere',
      () async {
        // Arrange
        await service.enableProtectedContent();
        await service.enableProtectedContent();
        screenshotOffCalls = 0;
        screenshotOnCalls = 0;

        // Act
        await service.disableProtectedContent();

        // Assert
        expect(screenshotOnCalls, 0);
        expect(screenshotOffCalls, 0);
      },
    );

    test(
      'disableProtectedContent when already at zero still completes gracefully',
      () async {
        // Act
        await service.disableProtectedContent();

        // Assert
        expect(screenshotOnCalls, 1);
        expect(screenshotOffCalls, 0);
      },
    );

    test('re-enables protection after resume when active', () async {
      // Arrange
      await service.enableProtectedContent();
      screenshotOffCalls = 0;

      // Act
      lifecycleService.updateState(AppLifecycleState.resumed);
      await Future<void>.delayed(const Duration(milliseconds: 10));

      // Assert
      expect(screenshotOffCalls, 1);
    });

    test(
      'ignores resume lifecycle event when not protecting content',
      () async {
        // Act
        lifecycleService.updateState(AppLifecycleState.resumed);
        await Future<void>.delayed(const Duration(milliseconds: 10));

        // Assert
        expect(screenshotOffCalls, 0);
      },
    );

    test('continues when disabling screenshot fails with exception', () async {
      // Arrange
      screenshotOffShouldThrow = true;

      // Act & Assert
      await expectLater(service.enableProtectedContent(), completes);
      expect(screenshotOffCalls, 1);
    });

    test('continues when disabling screenshot returns false', () async {
      // Arrange
      screenshotOffResult = false;

      // Act
      await service.enableProtectedContent();

      // Assert
      expect(screenshotOffCalls, 1);
      expect(screenshotOnCalls, 0);
    });

    test('re-enables screenshot only once after matching disables', () async {
      // Arrange
      await service.enableProtectedContent();
      await service.enableProtectedContent();
      screenshotOffCalls = 0;
      screenshotOnCalls = 0;

      // Act
      await service.disableProtectedContent();
      await service.disableProtectedContent();

      // Assert
      expect(screenshotOnCalls, 1);
      expect(screenshotOffCalls, 0);
    });
  });
}
