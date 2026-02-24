import 'package:app/app/service/connection/json_converters/polling_config_converter.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:nekoton_repository/nekoton_repository.dart';

void main() {
  const converter = PollingConfigConverter();

  group('PollingConfigConverter', () {
    test('fromJson returns null when json is null', () {
      // Act
      final result = converter.fromJson(null);

      // Assert
      expect(result, isNull);
    });

    test('fromJson parses valid intervals and sseBaseUrl', () {
      // Arrange
      final json = {
        'tonWalletRefreshInterval': 10,
        'tokenWalletRefreshInterval': 20,
        'intensivePollingInterval': 30,
        'sseBaseUrl': 'https://example.com/sse',
      };

      // Act
      final result = converter.fromJson(json);

      // Assert
      expect(result, isNotNull);
      expect(result!.tonWalletRefreshInterval, const Duration(seconds: 10));
      expect(result.tokenWalletRefreshInterval, const Duration(seconds: 20));
      expect(result.intensivePollingInterval, const Duration(seconds: 30));
      expect(result.sseBaseUrl, 'https://example.com/sse');
    });

    test('fromJson parses string intervals', () {
      // Arrange
      final json = {
        'tonWalletRefreshInterval': '15',
        'tokenWalletRefreshInterval': '25',
        'intensivePollingInterval': '35',
      };

      // Act
      final result = converter.fromJson(json);

      // Assert
      expect(result, isNotNull);
      expect(result!.tonWalletRefreshInterval, const Duration(seconds: 15));
      expect(result.tokenWalletRefreshInterval, const Duration(seconds: 25));
      expect(result.intensivePollingInterval, const Duration(seconds: 35));
    });

    test('fromJson uses defaults when intervals are invalid', () {
      // Arrange
      final json = <String, dynamic>{
        'tonWalletRefreshInterval': 'not-int',
        'tokenWalletRefreshInterval': null,
        'intensivePollingInterval': <String, dynamic>{},
      };
      const defaults = PollingConfig.defaultConfig;

      // Act
      final result = converter.fromJson(json);

      // Assert
      expect(result, isNotNull);
      expect(
        result!.tonWalletRefreshInterval,
        defaults.tonWalletRefreshInterval,
      );
      expect(
        result.tokenWalletRefreshInterval,
        defaults.tokenWalletRefreshInterval,
      );
      expect(
        result.intensivePollingInterval,
        defaults.intensivePollingInterval,
      );
    });

    test('fromJson ignores invalid sseBaseUrl', () {
      // Arrange
      final json = {'sseBaseUrl': 'ftp://example.com/sse'};

      // Act
      final result = converter.fromJson(json);

      // Assert
      expect(result, isNotNull);
      expect(result!.sseBaseUrl, isNull);
    });

    test('fromJson ignores empty sseBaseUrl', () {
      // Arrange
      final json = {'sseBaseUrl': ''};

      // Act
      final result = converter.fromJson(json);

      // Assert
      expect(result, isNotNull);
      expect(result!.sseBaseUrl, isNull);
    });

    test('toJson returns null when config is null', () {
      // Act
      final result = converter.toJson(null);

      // Assert
      expect(result, isNull);
    });

    test('toJson serializes intervals in seconds', () {
      // Arrange
      const config = PollingConfig(
        tonWalletRefreshInterval: Duration(seconds: 1),
        tokenWalletRefreshInterval: Duration(seconds: 2),
        intensivePollingInterval: Duration(seconds: 3),
        sseBaseUrl: 'https://example.com/sse',
      );

      // Act
      final result = converter.toJson(config);

      // Assert
      expect(result, isNotNull);
      expect(result!['tonWalletRefreshInterval'], 1);
      expect(result['tokenWalletRefreshInterval'], 2);
      expect(result['intensivePollingInterval'], 3);
      expect(result.containsKey('sseBaseUrl'), isFalse);
    });
  });
}
