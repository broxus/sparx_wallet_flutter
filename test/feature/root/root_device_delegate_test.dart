import 'package:app/feature/root_device_alert/domain/root_device_delegate.dart';
import 'package:flutter/services.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:shared_preferences/shared_preferences.dart';

void main() {
  TestWidgetsFlutterBinding.ensureInitialized();

  const channel = MethodChannel('root_checker_plus');
  late RootDeviceDelegate delegate;
  var methodCallsCount = 0;

  setUp(() {
    SharedPreferences.setMockInitialValues(<String, Object>{});
    delegate = RootDeviceDelegate();
    methodCallsCount = 0;
    TestDefaultBinaryMessengerBinding.instance.defaultBinaryMessenger
        .setMockMethodCallHandler(channel, (call) async {
          methodCallsCount++;
          return false;
        });
  });

  tearDown(() async {
    TestDefaultBinaryMessengerBinding.instance.defaultBinaryMessenger
        .setMockMethodCallHandler(channel, null);
  });

  group('RootDeviceDelegate', () {
    test(
      'isShowRootScreen returns true when user has not acknowledged root state',
      () async {
        final result = await delegate.isShowRootScreen;

        expect(result, isTrue);
      },
    );

    test('isShowRootScreen returns false when user has acknowledged root state',
        () async {
      SharedPreferences.setMockInitialValues(<String, Object>{
        RootDeviceDelegate.userKnowsRootKey: true,
      });

      final result = await delegate.isShowRootScreen;

      expect(result, isFalse);
    });

    test('setUserKnowRoot persists flag and hides root screen', () async {
      final isSaved = await delegate.setUserKnowRoot();
      final prefs = await SharedPreferences.getInstance();
      final shouldShowRootScreen = await delegate.isShowRootScreen;

      expect(isSaved, isTrue);
      expect(prefs.getBool(RootDeviceDelegate.userKnowsRootKey), isTrue);
      expect(shouldShowRootScreen, isFalse);
    });

    test('does not call plugin channel on non-mobile branch', () async {
      await delegate.isShowRootScreen;

      expect(methodCallsCount, 0);
    });
  });
}
