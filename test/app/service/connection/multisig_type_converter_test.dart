import 'package:app/app/service/connection/json_converters/multisig_type_converter.dart';
import 'package:app/extensions/enum_extension.dart';
import 'package:nekoton_repository/nekoton_repository.dart';
import 'package:test/test.dart';

void main() {
  group('EnumExtension.byNameNormalize', () {
    test('returns enum when name matches exactly', () {
      expect(
        MultisigType.values.byNameNormalize('safeMultisigWallet'),
        MultisigType.safeMultisigWallet,
      );
    });

    test('returns enum when first letter case differs (upper -> lower)', () {
      expect(
        MultisigType.values.byNameNormalize('SafeMultisigWallet'),
        MultisigType.safeMultisigWallet,
      );
    });

    test('returns enum when first letter case differs (lower -> upper)', () {
      expect(
        MultisigType.values.byNameNormalize('Multisig2'),
        MultisigType.multisig2,
      );
    });

    test('throws ArgumentError for unknown name', () {
      expect(
        () => MultisigType.values.byNameNormalize('UnknownType'),
        throwsA(isA<ArgumentError>()),
      );
    });

    test('throws RangeError for empty string (name[0])', () {
      expect(
        () => MultisigType.values.byNameNormalize(''),
        throwsA(isA<RangeError>()),
      );
    });
  });

  group('MultisigTypeConverter.fromJson', () {
    const converter = MultisigTypeConverter();

    test('returns defaults when json is null', () {
      final res = converter.fromJson(null);

      expect(res, equals(defaultMultisigNames));
      expect(res.length, defaultMultisigNames.length);
    });

    test('starts from defaults and overrides known keys (exact name)', () {
      final res = converter.fromJson({
        'safeMultisigWallet': 'My Safe',
        'multisig2_1': 'My Multisig',
      });

      expect(res[MultisigType.safeMultisigWallet], 'My Safe');
      expect(res[MultisigType.multisig2_1], 'My Multisig');

      expect(
        res[MultisigType.bridgeMultisigWallet],
        defaultMultisigNames[MultisigType.bridgeMultisigWallet],
      );
      expect(res.length, defaultMultisigNames.length);
    });

    test('overrides when key differs only by first letter case', () {
      final res = converter.fromJson({
        'SafeMultisigWallet': 'My Safe',
        'Multisig2': 'Legacy New Name',
      });

      expect(res[MultisigType.safeMultisigWallet], 'My Safe');
      expect(res[MultisigType.multisig2], 'Legacy New Name');
      expect(res.length, defaultMultisigNames.length);
    });

    test('ignores entries with non-String values', () {
      final res = converter.fromJson({
        'safeMultisigWallet': 123, // ignored
        'multisig2': true, // ignored
        'surfWallet': 'OK', // applied
      });

      expect(
        res[MultisigType.safeMultisigWallet],
        defaultMultisigNames[MultisigType.safeMultisigWallet],
      );
      expect(
        res[MultisigType.multisig2],
        defaultMultisigNames[MultisigType.multisig2],
      );
      expect(res[MultisigType.surfWallet], 'OK');
      expect(res.length, defaultMultisigNames.length);
    });

    test('ignores unknown keys and does not throw', () {
      expect(
        () => converter.fromJson({
          'UnknownType': 'X',
          'AnotherOne': 'Y',
          'safeMultisigWallet': 'OK',
        }),
        returnsNormally,
      );

      final res = converter.fromJson({
        'UnknownType': 'X',
        'safeMultisigWallet': 'OK',
      });

      expect(res[MultisigType.safeMultisigWallet], 'OK');
      expect(res.length, defaultMultisigNames.length);
    });

    test('does not mutate defaultMultisigNames map', () {
      final before = Map<MultisigType, String>.from(defaultMultisigNames);

      final res = converter.fromJson({'safeMultisigWallet': 'Changed'});

      expect(res[MultisigType.safeMultisigWallet], 'Changed');
      expect(defaultMultisigNames, equals(before));
    });
  });

  group('MultisigTypeConverter.toJson', () {
    const converter = MultisigTypeConverter();

    test('serializes using enum.name keys', () {
      final json = converter.toJson({
        MultisigType.safeMultisigWallet: 'A',
        MultisigType.multisig2_1: 'B',
      });

      expect(
        json,
        equals(<String, dynamic>{
          'safeMultisigWallet': 'A',
          'multisig2_1': 'B',
        }),
      );
    });

    test('round-trip: fromJson(toJson(x)) == x for a custom map', () {
      final original = <MultisigType, String>{
        MultisigType.safeMultisigWallet: 'A',
        MultisigType.safeMultisigWallet24h: 'B',
        MultisigType.setcodeMultisigWallet: 'C',
        MultisigType.setcodeMultisigWallet24h: 'D',
        MultisigType.bridgeMultisigWallet: 'E',
        MultisigType.surfWallet: 'F',
        MultisigType.multisig2: 'G',
        MultisigType.multisig2_1: 'H',
      };

      final json = converter.toJson(original);
      final back = converter.fromJson(json);

      expect(back, equals(original));
    });

    test('round-trip for defaults: fromJson(toJson(defaults)) == defaults', () {
      final json = converter.toJson(defaultMultisigNames);
      final back = converter.fromJson(json);

      expect(back, equals(defaultMultisigNames));
    });
  });
}
