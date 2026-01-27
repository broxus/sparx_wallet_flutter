import 'package:app/app/service/connection/data/network_type.dart';
import 'package:app/app/service/resources_service.dart';
import 'package:app/feature/wallet/staking/domain/staking_abi_provider.dart';
import 'package:app/generated/generated.dart';
import 'package:mocktail/mocktail.dart';
import 'package:test/test.dart';

class _MockResourcesService extends Mock implements ResourcesService {}

void main() {
  late _MockResourcesService resources;
  late StakingAbiProvider provider;

  setUp(() {
    resources = _MockResourcesService();
    provider = StakingAbiProvider(resources);
  });

  group('StakingAbiProvider', () {
    test('getVaultAbi uses ever path', () async {
      // Arrange
      when(() => resources.loadString(any())).thenAnswer(
        (invocation) async => invocation.positionalArguments.first as String,
      );

      // Act
      final abi = await provider.getVaultAbi(NetworkType.ever);

      // Assert
      expect(abi, Assets.abi.stEverVaultAbi);
      verify(() => resources.loadString(Assets.abi.stEverVaultAbi)).called(1);
    });

    test('getAccountAbi uses new path for non-ever', () async {
      // Arrange
      when(() => resources.loadString(any())).thenAnswer(
        (invocation) async => invocation.positionalArguments.first as String,
      );

      // Act
      final abi = await provider.getAccountAbi(NetworkType.tycho);

      // Assert
      expect(abi, Assets.abi.stEverAccountNewAbi);
      verify(
        () => resources.loadString(Assets.abi.stEverAccountNewAbi),
      ).called(1);
    });

    test('abi values are cached per path', () async {
      // Arrange
      var callCount = 0;
      when(() => resources.loadString(any())).thenAnswer((_) async {
        callCount++;
        return 'abi-value';
      });

      // Act
      final first = await provider.getVaultAbi(NetworkType.venom);
      final second = await provider.getVaultAbi(NetworkType.venom);

      // Assert
      expect(first, 'abi-value');
      expect(second, 'abi-value');
      expect(callCount, 1);
    });
  });
}
