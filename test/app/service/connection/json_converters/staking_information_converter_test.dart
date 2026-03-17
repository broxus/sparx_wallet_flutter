import 'package:app/app/service/connection/json_converters/staking_information_converter.dart';
import 'package:nekoton_repository/nekoton_repository.dart';
import 'package:test/test.dart';

void main() {
  group('StakingInformationConverter fromJson', () {
    const converter = StakingInformationConverter();

    test('returns null when json is null', () {
      expect(converter.fromJson(null), isNull);
    });

    test('StakingInformation when json is valid', () {
      final json = <String, dynamic>{
        'stakingAPYLink': 'https://example.com/apy',
        'stakingRootContractAddress': '0:root',
        'stakingVaultAddress': '0:vault',
        'stakeDepositAttachedFee': '1000',
        'stakeRemovePendingWithdrawAttachedFee': '2000',
        'stakeWithdrawAttachedFee': '3000',
      };

      final info = converter.fromJson(json);
      expect(info, isNotNull);

      expect(info!.stakingAPYLink, Uri.parse('https://example.com/apy'));
      expect(info.stakingRootContractAddress.toString(), '0:root');
      expect(info.stakingValutAddress.toString(), '0:vault');
      expect(info.stakeDepositAttachedFee, BigInt.from(1000));
      expect(info.stakeRemovePendingWithdrawAttachedFee, BigInt.from(2000));
      expect(info.stakeWithdrawAttachedFee, BigInt.from(3000));
    });

    test('throws when stakingAPYLink is not a String', () {
      final json = <String, dynamic>{
        'stakingAPYLink': 123,
        'stakingRootContractAddress': '0:root',
        'stakingVaultAddress': '0:vault',
        'stakeDepositAttachedFee': '1000',
        'stakeRemovePendingWithdrawAttachedFee': '2000',
        'stakeWithdrawAttachedFee': '3000',
      };

      expect(() => converter.fromJson(json), throwsA(isA<TypeError>()));
    });

    test('returns null when any fee is missing', () {
      final json = <String, dynamic>{
        'stakingAPYLink': 'https://example.com/apy',
        'stakingRootContractAddress': '0:root',
        'stakingVaultAddress': '0:vault',
        // missing stakeDepositAttachedFee
        'stakeRemovePendingWithdrawAttachedFee': '2000',
        'stakeWithdrawAttachedFee': '3000',
      };

      // parseBigIntOrNull(null) => null => converter returns null
      expect(converter.fromJson(json), isNull);
    });

    test('returns null when any fee is not parseable', () {
      final json = <String, dynamic>{
        'stakingAPYLink': 'https://example.com/apy',
        'stakingRootContractAddress': '0:root',
        'stakingVaultAddress': '0:vault',
        'stakeDepositAttachedFee': 'nope',
        'stakeRemovePendingWithdrawAttachedFee': '2000',
        'stakeWithdrawAttachedFee': '3000',
      };

      expect(converter.fromJson(json), isNull);
    });

    test('accepts fee values as int/num as well', () {
      final json = <String, dynamic>{
        'stakingAPYLink': 'https://example.com/apy',
        'stakingRootContractAddress': '0:root',
        'stakingVaultAddress': '0:vault',
        'stakeDepositAttachedFee': 1000, // int -> BigInt.from
        'stakeRemovePendingWithdrawAttachedFee': 2000.9, // num -> toInt -> 2000
        'stakeWithdrawAttachedFee': BigInt.from(3000), // BigInt -> as-is
      };

      final info = converter.fromJson(json);
      expect(info, isNotNull);

      expect(info!.stakeDepositAttachedFee, BigInt.from(1000));
      expect(info.stakeRemovePendingWithdrawAttachedFee, BigInt.from(2000));
      expect(info.stakeWithdrawAttachedFee, BigInt.from(3000));
    });

    test('ignores extra keys', () {
      final json = <String, dynamic>{
        'stakingAPYLink': 'https://example.com/apy',
        'stakingRootContractAddress': '0:root',
        'stakingVaultAddress': '0:vault',
        'stakeDepositAttachedFee': '1000',
        'stakeRemovePendingWithdrawAttachedFee': '2000',
        'stakeWithdrawAttachedFee': '3000',
        'extra': 'whatever',
        'another': 123,
      };

      expect(converter.fromJson(json), isNotNull);
    });

    test('throws TypeError when stakingAPYLink is not a String', () {
      final json = <String, dynamic>{
        'stakingAPYLink': 123, // <-- not String
        'stakingRootContractAddress': '0:root',
        'stakingVaultAddress': '0:vault',
        'stakeDepositAttachedFee': '1000',
        'stakeRemovePendingWithdrawAttachedFee': '2000',
        'stakeWithdrawAttachedFee': '3000',
      };

      expect(() => converter.fromJson(json), throwsA(isA<TypeError>()));
    });

    test('throws TypeError when address fields are not String '
        '(because of "as String")', () {
      final json = <String, dynamic>{
        'stakingAPYLink': 'https://example.com/apy',
        'stakingRootContractAddress': 123, // <-- not String
        'stakingVaultAddress': '0:vault',
        'stakeDepositAttachedFee': '1000',
        'stakeRemovePendingWithdrawAttachedFee': '2000',
        'stakeWithdrawAttachedFee': '3000',
      };

      expect(() => converter.fromJson(json), throwsA(isA<TypeError>()));
    });
  });

  group('StakingInformationConverter toJson', () {
    const converter = StakingInformationConverter();

    test('returns null when info is null', () {
      expect(converter.toJson(null), isNull);
    });

    test('serializes all fields to String values', () {
      final info = StakingInformation(
        stakingAPYLink: Uri.parse('https://example.com/apy'),
        stakingRootContractAddress: const Address(address: '0:root'),
        stakingValutAddress: const Address(address: '0:vault'),
        stakeDepositAttachedFee: BigInt.from(1000),
        stakeRemovePendingWithdrawAttachedFee: BigInt.from(2000),
        stakeWithdrawAttachedFee: BigInt.from(3000),
      );

      final json = converter.toJson(info)!;

      expect(
        json,
        equals(<String, dynamic>{
          'stakingAPYLink': 'https://example.com/apy',
          'stakingRootContractAddress': '0:root',
          'stakingVaultAddress': '0:vault',
          'stakeDepositAttachedFee': '1000',
          'stakeRemovePendingWithdrawAttachedFee': '2000',
          'stakeWithdrawAttachedFee': '3000',
        }),
      );
    });

    test('round-trip. FromJson(toJson(x)) matches key fields', () {
      final info = StakingInformation(
        stakingAPYLink: Uri.parse('https://example.com/apy'),
        stakingRootContractAddress: const Address(address: '0:root'),
        stakingValutAddress: const Address(address: '0:vault'),
        stakeDepositAttachedFee: BigInt.parse('12345678901234567890'),
        stakeRemovePendingWithdrawAttachedFee: BigInt.from(2),
        stakeWithdrawAttachedFee: BigInt.from(3),
      );

      final json = converter.toJson(info)!;
      final back = converter.fromJson(json);

      expect(back, isNotNull);
      expect(back!.stakingAPYLink, info.stakingAPYLink);
      expect(
        back.stakingRootContractAddress.toString(),
        info.stakingRootContractAddress.toString(),
      );
      expect(
        back.stakingValutAddress.toString(),
        info.stakingValutAddress.toString(),
      );
      expect(back.stakeDepositAttachedFee, info.stakeDepositAttachedFee);
      expect(
        back.stakeRemovePendingWithdrawAttachedFee,
        info.stakeRemovePendingWithdrawAttachedFee,
      );
      expect(back.stakeWithdrawAttachedFee, info.stakeWithdrawAttachedFee);
    });
  });
}
