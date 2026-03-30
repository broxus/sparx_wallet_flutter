import 'package:app/app/service/storage_service/secure_storage_service.dart';
import 'package:app/feature/presets_config/data/preset_config_type.dart';
import 'package:encrypted_storage/encrypted_storage.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';

class _MockEncryptedStorage extends Mock implements EncryptedStorage {}

void main() {
  group('SecureStorageService', () {
    late _MockEncryptedStorage storage;
    late SecureStorageService service;

    setUp(() {
      storage = _MockEncryptedStorage();
      service = SecureStorageService(storage);

      when(() => storage.clearAll()).thenAnswer((_) async {});
      when(
        () => storage.get(any(), domain: any(named: 'domain')),
      ).thenAnswer((_) async => null);
      when(() => storage.get(any())).thenAnswer((_) async => null);
      when(
        () => storage.set(any(), any(), domain: any(named: 'domain')),
      ).thenAnswer((_) async {});
      when(() => storage.set(any(), any())).thenAnswer((_) async {});
    });

    test('clear preserves connection json and hash by default', () async {
      when(
        () => storage.get(
          'connection_json_hash_key',
          domain: 'connection_json_domain',
        ),
      ).thenAnswer((_) async => 'hash');
      when(
        () => storage.get(
          'connection_json_key',
          domain: 'connection_json_domain',
        ),
      ).thenAnswer((_) async => '{"network":"mainnet"}');

      await service.clear();

      verifyInOrder([
        () => storage.get(
          'connection_json_hash_key',
          domain: 'connection_json_domain',
        ),
        () => storage.get(
          'connection_json_key',
          domain: 'connection_json_domain',
        ),
        () => storage.clearAll(),
        () => storage.set(
          'connection_json_hash_key',
          'hash',
          domain: 'connection_json_domain',
        ),
        () => storage.set(
          'connection_json_key',
          '{"network":"mainnet"}',
          domain: 'connection_json_domain',
        ),
      ]);
    });

    test('clear skips restoring connection data when disabled', () async {
      await service.clear(isSaveConnectionJson: false);

      verify(() => storage.clearAll()).called(1);
      verifyNever(() => storage.get(any(), domain: 'connection_json_domain'));
      verifyNever(
        () => storage.set(any(), any(), domain: 'connection_json_domain'),
      );
    });

    test('config json and hash use config name and storage key', () async {
      await service.setConfigJson(PresetConfigType.updateRules, '{"ok":true}');
      await service.setConfigJsonHash(PresetConfigType.updateRules, 'hash-1');

      verify(
        () => storage.set(
          'update_rules_config',
          '{"ok":true}',
          domain: 'update_rules',
        ),
      ).called(1);
      verify(
        () => storage.set(
          'update_rules_config_hash',
          'hash-1',
          domain: 'update_rules',
        ),
      ).called(1);
    });
  });
}
