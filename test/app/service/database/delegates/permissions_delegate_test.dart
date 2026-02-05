import 'dart:io';

import 'package:app/app/service/database/delegates/permissions_delegate.dart';
import 'package:app/app/service/database/main_database.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:path/path.dart' as p;
import 'package:path_provider_platform_interface/path_provider_platform_interface.dart';

class _FakePathProviderPlatform extends PathProviderPlatform {
  _FakePathProviderPlatform(this._appDocsDir);

  final Directory _appDocsDir;

  @override
  Future<String?> getApplicationDocumentsPath() async => _appDocsDir.path;
}

class _ThrowingPathProviderPlatform extends PathProviderPlatform {
  @override
  Future<String?> getApplicationDocumentsPath() {
    throw StateError(
      'PathProvider used before test setUp(): MainDatabase was created too early',
    );
  }
}

void main() {
  TestWidgetsFlutterBinding.ensureInitialized();

  late Directory tempDir;
  late MainDatabase db;
  late PermissionsDelegate delegate;

  setUpAll(() {
    // If the base is accidentally created before setUp, then PathProvider will
    // be called and the test should fail to avoid accessing the real path.
    PathProviderPlatform.instance = _ThrowingPathProviderPlatform();
  });

  setUp(() async {
    tempDir = await Directory.systemTemp.createTemp('drift_perm_db_test_');
    PathProviderPlatform.instance = _FakePathProviderPlatform(tempDir);

    db = MainDatabase();
    delegate = PermissionsDelegate(db);

    await delegate.clearAllPermissions();
  });

  tearDown(() async {
    await db.close();
    try {
      await tempDir.delete(recursive: true);
    } catch (_) {}
  });

  test('DB file is created in temp application documents dir', () async {
    final expectedPath = p.join(tempDir.path, 'main.db');
    expect(File(expectedPath).existsSync(), isTrue);
  });

  test('db is not created in project directory', () async {
    expect(File('main.db').existsSync(), isFalse);
  });

  test('savePermissions: ignores empty/whitespace-only permissions', () async {
    await delegate.savePermissions('example.com', ['   ', '', '\n\t ']);

    final ok = await delegate.checkPermissions('example.com', ['   ']);
    expect(ok, isTrue);

    final ok2 = await delegate.checkPermissions('example.com', ['camera']);
    expect(ok2, isFalse);
  });

  test(
    'savePermissions: normalizes (trim + lowercase) and de-duplicates',
    () async {
      await delegate.savePermissions('example.com', [
        '  CAMERA ',
        'camera',
        'CaMeRa',
        '  mic ',
        'MIC',
        '   ', // мусор
      ]);

      expect(
        await delegate.checkPermissions('example.com', ['camera']),
        isTrue,
      );
      expect(await delegate.checkPermissions('example.com', ['mic']), isTrue);
      expect(
        await delegate.checkPermissions('example.com', ['camera', 'mic']),
        isTrue,
      );

      expect(
        await delegate.checkPermissions('example.com', ['location']),
        isFalse,
      );
    },
  );

  test(
    'savePermissions: insertOrIgnore does not break when called twice',
    () async {
      await delegate.savePermissions('example.com', ['camera', 'mic']);
      await delegate.savePermissions('example.com', ['camera', 'mic']);

      expect(
        await delegate.checkPermissions('example.com', ['camera', 'mic']),
        isTrue,
      );
    },
  );

  test(
    'checkPermissions: empty/invalid requested permissions => true',
    () async {
      expect(await delegate.checkPermissions('example.com', []), isTrue);
      expect(
        await delegate.checkPermissions('example.com', [' ', '\n']),
        isTrue,
      );
    },
  );

  test(
    'checkPermissions: returns false if at least one permission missing',
    () async {
      await delegate.savePermissions('example.com', ['camera']);

      expect(
        await delegate.checkPermissions('example.com', ['camera']),
        isTrue,
      );
      expect(
        await delegate.checkPermissions('example.com', ['camera', 'mic']),
        isFalse,
      );
    },
  );

  test(
    'checkPermissions: host is isolated (same perm on other host does not count)',
    () async {
      await delegate.savePermissions('a.com', ['camera', 'mic']);
      await delegate.savePermissions('b.com', ['camera']); // mic нет

      expect(
        await delegate.checkPermissions('a.com', ['camera', 'mic']),
        isTrue,
      );
      expect(
        await delegate.checkPermissions('b.com', ['camera', 'mic']),
        isFalse,
      );
    },
  );

  test(
    'clearAllPermissions: deletes everything and returns deleted rows count',
    () async {
      await delegate.savePermissions('a.com', ['camera', 'mic']);
      await delegate.savePermissions('b.com', ['camera']);

      expect(
        await delegate.checkPermissions('a.com', ['camera', 'mic']),
        isTrue,
      );
      expect(await delegate.checkPermissions('b.com', ['camera']), isTrue);

      final deleted = await delegate.clearAllPermissions();

      expect(deleted, greaterThanOrEqualTo(1));

      expect(await delegate.checkPermissions('a.com', ['camera']), isFalse);
      expect(await delegate.checkPermissions('a.com', ['mic']), isFalse);
      expect(await delegate.checkPermissions('b.com', ['camera']), isFalse);
    },
  );

  test('savePermissions: does not throw on empty set (early return)', () async {
    await delegate.savePermissions('example.com', [' ', '']);
    expect(await delegate.checkPermissions('example.com', ['camera']), isFalse);
  });
}
