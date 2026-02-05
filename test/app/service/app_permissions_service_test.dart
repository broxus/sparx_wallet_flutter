import 'dart:io';

import 'package:app/app/service/app_permissions_service.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:permission_handler_platform_interface/permission_handler_platform_interface.dart';
import 'package:plugin_platform_interface/plugin_platform_interface.dart';

class FakePermissionHandlerPlatform extends PermissionHandlerPlatform
    with MockPlatformInterfaceMixin {
  final Map<Permission, PermissionStatus> _status =
      <Permission, PermissionStatus>{};
  final Map<Permission, PermissionStatus> _requestResult =
      <Permission, PermissionStatus>{};

  int checkCalls = 0;
  int requestCalls = 0;
  int openSettingsCalls = 0;

  void setStatus(Permission permission, PermissionStatus status) {
    _status[permission] = status;
  }

  void setRequestResult(Permission permission, PermissionStatus status) {
    _requestResult[permission] = status;
  }

  PermissionStatus _getStatus(Permission permission) =>
      _status[permission] ?? PermissionStatus.denied;

  @override
  Future<PermissionStatus> checkPermissionStatus(Permission permission) async {
    checkCalls++;
    return _getStatus(permission);
  }

  @override
  Future<Map<Permission, PermissionStatus>> requestPermissions(
    List<Permission> permissions,
  ) async {
    requestCalls++;
    final result = <Permission, PermissionStatus>{};

    for (final p in permissions) {
      final requested = _requestResult[p] ?? _getStatus(p);

      _status[p] = requested;
      result[p] = requested;
    }

    return result;
  }

  @override
  Future<bool> openAppSettings() async {
    openSettingsCalls++;
    return true;
  }

  @override
  Future<bool> shouldShowRequestPermissionRationale(
    Permission permission,
  ) async {
    return false;
  }
}

void main() {
  TestWidgetsFlutterBinding.ensureInitialized();

  late PermissionHandlerPlatform original;
  late FakePermissionHandlerPlatform fake;
  late AppPermissionsService service;

  setUp(() {
    original = PermissionHandlerPlatform.instance;
    fake = FakePermissionHandlerPlatform();
    PermissionHandlerPlatform.instance = fake;
    service = AppPermissionsService();
  });

  tearDown(() {
    PermissionHandlerPlatform.instance = original;
  });

  group('requestPermissions(list)', () {
    test(
      'true when all statuses are good (granted/limited/restricted)',
      () async {
        fake
          ..setRequestResult(Permission.camera, PermissionStatus.granted)
          ..setRequestResult(Permission.microphone, PermissionStatus.limited);

        final ok = await service.requestPermissions([
          Permission.camera,
          Permission.microphone,
        ]);

        expect(ok, isTrue);
        expect(fake.requestCalls, 1);
      },
    );

    test('false when any status is not good', () async {
      fake
        ..setRequestResult(Permission.camera, PermissionStatus.granted)
        ..setRequestResult(Permission.microphone, PermissionStatus.denied);

      final ok = await service.requestPermissions([
        Permission.camera,
        Permission.microphone,
      ]);

      expect(ok, isFalse);
      expect(fake.requestCalls, 1);
    });
  });

  group('requestPermission(permission)', () {
    test(
      'returns false if shouldAskForSettings becomes true (permanentlyDenied)',
      () async {
        fake
          ..setStatus(Permission.camera, PermissionStatus.denied)
          ..setRequestResult(
            Permission.camera,
            PermissionStatus.permanentlyDenied,
          );

        final ok = await service.requestPermission(Permission.camera);

        expect(ok, isFalse);
      },
    );

    test('returns true when request ends up granted', () async {
      fake
        ..setStatus(Permission.camera, PermissionStatus.denied)
        ..setRequestResult(Permission.camera, PermissionStatus.granted);

      final ok = await service.requestPermission(Permission.camera);

      expect(ok, isTrue);
    });

    test(
      'returns false when request ends up denied (and shouldAskForSettings stays false)',
      () async {
        fake
          ..setStatus(Permission.camera, PermissionStatus.denied)
          ..setRequestResult(Permission.camera, PermissionStatus.denied);

        final ok = await service.requestPermission(Permission.camera);

        expect(ok, isFalse);
      },
    );
  });

  group('shouldAskForSettings(permission)', () {
    test('non-Android: request permanentlyDenied => true', () async {
      fake
        ..setStatus(Permission.camera, PermissionStatus.denied)
        ..setRequestResult(
          Permission.camera,
          PermissionStatus.permanentlyDenied,
        );

      final shouldAsk = await service.shouldAskForSettings(Permission.camera);

      expect(shouldAsk, isTrue);
    });
  });

  group('convenience', () {
    test('requestCamera delegates to requestPermission(camera)', () async {
      fake
        ..setStatus(Permission.camera, PermissionStatus.denied)
        ..setRequestResult(Permission.camera, PermissionStatus.granted);

      final ok = await service.requestCamera();
      expect(ok, isTrue);
    });

    test(
      'requestPhotos: non-Android requests Permission.photos',
      () async {
        fake
          ..setStatus(Permission.photos, PermissionStatus.denied)
          ..setRequestResult(Permission.photos, PermissionStatus.granted);

        final ok = await service.requestPhotos();

        expect(ok, isTrue);
        expect(fake.requestCalls, 1);
      },
      skip: Platform.isAndroid,
    );

    test('openSettings calls platform openAppSettings', () async {
      await service.openSettings();
      expect(fake.openSettingsCalls, 1);
    });
  });
}
