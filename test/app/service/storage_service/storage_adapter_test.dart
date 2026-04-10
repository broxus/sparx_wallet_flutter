import 'dart:io';

import 'package:app/app/service/storage_service/storage_adapter.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:path_provider_platform_interface/path_provider_platform_interface.dart';

import '../../../test_helpers/fake_path_provider_platform.dart';

void main() {
  TestWidgetsFlutterBinding.ensureInitialized();

  group('GetStorageAdapter', () {
    late Directory tempDir;
    late GetStorageAdapter adapter;

    setUp(() async {
      tempDir = await Directory.systemTemp.createTemp('storage_adapter_test');
      PathProviderPlatform.instance = FakePathProviderPlatform(tempDir);
      adapter = const GetStorageAdapter();
    });

    test('init + box allow reading and writing values', () async {
      final container = 'adapter_${DateTime.now().microsecondsSinceEpoch}';

      await adapter.init(container);
      final box = adapter.box(container);

      await box.write('key', 'value');

      expect(box.read<String>('key'), 'value');
      expect(box.hasData('key'), isTrue);
    });

    test('box supports initial data and change listeners', () async {
      final container = 'adapter_init_${DateTime.now().microsecondsSinceEpoch}';
      final box = adapter.box(container, tempDir.path, {'seeded': 1});

      await adapter.init(container);

      final changes = <Map<String, dynamic>>[];
      final cancel = box.listen(() {
        changes.add(box.changes);
      });

      expect(box.read<int>('seeded'), 1);

      await box.write('seeded', 2);
      await box.remove('seeded');

      cancel();

      expect(changes, isNotEmpty);
      expect(changes.first['seeded'], 2);
      expect(changes.last['seeded'], isNull);
    });
  });
}
