import 'package:app/app/service/app_version_service.dart';
import 'package:app/app/service/ntp_service.dart';
import 'package:app/app/service/storage_service/app_storage_service.dart';
import 'package:app/feature/presets_config/data/preset_config_type.dart';
import 'package:app/feature/presets_config/data/release_note.dart';
import 'package:app/feature/presets_config/data/release_notes.dart';
import 'package:app/feature/presets_config/data/update_rules.dart';
import 'package:app/feature/presets_config/domain/presets_config_reader.dart';
import 'package:app/feature/update_version/data/update_request.dart';
import 'package:app/feature/update_version/data/update_status.dart';
import 'package:app/feature/update_version/domain/latest_version_finder.dart';
import 'package:app/feature/update_version/domain/update_service.dart';
import 'package:app/feature/update_version/domain/update_status_checker.dart';
import 'package:app/feature/update_version/domain/version_comparator.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:get_it/get_it.dart';
import 'package:mocktail/mocktail.dart';

class MockPresetsConfigReader extends Mock implements PresetsConfigReader {}

class MockVersionComparator extends Mock implements VersionComparator {}

class MockUpdateStatusChecker extends Mock implements UpdateStatusChecker {}

class MockAppStorageService extends Mock implements AppStorageService {}

class MockLatestVersionFinder extends Mock implements LatestVersionFinder {}

class MockAppVersionService extends Mock implements AppVersionService {}

class MockNtpService extends Mock implements NtpService {}

void main() {
  late UpdateService updateService;
  late MockPresetsConfigReader mockConfigReader;
  late MockUpdateStatusChecker mockUpdateStatusChecker;
  late MockLatestVersionFinder mockLatestVersionFinder;
  late MockAppStorageService mockAppStorage;
  late MockAppVersionService mockAppVersionService;

  const testUpdateRules = UpdateRules(
    blockingVersion: '1.0.1',
    warningVersion: '1.0.2',
    warningShowTimes: 3,
    warningShowDelayS: 1800,
  );

  const currentVersion = '1.0.0';
  const testNewVersion = MapEntry(
    '1.5.0',
    ReleaseNote(
      available: true,
      info: 'Test release notes',
    ),
  );

  final testReleaseNotes = ReleaseNotes(
    notes: {testNewVersion.key: testNewVersion.value},
  );

  void emulateStatus(UpdateStatus status) {
    when(
      () => mockUpdateStatusChecker.checkUpdateStatus(
        currentVersion,
        testUpdateRules,
      ),
    ).thenReturn(status);
  }

  void expectUpdateRequest(UpdateStatus status) {
    expect(
      updateService.updateRequests,
      emits(
        predicate<UpdateRequest?>(
          (request) {
            if (status == UpdateStatus.none) return request == null;

            return request != null &&
                request.status == status &&
                request.targetVersion == testNewVersion.key &&
                request.releaseNote == testNewVersion.value;
          },
        ),
      ),
    );
  }

  final testTime = DateTime.now();

  setUp(() {
    mockConfigReader = MockPresetsConfigReader();
    mockUpdateStatusChecker = MockUpdateStatusChecker();
    mockLatestVersionFinder = MockLatestVersionFinder();
    mockAppStorage = MockAppStorageService();
    mockAppVersionService = MockAppVersionService();

    // Create a mock NtpService
    final mockNtpService = MockNtpService();

    // Register the mock NtpService with GetIt
    GetIt.I.registerSingleton<NtpService>(mockNtpService);

    // Set up the mock NtpService to return the current time
    when(mockNtpService.now).thenReturn(testTime);

    updateService = UpdateService(
      mockConfigReader,
      mockUpdateStatusChecker,
      mockLatestVersionFinder,
      mockAppStorage,
      mockAppVersionService,
    );

    // Mock AppVersion.appVersion
    when(mockAppVersionService.appVersion)
        .thenAnswer((_) async => Future.value(currentVersion));
    when(
      () => mockConfigReader.getConfig(PresetConfigType.updateRules),
    ).thenAnswer((_) async => testUpdateRules);
    when(
      () => mockConfigReader.getConfig(PresetConfigType.releaseNotes),
    ).thenAnswer((_) async => testReleaseNotes);
    when(
      () => mockLatestVersionFinder.findLatestVersion(
        testReleaseNotes,
        currentVersion,
      ),
    ).thenReturn(testNewVersion);
  });

  group('UpdateService', () {
    test(
      'initialize should load configurations and check for updates',
      () async {
        // Arrange
        emulateStatus(UpdateStatus.blocking);

        // Act
        await updateService.init();

        // Assert
        verify(
          () => mockConfigReader.getConfig(PresetConfigType.updateRules),
        ).called(1);
        verify(
          () => mockConfigReader.getConfig(PresetConfigType.releaseNotes),
        ).called(1);
        verify(
          () {
            return mockUpdateStatusChecker.checkUpdateStatus(
              currentVersion,
              testUpdateRules,
            );
          },
        ).called(1);
        verify(
          () {
            return mockLatestVersionFinder.findLatestVersion(
              testReleaseNotes,
              currentVersion,
            );
          },
        ).called(1);

        // Verify that an update request was emitted
        expectUpdateRequest(UpdateStatus.blocking);
      },
    );

    test(
      'should not emit update request when status is none',
      () async {
        // Arrange
        emulateStatus(UpdateStatus.none);

        // Act
        await updateService.init();

        // Assert
        verifyNever(
          () => mockConfigReader.getConfig(PresetConfigType.releaseNotes),
        );

        // Verify that an update request was emitted
        expectUpdateRequest(UpdateStatus.none);
      },
    );

    test(
      'should check warning display rules for warning status',
      () async {
        // Arrange
        when(() => mockAppStorage.getValue<int>(warningCountKey))
            .thenReturn(null);
        when(() => mockAppStorage.getValue<int>(warningLastTimeKey))
            .thenReturn(null);
        emulateStatus(UpdateStatus.warning);

        // Act
        await updateService.init();

        // Assert
        verify(
          () => mockConfigReader.getConfig(PresetConfigType.updateRules),
        ).called(1);
        verify(
          () => mockConfigReader.getConfig(PresetConfigType.releaseNotes),
        ).called(1);
        verify(() => mockAppStorage.getValue<int>(warningCountKey)).called(1);
        verify(() => mockAppStorage.getValue<int>(warningLastTimeKey))
            .called(1);
        verify(() => mockAppStorage.addValue(warningCountKey, 1)).called(1);
        verify(
          () {
            mockAppStorage.addValue(
              warningLastTimeKey,
              testTime.millisecondsSinceEpoch,
            );
          },
        ).called(1);

        // Verify that an update request was emitted
        expectUpdateRequest(UpdateStatus.warning);
      },
    );

    test(
      'should not show warning if count exceeds limit',
      () async {
        // Arrange
        when(() => mockAppStorage.getValue<int>(warningCountKey))
            .thenReturn(testUpdateRules.warningShowTimes);

        final delayedTestMills = testTime
            .subtract(Duration(seconds: testUpdateRules.warningShowDelayS + 1))
            .millisecondsSinceEpoch;

        when(() => mockAppStorage.getValue<int>(warningLastTimeKey))
            .thenReturn(delayedTestMills);

        emulateStatus(UpdateStatus.warning);

        // Act
        await updateService.init();

        // Assert
        verify(() => mockAppStorage.getValue<int>(warningCountKey)).called(1);
        verifyNever(() => mockAppStorage.getValue<int>(warningLastTimeKey));
        verifyNever(
          () => mockAppStorage.addValue(warningCountKey, any<dynamic>()),
        );
        verifyNever(
          () => mockAppStorage.addValue(warningLastTimeKey, any<dynamic>()),
        );

        // Verify that an update request wasn't emitted
        expectUpdateRequest(UpdateStatus.none);
      },
    );

    test(
      'should not show warning if not enough time has passed',
      () async {
        // Arrange
        when(() => mockAppStorage.getValue<int>(warningCountKey))
            .thenReturn(testUpdateRules.warningShowTimes - 1);

        final delayedTestMills = testTime
            .subtract(Duration(seconds: testUpdateRules.warningShowDelayS ~/ 2))
            .millisecondsSinceEpoch;

        when(() => mockAppStorage.getValue<int>(warningLastTimeKey))
            .thenReturn(delayedTestMills);

        emulateStatus(UpdateStatus.warning);

        // Act
        await updateService.init();

        // Assert
        verify(() => mockAppStorage.getValue<int>(warningCountKey)).called(1);
        verify(() => mockAppStorage.getValue<int>(warningLastTimeKey))
            .called(1);
        verifyNever(
          () => mockAppStorage.addValue(warningCountKey, any<dynamic>()),
        );
        verifyNever(
          () => mockAppStorage.addValue(warningLastTimeKey, any<dynamic>()),
        );

        // Verify that an update request wasn't emitted
        expectUpdateRequest(UpdateStatus.none);
      },
    );

    test(
      'should not show warning if not enough time has passed'
      ' and count exceeds limit',
      () async {
        // Arrange
        when(() => mockAppStorage.getValue<int>(warningCountKey))
            .thenReturn(testUpdateRules.warningShowTimes);

        final delayedTestMills = testTime
            .subtract(Duration(seconds: testUpdateRules.warningShowDelayS + 1))
            .millisecondsSinceEpoch;

        when(() => mockAppStorage.getValue<int>(warningLastTimeKey))
            .thenReturn(delayedTestMills);

        emulateStatus(UpdateStatus.warning);

        // Act
        await updateService.init();

        // Assert
        verify(() => mockAppStorage.getValue<int>(warningCountKey)).called(1);
        verifyNever(() => mockAppStorage.getValue<int>(warningLastTimeKey));
        verifyNever(
          () => mockAppStorage.addValue(warningCountKey, any<dynamic>()),
        );
        verifyNever(
          () => mockAppStorage.addValue(warningLastTimeKey, any<dynamic>()),
        );

        // Verify that an update request wasn't emitted
        expectUpdateRequest(UpdateStatus.none);
      },
    );

    test(
      'dismissWarning should emit null',
      () async {
        // Arrange
        when(() => mockAppStorage.getValue<int>(warningCountKey))
            .thenReturn(null);
        when(() => mockAppStorage.getValue<int>(warningLastTimeKey))
            .thenReturn(null);
        emulateStatus(UpdateStatus.warning);

        // Act
        await updateService.init();

        // Verify that an update request was emitted
        expectUpdateRequest(UpdateStatus.warning);

        // Now dismiss the warning
        await updateService.dismissWarning();

        // Verify that null was emitted
        expectUpdateRequest(UpdateStatus.none);
      },
    );
  });

  tearDown(() {
    // Reset GetIt instance after each test
    GetIt.I.reset();
  });
}
