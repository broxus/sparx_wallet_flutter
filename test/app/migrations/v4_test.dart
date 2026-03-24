import 'package:app/app/service/connection/data/connection/connection.dart';
import 'package:app/app/service/presets_connection/presets_connection_service.dart';
import 'package:app/app/service/storage_service/balance_storage_service.dart';
import 'package:app/app/service/storage_service/general_storage_service.dart';
import 'package:app/app/service/storage_service/migrations/storage_migrations/v4.dart';
import 'package:app/utils/common_utils.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';

import '../../helpers/helpers.dart';

class _MockPresetsConnectionService extends Mock
    implements PresetsConnectionService {}

void main() {
  TestWidgetsFlutterBinding.ensureInitialized();

  late _MockPresetsConnectionService presetsConnectionService;
  late StorageMigrationV4 migration;
  late InMemoryStorageAdapter storageAdapter;

  late List<String> currencyContainers;
  late List<String> balanceContainers;

  setUpAll(() {
    currencyContainers = [
      GeneralStorageService.currenciesContainer,
      GeneralStorageService.systemContractAssetsContainer,
      GeneralStorageService.customContractAssetsContainer,
    ];

    balanceContainers = [...BalanceStorageService.containers];
  });

  setUp(() async {
    presetsConnectionService = _MockPresetsConnectionService();
    storageAdapter = InMemoryStorageAdapter();

    when(() => presetsConnectionService.connections).thenReturn(<Connection>[]);

    migration = StorageMigrationV4(presetsConnectionService, storageAdapter);

    for (final c in currencyContainers) {
      await storageAdapter.init(c);
      await storageAdapter.box(c).erase();
    }
    for (final c in balanceContainers) {
      await storageAdapter.init(c);
      await storageAdapter.box(c).erase();
    }
  });

  tearDown(() async {
    for (final c in currencyContainers) {
      await storageAdapter.init(c);
      await storageAdapter.box(c).erase();
    }
    for (final c in balanceContainers) {
      await storageAdapter.init(c);
      await storageAdapter.box(c).erase();
    }
  });

  test('Move keys from networkType::id to group::id', () async {
    // given
    for (final container in balanceContainers) {
      final storage = storageAdapter.box(container);

      await storage.write('ever::123', 'val-ever');
      await storage.write('venom::456', 'val-venom');
      await storage.write('invalidKey', 'val-invalid');

      expect(storage.read<String>('ever::123'), 'val-ever');
      expect(storage.read<String>('venom::456'), 'val-venom');
      expect(storage.read<String>('invalidKey'), 'val-invalid');
    }

    await migration.apply();

    for (final container in balanceContainers) {
      final storage = storageAdapter.box(container);

      final everGroup = getNetworkGroupByNetworkType('ever');
      final venomGroup = getNetworkGroupByNetworkType('venom');

      expect(storage.read<String>('ever::123'), isNull);
      expect(storage.read<String>('venom::456'), isNull);

      expect(
        storage.read<String>('$everGroup::123'),
        'val-ever',
        reason: 'ever::123 must move to $everGroup::123',
      );
      expect(
        storage.read<String>('$venomGroup::456'),
        'val-venom',
        reason: 'venom::456 must move to $venomGroup::456',
      );

      expect(storage.read<String>('invalidKey'), 'val-invalid');
    }
  });
  test('Update networkGroup', () async {
    for (final container in currencyContainers) {
      final storage = storageAdapter.box(container);

      final value = [
        {'networkType': 'ever'},
        {'networkType': 'venom', 'networkGroup': 'keep-me'},
      ];

      await storage.write('custom', value);

      expect(storage.read<List<dynamic>>('custom'), isNotNull);
    }

    await migration.apply();

    for (final container in currencyContainers) {
      final storage = storageAdapter.box(container);

      expect(
        storage.read<List<dynamic>>('custom'),
        isNull,
        reason: 'custom-keys is removed',
      );
    }
  });
}
