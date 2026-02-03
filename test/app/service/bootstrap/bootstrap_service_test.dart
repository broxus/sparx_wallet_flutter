import 'package:app/app/service/bootstrap/bootstrap_service.dart';
import 'package:app/app/service/bootstrap/bootstrap_steps.dart';
import 'package:app/app/service/bootstrap/configurators/biometry.dart';
import 'package:app/app/service/bootstrap/configurators/connection.dart';
import 'package:app/app/service/bootstrap/configurators/encrypted_storage.dart';
import 'package:app/app/service/bootstrap/configurators/features.dart';
import 'package:app/app/service/bootstrap/configurators/migrate_storage.dart';
import 'package:app/app/service/bootstrap/configurators/nekoton.dart';
import 'package:app/app/service/bootstrap/configurators/ntp.dart';
import 'package:app/app/service/bootstrap/configurators/storage_services.dart';
import 'package:app/app/service/presets_connection/presets_connection_service.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';

class MockPresetsConnectionService extends Mock
    implements PresetsConnectionService {}

class MockBiometryConfigurator extends Mock implements BiometryConfigurator {}

class MockConnectionConfigurator extends Mock
    implements ConnectionConfigurator {}

class MockEncryptedStorageConfigurator extends Mock
    implements EncryptedStorageConfigurator {}

class MockFeatureServicesConfigurator extends Mock
    implements FeatureServicesConfigurator {}

class MockMigrateConfigurator extends Mock implements MigrateConfigurator {}

class MockStorageConfigurator extends Mock implements StorageConfigurator {}

class MockNekotonConfigurator extends Mock implements NekotonConfigurator {}

class MockNtpConfigurator extends Mock implements NtpConfigurator {}

void main() {
  late MockPresetsConnectionService presets;
  late MockBiometryConfigurator biometry;
  late MockConnectionConfigurator connection;
  late MockEncryptedStorageConfigurator encryptedStorage;
  late MockFeatureServicesConfigurator features;
  late MockMigrateConfigurator migrate;
  late MockStorageConfigurator storageServices;
  late MockNekotonConfigurator nekoton;
  late MockNtpConfigurator ntp;

  late BootstrapService service;

  setUp(() {
    presets = MockPresetsConnectionService();
    biometry = MockBiometryConfigurator();
    connection = MockConnectionConfigurator();
    encryptedStorage = MockEncryptedStorageConfigurator();
    features = MockFeatureServicesConfigurator();
    migrate = MockMigrateConfigurator();
    storageServices = MockStorageConfigurator();
    nekoton = MockNekotonConfigurator();
    ntp = MockNtpConfigurator();

    when(() => encryptedStorage.configure()).thenAnswer((_) async {});
    when(() => presets.fetchConnectionsList()).thenAnswer((_) async {});
    when(() => migrate.configure()).thenAnswer((_) async {});
    when(() => storageServices.configure()).thenAnswer((_) async {});
    when(() => ntp.configure()).thenAnswer((_) async {});
    when(() => nekoton.configure()).thenAnswer((_) async {});
    when(() => biometry.configure()).thenAnswer((_) async {});
    when(() => connection.configure()).thenAnswer((_) async {});
    when(() => features.configure()).thenAnswer((_) async {});

    service = BootstrapService(
      presets,
      biometry,
      connection,
      encryptedStorage,
      features,
      migrate,
      storageServices,
      nekoton,
      ntp,
    );
  });

  test('init(): runs steps in order and ends with completed', () async {
    final steps = <BootstrapSteps>[];
    final sub = service.bootstrapStepStream.listen(steps.add);

    final ok = await service.init();

    await Future<void>.delayed(const Duration(seconds: 1));

    await sub.cancel();

    expect(ok, isTrue);
    expect(service.bootstrapStep, BootstrapSteps.completed);
    expect(service.isConfigured, isTrue);

    expect(
      steps,
      containsAllInOrder([
        BootstrapSteps.empty,
        BootstrapSteps.remoteNetworks,
        BootstrapSteps.storage,
        BootstrapSteps.connection,
        BootstrapSteps.features,
        BootstrapSteps.completed,
      ]),
    );
  });

  test(
    'init(): returns false when any step throws and does not reach completed',
    () async {
      when(() => ntp.configure()).thenThrow(Exception('ntp fail'));

      final ok = await service.init();

      expect(ok, isFalse);
      expect(service.bootstrapStep, isNot(BootstrapSteps.completed));
      expect(service.isConfigured, isFalse);

      verify(() => encryptedStorage.configure()).called(1);
      verify(() => presets.fetchConnectionsList()).called(1);
      verify(() => migrate.configure()).called(1);
      verify(() => storageServices.configure()).called(1);

      verify(() => ntp.configure()).called(1);

      verifyNever(() => nekoton.configure());
      verifyNever(() => biometry.configure());
      verifyNever(() => connection.configure());
      verifyNever(() => features.configure());
    },
  );

  test('rerunFailedSteps(): does nothing if already completed', () async {
    await service.init();
    expect(service.bootstrapStep, BootstrapSteps.completed);

    await service.rerunFailedSteps();

    verify(() => presets.fetchConnectionsList()).called(1);
    verify(() => migrate.configure()).called(1);
    verify(() => connection.configure()).called(1);
    verify(() => features.configure()).called(1);
  });

  test(
    'rerunFailedSteps(): reruns from current failed step and reaches completed',
    () async {
      when(() => migrate.configure()).thenThrow(Exception('migrate fail'));
      final ok = await service.init();
      expect(ok, isFalse);

      expect(service.bootstrapStep, BootstrapSteps.storage);

      when(() => migrate.configure()).thenAnswer((_) async {});

      await service.rerunFailedSteps();

      expect(service.bootstrapStep, BootstrapSteps.completed);
      expect(service.isConfigured, isTrue);

      verify(() => presets.fetchConnectionsList()).called(1);

      verify(() => migrate.configure()).called(2);

      verify(() => storageServices.configure()).called(greaterThanOrEqualTo(1));
      verify(() => ntp.configure()).called(greaterThanOrEqualTo(1));
      verify(() => nekoton.configure()).called(greaterThanOrEqualTo(1));
      verify(() => biometry.configure()).called(greaterThanOrEqualTo(1));
      verify(() => connection.configure()).called(greaterThanOrEqualTo(1));
      verify(() => features.configure()).called(greaterThanOrEqualTo(1));
    },
  );

  test(
    'rerunFailedSteps(): updates subject to failed step and rethrows',
    () async {
      when(
        () => connection.configure(),
      ).thenThrow(Exception('connection fail'));

      final ok = await service.init();
      expect(ok, isFalse);

      expect(service.bootstrapStep, BootstrapSteps.connection);

      await expectLater(
        () => service.rerunFailedSteps(),
        throwsA(isA<Exception>()),
      );

      expect(service.bootstrapStep, BootstrapSteps.connection);

      verifyNever(() => features.configure());
    },
  );
}
