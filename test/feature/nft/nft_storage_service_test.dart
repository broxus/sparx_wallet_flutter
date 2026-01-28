// ignore_for_file: avoid_redundant_argument_values, inference_failure_on_function_invocation, lines_longer_than_80_chars

import 'package:app/feature/nft/data/nft_collection_settings.dart';
import 'package:app/feature/nft/data/pending_nft.dart';
import 'package:app/feature/nft/domain/nft_storage_service.dart';
import 'package:get_storage/get_storage.dart';
import 'package:mocktail/mocktail.dart';
import 'package:nekoton_repository/nekoton_repository.dart';
import 'package:test/test.dart';

class _MockGetStorage extends Mock implements GetStorage {}

class _MockBridge extends Mock implements NekotonBridgeApi {}

const _pendingNftsKey = 'pending_nfts';

void main() {
  group('NftStorageService', () {
    late NftStorageService service;
    late _MockGetStorage collectionsStorage;
    late _MockGetStorage generalStorage;

    const networkGroup = 'mainnet';
    const owner = Address(address: '0:owner');
    const collection = Address(address: '0:collection');
    final bridge = _MockBridge();

    setUpAll(() {
      NekotonBridge.initMock(api: bridge);

      when(
        () => bridge.crateApiMergedNtValidateAddress(
          address: any(named: 'address'),
        ),
      ).thenReturn(false);
    });

    setUp(() {
      collectionsStorage = _MockGetStorage();
      generalStorage = _MockGetStorage();
      service = NftStorageService(collectionsStorage, generalStorage);

      when(
        () => collectionsStorage.write(any(), any()),
      ).thenAnswer((_) async {});
      when(() => generalStorage.write(any(), any())).thenAnswer((_) async {});
    });

    test('setCollections stores collections and updates stream', () async {
      // Arrange
      const settings = NftCollectionSettings(
        collection: collection,
        networkGroup: networkGroup,
      );

      final expectation = expectLater(
        service.collectionsStream,
        emits({
          owner: [settings],
        }),
      );

      // Act
      service.setCollections(accountAddress: owner, collections: [settings]);

      // Assert
      verify(
        () => collectionsStorage.write(owner.address, [settings.toJson()]),
      ).called(1);
      await expectation;
    });

    test(
      'addCollection replaces collection with same address and group',
      () async {
        // Arrange
        const initial = NftCollectionSettings(
          collection: collection,
          networkGroup: networkGroup,
          isVisible: true,
        );
        const updated = NftCollectionSettings(
          collection: collection,
          networkGroup: networkGroup,
          isVisible: false,
        );

        final expectation = expectLater(
          service.collectionsStream,
          emitsInOrder([
            {
              owner: [initial],
            },
            {
              owner: [updated],
            },
          ]),
        );

        // Act
        service
          ..setCollections(accountAddress: owner, collections: [initial])
          ..addCollection(accountAddress: owner, collection: updated);

        // Assert
        await expectation;
      },
    );

    test(
      'removeCollection deletes matching collection and writes storage',
      () async {
        // Arrange
        const otherCollection = Address(address: '0:other');
        const settings = [
          NftCollectionSettings(
            collection: collection,
            networkGroup: networkGroup,
          ),
          NftCollectionSettings(
            collection: otherCollection,
            networkGroup: networkGroup,
          ),
        ];

        final expectation = expectLater(
          service.collectionsStream,
          emitsInOrder([
            {owner: settings},
            {
              owner: [
                const NftCollectionSettings(
                  collection: otherCollection,
                  networkGroup: networkGroup,
                ),
              ],
            },
          ]),
        );

        // Act
        service
          ..setCollections(accountAddress: owner, collections: settings)
          ..removeCollection(
            accountAddress: owner,
            collectionAddress: collection,
            networkGroup: networkGroup,
          );

        // Assert
        await expectation;
        final captured =
            verify(
                  () => collectionsStorage.write(owner.address, captureAny()),
                ).captured.last
                as List<dynamic>;

        expect(captured, [
          const NftCollectionSettings(
            collection: otherCollection,
            networkGroup: networkGroup,
          ).toJson(),
        ]);
      },
    );

    test('readLatestLt returns parsed value and writeLatestLt stores it', () {
      // Arrange
      when(
        () =>
            generalStorage.read<String>('lt::$networkGroup::${owner.toRaw()}'),
      ).thenReturn('42');

      // Act
      final read = service.readLatestLt(
        address: owner,
        networkGroup: networkGroup,
      );
      service.writeLatestLt(
        address: owner,
        networkGroup: networkGroup,
        lt: BigInt.one,
      );

      // Assert
      expect(read, equals(BigInt.from(42)));
      verify(
        () => generalStorage.write('lt::$networkGroup::${owner.toRaw()}', '1'),
      ).called(1);
    });

    test('addPendingNft adds unique entry and updates storage', () async {
      // Arrange
      final pending = PendingNft(
        id: '1',
        collection: collection,
        networkGroup: networkGroup,
        owner: owner,
      );

      final expectation = expectLater(
        service.pendingNftStream,
        emits([pending]),
      );

      // Act
      service.addPendingNft(pending);

      // Assert
      await expectation;
      final captured =
          verify(
                () => generalStorage.write(_pendingNftsKey, captureAny()),
              ).captured.last
              as List<dynamic>;

      expect(captured, [pending.toJson()]);
    });

    test('removePendingNft removes matching entry and returns it', () async {
      // Arrange
      final pendingOne = PendingNft(
        id: '1',
        collection: collection,
        networkGroup: networkGroup,
        owner: owner,
      );
      final pendingTwo = PendingNft(
        id: '2',
        collection: collection,
        networkGroup: networkGroup,
        owner: owner,
      );

      service
        ..addPendingNft(pendingOne)
        ..addPendingNft(pendingTwo);

      clearInteractions(generalStorage);

      final expectation = expectLater(
        service.pendingNftStream,
        emitsInOrder([
          [pendingOne, pendingTwo],
          [pendingTwo],
        ]),
      );

      // Act
      final removed = service.removePendingNft(
        id: pendingOne.id,
        owner: owner,
        collection: collection,
        networkGroup: networkGroup,
      );

      // Assert
      await expectation;
      expect(removed, equals(pendingOne));
      final captured =
          verify(
                () => generalStorage.write(_pendingNftsKey, captureAny()),
              ).captured.last
              as List<dynamic>;

      expect(captured, [pendingTwo.toJson()]);
    });

    test('removePendingNft returns null when nothing matches', () {
      // Act
      final removed = service.removePendingNft(
        id: 'missing',
        owner: owner,
        collection: collection,
        networkGroup: networkGroup,
      );

      // Assert
      expect(removed, isNull);
      verifyNever(() => generalStorage.write(any(), any()));
    });

    test('removePendingNftByCollection removes all matching entries', () async {
      // Arrange
      const otherOwner = Address(address: '0:other');
      final matching = PendingNft(
        id: '1',
        collection: collection,
        networkGroup: networkGroup,
        owner: owner,
      );
      final keep = PendingNft(
        id: '2',
        collection: collection,
        networkGroup: networkGroup,
        owner: otherOwner,
      );

      service
        ..addPendingNft(matching)
        ..addPendingNft(keep);

      clearInteractions(generalStorage);

      final expectation = expectLater(
        service.pendingNftStream,
        emitsInOrder([
          [matching, keep],
          [keep],
        ]),
      );

      // Act
      final removed = service.removePendingNftByCollection(
        owner: owner,
        collection: collection,
        networkGroup: networkGroup,
      );

      // Assert
      await expectation;
      expect(removed, equals([matching]));
      final captured =
          verify(
                () => generalStorage.write(_pendingNftsKey, captureAny()),
              ).captured.last
              as List<dynamic>;

      expect(captured, [keep.toJson()]);
    });

    test('getCollections filters by network group', () {
      // Arrange
      const settings = [
        NftCollectionSettings(
          collection: collection,
          networkGroup: networkGroup,
        ),
        NftCollectionSettings(
          collection: Address(address: '0:another'),
          networkGroup: 'testnet',
        ),
      ];
      service.setCollections(accountAddress: owner, collections: settings);

      // Act
      final result = service.getCollections(owner, networkGroup);

      // Assert
      expect(result, hasLength(1));
      expect(result.first.collection, equals(collection));
    });

    test('getPendingNftAddresses returns owners entries for network group', () {
      // Arrange
      service
        ..addPendingNft(
          PendingNft(
            id: '1',
            collection: collection,
            networkGroup: networkGroup,
            owner: owner,
          ),
        )
        ..addPendingNft(
          PendingNft(
            id: '2',
            collection: const Address(address: '0:other'),
            networkGroup: 'testnet',
            owner: owner,
          ),
        );

      // Act
      final result = service.getPendingNftAddresses(owner, networkGroup);

      // Assert
      expect(result, equals({collection}));
    });
  });
}
