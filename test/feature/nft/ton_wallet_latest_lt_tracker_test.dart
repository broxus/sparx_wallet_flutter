import 'package:app/feature/nft/domain/nft_storage_service.dart';
import 'package:app/feature/nft/domain/ton_wallet_latest_lt_tracker.dart';
import 'package:mocktail/mocktail.dart';
import 'package:nekoton_repository/nekoton_repository.dart';
import 'package:test/test.dart';

class _MockNftStorageService extends Mock implements NftStorageService {}

void main() {
  group('TonWalletLatestLtTracker', () {
    const networkGroup = 'mainnet';
    const address = Address(address: '0:owner');

    late _MockNftStorageService storageService;
    late TonWalletLatestLtTracker tracker;

    setUp(() {
      storageService = _MockNftStorageService();
      tracker = TonWalletLatestLtTracker(
        address: address,
        networkGroup: networkGroup,
        nftStorageService: storageService,
      );
    });

    test('latestLt delegates to storage service', () {
      // Arrange
      when(
        () => storageService.readLatestLt(
          address: address,
          networkGroup: networkGroup,
        ),
      ).thenReturn(BigInt.from(123));

      // Act
      final result = tracker.latestLt;

      // Assert
      expect(result, BigInt.from(123));
    });

    test('updateLatestLt persists value via storage service', () {
      // Arrange
      when(
        () => storageService.writeLatestLt(
          address: address,
          networkGroup: networkGroup,
          lt: BigInt.two,
        ),
      ).thenAnswer((_) {});

      // Act
      tracker.updateLatestLt(BigInt.two);

      // Assert
      verify(
        () => storageService.writeLatestLt(
          address: address,
          networkGroup: networkGroup,
          lt: BigInt.two,
        ),
      ).called(1);
    });
  });
}
