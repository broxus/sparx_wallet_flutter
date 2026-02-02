import 'package:app/app/service/connection/json_converters/wallet_type_converter.dart';
import 'package:nekoton_repository/nekoton_repository.dart';
import 'package:test/test.dart';

void main() {
  group('WalletTypeConverter fromJson. Multisig', () {
    const converter = WalletTypeConverter();

    test('reads multisig type from "value"', () {
      final json = <String, dynamic>{
        'type': 'multisig',
        'value': 'multisig2_1',
      };

      final res = converter.fromJson(json);

      expect(res, const WalletType.multisig(MultisigType.multisig2_1));
    });

    test('reads multisig type from data when value is absent', () {
      final json = <String, dynamic>{
        'type': 'multisig',
        'data': 'safeMultisigWallet',
      };

      final res = converter.fromJson(json);

      expect(res, const WalletType.multisig(MultisigType.safeMultisigWallet));
    });

    test('normalizes first-letter case via byNameNormalize', () {
      final json = <String, dynamic>{
        'type': 'multisig',
        'value': 'SafeMultisigWallet',
      };

      final res = converter.fromJson(json);

      expect(res, const WalletType.multisig(MultisigType.safeMultisigWallet));
    });

    test(
      'throws when multisig value/data is missing. Casts null as String',
      () {
        final json = <String, dynamic>{
          'type': 'multisig',
          // no value, no data
        };

        expect(() => converter.fromJson(json), throwsA(isA<TypeError>()));
      },
    );

    test('throws when multisig value is not String', () {
      final json = <String, dynamic>{'type': 'multisig', 'value': 123};

      expect(() => converter.fromJson(json), throwsA(isA<TypeError>()));
    });

    test('throws ArgumentError when multisig value is unknown', () {
      final json = <String, dynamic>{
        'type': 'multisig',
        'value': 'unknownMultisig',
      };

      expect(() => converter.fromJson(json), throwsA(isA<ArgumentError>()));
    });
  });

  group('WalletTypeConverter fromJson. No multisig', () {
    const converter = WalletTypeConverter();

    test('delegates to WalletType.fromJson for non-multisig', () {
      const original = WalletType.walletV3();
      final json = original.toJson();

      final parsed = converter.fromJson(json);

      expect(parsed, original);
    });
  });

  group('WalletTypeConverter toJson', () {
    const converter = WalletTypeConverter();

    test('returns object.toJson result', () {
      const obj = WalletType.multisig(MultisigType.multisig2);
      final json = converter.toJson(obj);

      expect(json, equals(obj.toJson()));
    });

    test('multisig toJson contains unionKey type', () {
      const obj = WalletType.multisig(MultisigType.multisig2_1);
      final json = converter.toJson(obj);

      expect(json['type'], isNotNull);
      expect(json['type'], anyOf('multisig', 'WalletTypeMultisig'));
    });
  });

  group('WalletTypeListConverter', () {
    const listConverter = WalletTypeListConverter();

    test('fromJson maps each element using WalletTypeConverter', () {
      final json = <dynamic>[
        <String, dynamic>{'type': 'multisig', 'value': 'multisig2'},
        const WalletType.walletV3().toJson(),
        const WalletType.walletV4R2().toJson(),
      ];

      final res = listConverter.fromJson(json);

      expect(res.length, 3);
      expect(res[0], const WalletType.multisig(MultisigType.multisig2));
      expect(res[1], const WalletType.walletV3());
      expect(res[2], const WalletType.walletV4R2());
    });

    test('toJson returns list of element.toJson', () {
      final list = <WalletType>[
        const WalletType.multisig(MultisigType.safeMultisigWallet),
        const WalletType.walletV3R2(),
      ];

      final json = listConverter.toJson(list);

      expect(json, equals(list.map((e) => e.toJson()).toList()));
    });

    test(
      'throws when list contains non-map element. Cast in list converter',
      () {
        final json = <dynamic>[
          <String, dynamic>{'type': 'multisig', 'value': 'multisig2'},
          123, // not a Map
        ];

        expect(() => listConverter.fromJson(json), throwsA(isA<TypeError>()));
      },
    );

    test('throws when one of list elements is invalid multisig payload', () {
      final json = <dynamic>[
        <String, dynamic>{'type': 'multisig', 'value': 'unknownMultisig'},
      ];

      expect(() => listConverter.fromJson(json), throwsA(isA<ArgumentError>()));
    });
  });

  group('Round-trip', () {
    const converter = WalletTypeConverter();

    test('multisig: fromJson(toJson(x)) == x', () {
      const original = WalletType.multisig(
        MultisigType.setcodeMultisigWallet24h,
      );
      final json = converter.toJson(original);
      final back = converter.fromJson(json);

      expect(back, original);
    });

    test('non-multisig fromJson(toJson(x)) == x', () {
      const original = WalletType.walletV5R1();
      final json = converter.toJson(original);
      final back = converter.fromJson(json);

      expect(back, original);
    });
  });
}
