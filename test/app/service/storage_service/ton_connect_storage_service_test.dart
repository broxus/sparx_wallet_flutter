import 'package:app/app/service/storage_service/storage_adapter.dart';
import 'package:app/app/service/storage_service/ton_connect_storage_service.dart';
import 'package:flutter_test/flutter_test.dart';

import '../../../helpers/helpers.dart';

void main() {
  group('TonConnectStorageService', () {
    late InMemoryStorageAdapter storageAdapter;
    late TonConnectStorageService service;
    late StorageBox storage;

    setUp(() {
      storageAdapter = InMemoryStorageAdapter();
      storage = storageAdapter.box(TonConnectStorageService.container);
      service = TonConnectStorageService(storageAdapter);
    });

    test('getEventId increments and stores the last used id', () {
      expect(service.getEventId(), 2);
      expect(service.getEventId(), 3);
      expect(storage.read<int>('event_id'), 3);
    });

    test(
      'readConnections clears invalid payload and returns empty list',
      () async {
        await storage.write('connections', ['broken-json']);

        final result = service.readConnections();

        expect(result, isEmpty);
        expect(storage.read<List<dynamic>>('connections'), isNull);
      },
    );

    test('saveLastEventId and clearConnections update storage state', () async {
      service.saveLastEventId('event-42');
      expect(service.readLastEventId(), 'event-42');

      await storage.write('connections', <dynamic>[]);
      expect(storage.read<List<dynamic>>('connections'), isNotNull);

      service.clearConnections();

      expect(storage.read<List<dynamic>>('connections'), isNull);
    });
  });
}
