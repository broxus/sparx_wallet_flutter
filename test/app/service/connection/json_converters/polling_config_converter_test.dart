import 'package:app/app/service/connection/json_converters/polling_config_converter.dart';
import 'package:nekoton_repository/nekoton_repository.dart';
import 'package:test/test.dart';

void main() {
  group('PollingConfigSecondsConverter fromJson', () {
    const converter = PollingConfigSecondsConverter();

    test('returns null when json is null', () {
      expect(converter.fromJson(null), isNull);
    });

    test('uses defaults when fields are missing', () {
      final cfg = converter.fromJson(<String, dynamic>{})!;
      expect(
        cfg.tonWalletRefreshInterval,
        PollingConfig.defaultConfig.tonWalletRefreshInterval,
      );
      expect(
        cfg.tokenWalletRefreshInterval,
        PollingConfig.defaultConfig.tokenWalletRefreshInterval,
      );
      expect(
        cfg.intensivePollingInterval,
        PollingConfig.defaultConfig.intensivePollingInterval,
      );
    });

    test('uses defaults when fields are present but not parseable', () {
      final cfg = converter.fromJson(<String, dynamic>{
        'tonWalletRefreshInterval': 'abc',
        'tokenWalletRefreshInterval': true,
        'intensivePollingInterval': {'x': 1},
      })!;

      expect(
        cfg.tonWalletRefreshInterval,
        PollingConfig.defaultConfig.tonWalletRefreshInterval,
      );
      expect(
        cfg.tokenWalletRefreshInterval,
        PollingConfig.defaultConfig.tokenWalletRefreshInterval,
      );
      expect(
        cfg.intensivePollingInterval,
        PollingConfig.defaultConfig.intensivePollingInterval,
      );
    });

    test('accepts ints for all fields', () {
      final cfg = converter.fromJson(<String, dynamic>{
        'tonWalletRefreshInterval': 11,
        'tokenWalletRefreshInterval': 22,
        'intensivePollingInterval': 3,
      })!;

      expect(cfg.tonWalletRefreshInterval, const Duration(seconds: 11));
      expect(cfg.tokenWalletRefreshInterval, const Duration(seconds: 22));
      expect(cfg.intensivePollingInterval, const Duration(seconds: 3));
    });

    test('accepts strings that parse to int', () {
      final cfg = converter.fromJson(<String, dynamic>{
        'tonWalletRefreshInterval': '15',
        'tokenWalletRefreshInterval': '20',
        'intensivePollingInterval': '1',
      })!;

      expect(cfg.tonWalletRefreshInterval, const Duration(seconds: 15));
      expect(cfg.tokenWalletRefreshInterval, const Duration(seconds: 20));
      expect(cfg.intensivePollingInterval, const Duration(seconds: 1));
    });

    test('accepts doubles and truncates via toInt', () {
      final cfg = converter.fromJson(<String, dynamic>{
        'tonWalletRefreshInterval': 10.9,
        'tokenWalletRefreshInterval': 7.1,
        'intensivePollingInterval': 2.0,
      })!;

      expect(cfg.tonWalletRefreshInterval, const Duration(seconds: 10));
      expect(cfg.tokenWalletRefreshInterval, const Duration(seconds: 7));
      expect(cfg.intensivePollingInterval, const Duration(seconds: 2));
    });

    test(
      'mix of valid/invalid fields: valid override, invalid keep defaults',
      () {
        final cfg = converter.fromJson(<String, dynamic>{
          'tonWalletRefreshInterval': '30', // ok
          'tokenWalletRefreshInterval': 'oops', // invalid => default
          'intensivePollingInterval': 9, // ok
        })!;

        expect(cfg.tonWalletRefreshInterval, const Duration(seconds: 30));
        expect(
          cfg.tokenWalletRefreshInterval,
          PollingConfig.defaultConfig.tokenWalletRefreshInterval,
        );
        expect(cfg.intensivePollingInterval, const Duration(seconds: 9));
      },
    );

    test('does not care about extra keys', () {
      final cfg = converter.fromJson(<String, dynamic>{
        'tonWalletRefreshInterval': 12,
        'extra': 999,
      })!;

      expect(cfg.tonWalletRefreshInterval, const Duration(seconds: 12));
      expect(
        cfg.tokenWalletRefreshInterval,
        PollingConfig.defaultConfig.tokenWalletRefreshInterval,
      );
      expect(
        cfg.intensivePollingInterval,
        PollingConfig.defaultConfig.intensivePollingInterval,
      );
    });

    test('allows negative values', () {
      final cfg = converter.fromJson(<String, dynamic>{
        'tonWalletRefreshInterval': -5,
        'tokenWalletRefreshInterval': '-10',
        'intensivePollingInterval': -1.2, // double -> toInt => -1
      })!;

      expect(cfg.tonWalletRefreshInterval, const Duration(seconds: -5));
      expect(cfg.tokenWalletRefreshInterval, const Duration(seconds: -10));
      expect(cfg.intensivePollingInterval, const Duration(seconds: -1));
    });
  });

  group('PollingConfigSecondsConverter toJson', () {
    const converter = PollingConfigSecondsConverter();

    test('returns null when PollingConfig is null', () {
      expect(converter.toJson(null), isNull);
    });

    test('serializes durations to seconds', () {
      final json = converter.toJson(
        const PollingConfig(
          tonWalletRefreshInterval: Duration(seconds: 1),
          tokenWalletRefreshInterval: Duration(seconds: 2),
          intensivePollingInterval: Duration(seconds: 3),
        ),
      )!;

      expect(
        json,
        equals(<String, dynamic>{
          'tonWalletRefreshInterval': 1,
          'tokenWalletRefreshInterval': 2,
          'intensivePollingInterval': 3,
        }),
      );
    });

    test('round-trip: fromJson(toJson(x)) preserves seconds', () {
      const original = PollingConfig(
        tonWalletRefreshInterval: Duration(seconds: 19),
        tokenWalletRefreshInterval: Duration(seconds: 20),
        intensivePollingInterval: Duration(seconds: 5),
      );

      final json = converter.toJson(original)!;
      final back = converter.fromJson(json)!;

      expect(back.tonWalletRefreshInterval, original.tonWalletRefreshInterval);
      expect(
        back.tokenWalletRefreshInterval,
        original.tokenWalletRefreshInterval,
      );
      expect(back.intensivePollingInterval, original.intensivePollingInterval);
    });

    test('round-trip for defaults', () {
      final json = converter.toJson(PollingConfig.defaultConfig)!;
      final back = converter.fromJson(json)!;

      expect(
        back.tonWalletRefreshInterval,
        PollingConfig.defaultConfig.tonWalletRefreshInterval,
      );
      expect(
        back.tokenWalletRefreshInterval,
        PollingConfig.defaultConfig.tokenWalletRefreshInterval,
      );
      expect(
        back.intensivePollingInterval,
        PollingConfig.defaultConfig.intensivePollingInterval,
      );
    });
  });
}
