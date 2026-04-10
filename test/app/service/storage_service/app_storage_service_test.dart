import 'package:app/app/service/storage_service/app_storage_service.dart';
import 'package:flutter_test/flutter_test.dart';

import '../../../helpers/helpers.dart';

void main() {
  group('AppStorageService', () {
    late InMemoryStorageAdapter storageAdapter;
    late AppStorageService service;

    setUp(() {
      storageAdapter = InMemoryStorageAdapter();
      service = AppStorageService(storageAdapter);
    });

    test('addValue/getValue/delete work with storage keys', () {
      final key = StorageKey.userWithNewWallet();

      service.addValue<bool>(key, true);

      expect(service.getValue<bool>(key), isTrue);

      service.delete(key);

      expect(service.getValue<bool>(key), isNull);
    });

    test('getValueStream emits current and updated values', () async {
      final key = StorageKey.accountColor('pubkey');

      service.addValue<String>(key, 'red');

      final expectation = expectLater(
        service.getValueStream<String>(key).take(3),
        emitsInOrder(<String?>['red', 'blue', null]),
      );

      service
        ..addValue<String>(key, 'blue')
        ..delete(key);

      await expectation;
    });

    test('StorageKey keeps plain and entity-based formats stable', () {
      expect(StorageKey.userWithNewWallet().value, 'userWithNewWallet');
      expect(
        StorageKey.accountColor('pubkey').value,
        'sparx:accountColor:pubkey',
      );
      expect(
        StorageKey.showingNewTokensLabel('master-key').value,
        'sparx:showingNewTokensLabel:master-key',
      );
    });
  });
}
