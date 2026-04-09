import 'package:app/app/service/storage_service/account_seed_storage_service.dart';
import 'package:encrypted_storage/encrypted_storage.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';

class _MockEncryptedStorage extends Mock implements EncryptedStorage {}

void main() {
  group('NekotonStorageService', () {
    late _MockEncryptedStorage storage;
    late NekotonStorageService service;

    setUpAll(() {
      registerFallbackValue('');
    });

    setUp(() {
      storage = _MockEncryptedStorage();
      service = NekotonStorageService(storage: storage);

      when(
        () => storage.getDomain(domain: any(named: 'domain')),
      ).thenAnswer((_) async => <String, String>{});
      when(
        () => storage.get(
          any(),
          domain: any(named: 'domain'),
          defaultValue: any(named: 'defaultValue'),
        ),
      ).thenAnswer((_) async => null);
      when(() => storage.clearAll()).thenAnswer((_) async {});
      when(() => storage.clearDomain(any())).thenAnswer((_) async {});
      when(
        () => storage.set(any(), any(), domain: any(named: 'domain')),
      ).thenAnswer((_) async {});
      when(
        () => storage.delete(any(), domain: any(named: 'domain')),
      ).thenAnswer((_) async {});
    });

    test(
      'init clears storage and retries when encryption error is detected',
      () async {
        var seedMetaCallCount = 0;

        when(() => storage.getDomain(domain: 'seeds_meta_key')).thenAnswer((
          _,
        ) async {
          seedMetaCallCount++;
          if (seedMetaCallCount == 1) {
            throw Exception('PaddingException');
          }

          return <String, String>{};
        });

        await service.init();

        verify(() => storage.clearAll()).called(1);
        expect(seedMetaCallCount, greaterThanOrEqualTo(2));
      },
    );

    test('init rethrows non-encryption errors', () async {
      when(
        () => storage.getDomain(domain: 'seeds_meta_key'),
      ).thenThrow(StateError('boom'));

      expect(service.init(), throwsA(isA<StateError>()));
      verifyNever(() => storage.clearAll());
    });

    test('clear swallows underlying clearSensitiveData errors', () async {
      when(() => storage.clearDomain(any())).thenThrow(Exception('failed'));

      await service.clear();
    });

    test('storage data methods delegate to encrypted storage', () async {
      when(
        () => storage.get(
          'key',
          domain: 'nekoton_bridge_key',
          defaultValue: any(named: 'defaultValue'),
        ),
      ).thenAnswer((_) async => 'value');

      expect(await service.getStorageData('key'), 'value');

      await service.setStorageData(key: 'key', value: 'value');
      await service.removeStorageData('key');
      await service.clearStorageData();

      verify(
        () => storage.get(
          'key',
          domain: 'nekoton_bridge_key',
          defaultValue: any(named: 'defaultValue'),
        ),
      ).called(1);
      verify(
        () => storage.set('key', 'value', domain: 'nekoton_bridge_key'),
      ).called(1);
      verify(
        () => storage.delete('key', domain: 'nekoton_bridge_key'),
      ).called(1);
      verify(() => storage.clearDomain('nekoton_bridge_key')).called(1);
    });

    test('setStorageData rethrows storage exception', () {
      when(
        () => storage.set('key', 'value', domain: 'nekoton_bridge_key'),
      ).thenThrow(StateError('set failed'));

      expect(
        () => service.setStorageData(key: 'key', value: 'value'),
        throwsA(isA<StateError>()),
      );
    });

    test('removeStorageData rethrows storage exception', () {
      when(
        () => storage.delete('key', domain: 'nekoton_bridge_key'),
      ).thenThrow(StateError('remove failed'));

      expect(
        () => service.removeStorageData('key'),
        throwsA(isA<StateError>()),
      );
    });

    test('clearStorageData rethrows storage exception', () {
      when(
        () => storage.clearDomain('nekoton_bridge_key'),
      ).thenThrow(StateError('clear failed'));

      expect(() => service.clearStorageData(), throwsA(isA<StateError>()));
    });
  });
}
