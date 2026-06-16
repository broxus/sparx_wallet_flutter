import 'dart:convert';
import 'dart:io';

import 'package:app/app/service/storage_service/storage_backup_service.dart';
import 'package:encrypted_storage/encrypted_storage.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:path_provider_platform_interface/path_provider_platform_interface.dart';

import '../../../test_helpers/fake_path_provider_platform.dart';

class _MockEncryptedStorage extends Mock implements EncryptedStorage {}

const _domains = [
  'default',
  'passwords_key',
  'hidden_accounts_key',
  'seeds_meta_key',
  'nekoton_bridge_key',
  'external_accounts_key',
  'account_seed_preferences_key',
];

const _fileName = 'storage_backup.json';
const _password = 'super-secret-password';

void main() {
  TestWidgetsFlutterBinding.ensureInitialized();

  group('StorageBackupService', () {
    late Directory tempDir;
    late _MockEncryptedStorage storage;
    late StorageBackupService service;

    /// In-memory representation of the secure storage, keyed by domain.
    late Map<String, Map<String, String>> secureStorage;

    File backupFile() => File('${tempDir.path}/$_fileName');

    setUpAll(() {
      registerFallbackValue(<String, String>{});
    });

    setUp(() async {
      tempDir = await Directory.systemTemp.createTemp('storage_backup_test');
      PathProviderPlatform.instance = FakePathProviderPlatform(tempDir);

      storage = _MockEncryptedStorage();
      service = StorageBackupService(storage);

      secureStorage = {
        for (final domain in _domains) domain: <String, String>{},
      };

      when(() => storage.getDomain(domain: any(named: 'domain'))).thenAnswer((
        invocation,
      ) async {
        final domain = invocation.namedArguments[#domain] as String;
        return Map<String, String>.from(secureStorage[domain] ?? {});
      });

      when(
        () => storage.setDomain(any(), domain: any(named: 'domain')),
      ).thenAnswer((invocation) async {
        final pairs =
            invocation.positionalArguments.first as Map<String, String>;
        final domain = invocation.namedArguments[#domain] as String;
        secureStorage[domain] = Map<String, String>.from(pairs);
      });
    });

    tearDown(() async {
      if (tempDir.existsSync()) {
        await tempDir.delete(recursive: true);
      }
    });

    group('isBackupAvailable', () {
      test('returns false when no backup file exists', () async {
        expect(await service.isBackupAvailable(), isFalse);
      });

      test('returns true after a backup has been created', () async {
        await service.backup(_password);

        expect(await service.isBackupAvailable(), isTrue);
      });
    });

    group('backup', () {
      test('reads every domain from secure storage', () async {
        await service.backup(_password);

        for (final domain in _domains) {
          verify(() => storage.getDomain(domain: domain)).called(1);
        }
      });

      test('writes an encrypted file containing iv and data', () async {
        await service.backup(_password);

        final file = backupFile();
        expect(file.existsSync(), isTrue);

        final content =
            jsonDecode(await file.readAsString()) as Map<String, dynamic>;
        expect(content['iv'], isA<String>());
        expect(content['data'], isA<String>());
        // Plaintext data must not be readable from the file.
        expect(content['data'], isNot(contains('foo')));
      });

      test('overwrites a previously created backup file', () async {
        await service.backup(_password);
        final first = await backupFile().readAsString();

        await service.backup(_password);
        final second = await backupFile().readAsString();

        // A fresh random IV is used each time, so the payload differs.
        expect(first, isNot(equals(second)));
        expect(backupFile().existsSync(), isTrue);
      });
    });

    group('restore', () {
      test('throws when no backup file exists', () async {
        await expectLater(service.restore(_password), throwsException);
      });

      test('restores all domains and deletes the backup file', () async {
        secureStorage['default'] = {'foo': 'bar', 'count': '42'};
        secureStorage['passwords_key'] = {'pwd': 'value'};

        await service.backup(_password);

        // Simulate a fresh device where secure storage is empty.
        secureStorage = {
          for (final domain in _domains) domain: <String, String>{},
        };

        await service.restore(_password);

        expect(secureStorage['default'], {'foo': 'bar', 'count': '42'});
        expect(secureStorage['passwords_key'], {'pwd': 'value'});
        expect(backupFile().existsSync(), isFalse);
      });

      test('throws when the password is incorrect', () async {
        secureStorage['default'] = {'foo': 'bar'};

        await service.backup(_password);

        await expectLater(
          service.restore('wrong-password'),
          throwsA(isA<Object>()),
        );
        // The backup file is preserved on a failed restore.
        expect(backupFile().existsSync(), isTrue);
      });
    });

    test('backup then restore round-trips data unchanged', () async {
      secureStorage['default'] = {'a': '1'};
      secureStorage['seeds_meta_key'] = {'seed': 'meta'};
      secureStorage['nekoton_bridge_key'] = {'bridge': 'data'};

      final original = {
        for (final entry in secureStorage.entries)
          entry.key: Map<String, String>.from(entry.value),
      };

      await service.backup(_password);

      secureStorage = {
        for (final domain in _domains) domain: <String, String>{},
      };

      await service.restore(_password);

      expect(secureStorage, original);
    });
  });
}
