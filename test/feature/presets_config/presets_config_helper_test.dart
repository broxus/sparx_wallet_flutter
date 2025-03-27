import 'dart:convert';

import 'package:app/app/service/resources_service.dart';
import 'package:app/app/service/storage_service/secure_storage_service.dart';
import 'package:app/core/app_build_type.dart';
import 'package:app/feature/presets_config/presets_config.dart';
import 'package:app/http/api/presets/presets_api.dart';
import 'package:app/runner.dart' as runner;
import 'package:crypto/crypto.dart';
import 'package:dio/dio.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:retrofit/dio.dart';

class MockPresetsApi extends Mock implements PresetsApi {}

class MockSecureStorageService extends Mock implements SecureStorageService {}

class MockResourcesService extends Mock implements ResourcesService {}

const _buildType = AppBuildType.development;
const _config = PresetConfigType.updateRules;

void main() {
  late PresetsConfigReader reader;
  late MockPresetsApi mockPresetsApi;
  late MockSecureStorageService mockSecureStorage;
  late MockResourcesService mockResourcesService;

  setUp(() {
    mockPresetsApi = MockPresetsApi();
    mockSecureStorage = MockSecureStorageService();
    mockResourcesService = MockResourcesService();
    reader = PresetsConfigReader(
      mockPresetsApi,
      mockSecureStorage,
      mockResourcesService,
    );

    // Set app build type for tests
    runner.currentAppBuildType = _buildType;
  });

  group('getConfig', () {
    const testUpdateRules = UpdateRules(
      blockingVersion: '1.0.0',
      warningVersion: '1.5.0',
      warningShowTimes: 3,
      warningShowDelayS: 1800,
    );

    const testUpdateRulesJson = '''
    {
      "blockingVersion": "1.0.0",
      "warningVersion": "1.5.0",
      "warningShowTimes": 3,
      "warningShowDelayS": 1800
    }
    ''';

    test('should return remote config when available', () async {
      // Arrange
      when(
        () => mockPresetsApi.getPresetConfig(_config.getFileName(_buildType)),
      ).thenAnswer(
        (_) async => HttpResponse(
          testUpdateRulesJson,
          Response(
            requestOptions: RequestOptions(),
            statusCode: 200,
          ),
        ),
      );

      when(() => mockSecureStorage.getConfigJsonHash(_config))
          .thenAnswer((_) async => null);

      when(() => mockSecureStorage.setConfigJsonHash(_config, any()))
          .thenAnswer((_) async {});

      when(() => mockSecureStorage.setConfigJson(_config, any()))
          .thenAnswer((_) async {});

      // Act
      final result = await reader.getConfig(_config);
      final expectedHash =
          sha256.convert(utf8.encode(testUpdateRulesJson)).toString();

      // Assert
      expect(result, isNotNull);
      expect(result, testUpdateRules);

      // Delay for processing async _updateCacheIfNeed
      await Future<void>.delayed(const Duration(milliseconds: 50));

      verify(
        () => mockPresetsApi.getPresetConfig(_config.getFileName(_buildType)),
      ).called(1);
      verify(
        () => mockSecureStorage.getConfigJsonHash(_config),
      ).called(1);
      verify(
        () => mockSecureStorage.setConfigJsonHash(_config, expectedHash),
      ).called(1);
      verify(
        () => mockSecureStorage.setConfigJson(_config, testUpdateRulesJson),
      ).called(1);
    });

    test('should return cached config when remote fails', () async {
      // Arrange
      when(
        () => mockPresetsApi.getPresetConfig(_config.getFileName(_buildType)),
      ).thenThrow(Exception('Network error'));

      when(
        () => mockSecureStorage.getConfigJson(_config),
      ).thenAnswer((_) async => testUpdateRulesJson);

      // Act
      final result = await reader.getConfig(_config);

      // Assert
      expect(result, isNotNull);
      expect(result, testUpdateRules);

      // Delay for processing async _updateCacheIfNeed
      await Future<void>.delayed(const Duration(milliseconds: 50));

      verify(
        () => mockPresetsApi.getPresetConfig(_config.getFileName(_buildType)),
      ).called(1);
      verify(
        () => mockSecureStorage.getConfigJson(_config),
      ).called(1);
      verifyNever(
        () => mockSecureStorage.setConfigJsonHash(_config, any()),
      );
      verifyNever(
        () => mockSecureStorage.setConfigJson(_config, any()),
      );
    });

    test('should return local config when remote and cache fails', () async {
      // Arrange
      when(
        () => mockPresetsApi.getPresetConfig(_config.getFileName(_buildType)),
      ).thenThrow(Exception('Network error'));

      when(() => mockSecureStorage.getConfigJson(_config))
          .thenAnswer((_) async => null);

      when(
        () {
          return mockResourcesService
              .loadString('assets/configs/${_config.name}.json');
        },
      ).thenAnswer((_) async => testUpdateRulesJson);

      // Act
      final result = await reader.getConfig(_config);

      // Assert
      expect(result, isNotNull);
      expect(result, testUpdateRules);

      // Delay for processing async _updateCacheIfNeed
      await Future<void>.delayed(const Duration(milliseconds: 50));

      verify(
        () => mockPresetsApi.getPresetConfig(_config.getFileName(_buildType)),
      ).called(1);
      verify(
        () => mockSecureStorage.getConfigJson(_config),
      ).called(1);
      verify(
        () => mockResourcesService
            .loadString('assets/configs/${_config.name}.json'),
      ).called(1);
      verifyNever(
        () => mockSecureStorage.setConfigJsonHash(_config, any()),
      );
      verifyNever(
        () => mockSecureStorage.setConfigJson(_config, any()),
      );
    });
  });
}
