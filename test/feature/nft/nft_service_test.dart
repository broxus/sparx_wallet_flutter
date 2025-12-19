// ignore_for_file: avoid_redundant_argument_values

import 'package:app/app/service/connection/transport_strategies/common_transport_strategy.dart';
import 'package:app/app/service/current_accounts_service.dart';
import 'package:app/feature/nft/data/nft_collection_settings.dart';
import 'package:app/feature/nft/data/pending_nft.dart';
import 'package:app/feature/nft/domain/nft_service.dart';
import 'package:app/feature/nft/domain/nft_storage_service.dart';
import 'package:mocktail/mocktail.dart';
import 'package:nekoton_repository/nekoton_repository.dart';
import 'package:rxdart/rxdart.dart';
import 'package:test/test.dart';

class _MockNekotonRepository extends Mock implements NekotonRepository {}

class _MockNftStorageService extends Mock implements NftStorageService {}

class _MockCurrentAccountsService extends Mock
    implements CurrentAccountsService {}

class _MockNftCollection extends Mock implements NftCollection {}

class _MockTransportStrategy extends Mock implements CommonTransportStrategy {}

void main() {
  group('NftService', () {
    late _MockNekotonRepository repository;
    late _MockNftStorageService storage;
    late _MockCurrentAccountsService accountsService;
    late NftService service;

    const owner = Address(address: '0:owner');
    const networkGroup = 'mainnet';

    NftTransferEvent event({
      required String id,
      required Address collection,
      required TransferDirection direction,
      required Address sender,
      required Address recipient,
    }) {
      return NftTransferEvent.ownership(
        id: id,
        collection: collection,
        direction: direction,
        sender: sender,
        recipient: recipient,
      );
    }

    setUpAll(() {
      registerFallbackValue(const Address(address: '0:fallback'));
      registerFallbackValue(
        const NftCollectionSettings(
          collection: Address(address: '0:fallback'),
          networkGroup: 'fallback',
        ),
      );
      registerFallbackValue(
        PendingNft(
          id: 'fallback',
          collection: const Address(address: '0:fallback'),
          networkGroup: 'fallback',
          owner: const Address(address: '0:fallback'),
        ),
      );
      registerFallbackValue(<NftCollectionSettings>[]);
      registerFallbackValue(<Address>[]);
    });

    setUp(() {
      repository = _MockNekotonRepository();
      storage = _MockNftStorageService();
      accountsService = _MockCurrentAccountsService();
      service = NftService(repository, storage, accountsService);
    });

    test('getCollection caches repository result', () async {
      // Arrange
      const collectionAddress = Address(address: '0:collection');
      final collection = _MockNftCollection();
      when(
        () => repository.getNftCollection(collectionAddress),
      ).thenAnswer((_) async => collection);

      // Act
      final first = await service.getCollection(collectionAddress);
      final second = await service.getCollection(collectionAddress);

      // Assert
      expect(first, same(collection));
      expect(second, same(collection));
      verify(() => repository.getNftCollection(collectionAddress)).called(1);
    });

    test('getCollection returns null when repository throws', () async {
      // Arrange
      const collectionAddress = Address(address: '0:collection');
      when(
        () => repository.getNftCollection(collectionAddress),
      ).thenThrow(Exception('error'));

      // Act
      final result = await service.getCollection(collectionAddress);

      // Assert
      expect(result, isNull);
    });

    test('getNftItem returns null when repository throws', () async {
      // Arrange
      const nftAddress = Address(address: '0:nft');
      when(
        () => repository.getNftItem(address: nftAddress, owner: owner),
      ).thenThrow(Exception('error'));

      // Act
      final result = await service.getNftItem(
        address: nftAddress,
        owner: owner,
      );

      // Assert
      expect(result, isNull);
    });

    test(
      'getAccountCollectionsStream filters by group and visibility',
      () async {
        // Arrange
        final transportSubject = BehaviorSubject<TransportStrategy>();
        final collectionsSubject =
            BehaviorSubject<Map<Address, List<NftCollectionSettings>>>();

        when(
          () => repository.currentTransportStream,
        ).thenAnswer((_) => transportSubject.stream);
        when(
          () => storage.collectionsStream,
        ).thenAnswer((_) => collectionsSubject.stream);

        final transport = _MockTransportStrategy();
        when(() => transport.networkGroup).thenReturn(networkGroup);
        transportSubject.add(transport);

        final visibleAlpha = _MockNftCollection();
        when(() => visibleAlpha.name).thenReturn('Alpha');
        const alphaAddress = Address(address: '0:alpha');
        when(() => visibleAlpha.address).thenReturn(alphaAddress);
        when(
          () => repository.getNftCollection(alphaAddress),
        ).thenAnswer((_) async => visibleAlpha);
        await service.getCollection(alphaAddress);

        final visibleBravo = _MockNftCollection();
        when(() => visibleBravo.name).thenReturn('Bravo');
        const bravoAddress = Address(address: '0:bravo');
        when(() => visibleBravo.address).thenReturn(bravoAddress);
        when(
          () => repository.getNftCollection(bravoAddress),
        ).thenAnswer((_) async => visibleBravo);
        await service.getCollection(bravoAddress);

        collectionsSubject.add({
          owner: const [
            NftCollectionSettings(
              collection: bravoAddress,
              networkGroup: networkGroup,
              isVisible: true,
            ),
            NftCollectionSettings(
              collection: alphaAddress,
              networkGroup: networkGroup,
              isVisible: true,
            ),
            NftCollectionSettings(
              collection: Address(address: '0:hidden'),
              networkGroup: networkGroup,
              isVisible: false,
            ),
            NftCollectionSettings(
              collection: Address(address: '0:different'),
              networkGroup: 'testnet',
              isVisible: true,
            ),
          ],
        });

        // Act
        final result = await service.getAccountCollectionsStream(owner).first;

        // Assert
        expect(result.map((c) => c.name), ['Alpha', 'Bravo']);
      },
    );

    test('getAccountPendingNftsStream filters by owner and group', () async {
      // Arrange
      final transportSubject = BehaviorSubject<TransportStrategy>();
      final pendingSubject = BehaviorSubject<List<PendingNft>>();

      when(
        () => repository.currentTransportStream,
      ).thenAnswer((_) => transportSubject.stream);
      when(
        () => storage.pendingNftStream,
      ).thenAnswer((_) => pendingSubject.stream);

      final transport = _MockTransportStrategy();
      when(() => transport.networkGroup).thenReturn(networkGroup);
      transportSubject.add(transport);

      final matching = PendingNft(
        id: '1',
        collection: const Address(address: '0:col'),
        networkGroup: networkGroup,
        owner: owner,
      );
      final differentOwner = PendingNft(
        id: '2',
        collection: const Address(address: '0:col'),
        networkGroup: networkGroup,
        owner: const Address(address: '0:other'),
      );
      final differentGroup = PendingNft(
        id: '3',
        collection: const Address(address: '0:col'),
        networkGroup: 'testnet',
        owner: owner,
      );

      pendingSubject.add([matching, differentOwner, differentGroup]);

      // Act
      final result = await service.getAccountPendingNftsStream(owner).first;

      // Assert
      expect(result, [matching]);
    });

    test(
      'getNftTransferEventStream filters by owner and optional collection',
      () async {
        // Arrange
        final eventsSubject = BehaviorSubject<NftTransferEvent>();
        when(
          () => repository.nftTransferEventStream,
        ).thenAnswer((_) => eventsSubject.stream);

        final matching = event(
          id: 'match',
          collection: const Address(address: '0:match'),
          direction: TransferDirection.incoming,
          sender: owner,
          recipient: const Address(address: '0:someone'),
        );
        final otherCollection = event(
          id: 'other',
          collection: const Address(address: '0:other'),
          direction: TransferDirection.incoming,
          sender: owner,
          recipient: owner,
        );

        // Act
        final resultFuture = expectLater(
          service.getNftTransferEventStream(
            owner: owner,
            collection: const Address(address: '0:match'),
          ),
          emits(matching),
        );

        eventsSubject
          ..add(otherCollection)
          ..add(matching);

        // Assert
        await resultFuture;
      },
    );

    test('addCollection uses current transport network group', () {
      // Arrange
      final transport = _MockTransportStrategy();
      when(() => repository.currentTransport).thenReturn(transport);
      when(() => transport.networkGroup).thenReturn(networkGroup);

      when(
        () => storage.addCollection(
          accountAddress: owner,
          collection: any<NftCollectionSettings>(named: 'collection'),
        ),
      ).thenAnswer((_) {});

      // Act
      service.addCollection(
        accountAddress: owner,
        collectionAddress: const Address(address: '0:new'),
      );

      // Assert
      final verification = verify(
        () => storage.addCollection(
          accountAddress: owner,
          collection: captureAny(named: 'collection'),
        ),
      )..called(1);

      final settings = verification.captured.first as NftCollectionSettings;
      expect(settings.networkGroup, networkGroup);
      expect(settings.isVisible, isTrue);
    });

    test('hideCollection sets visibility to false', () {
      // Arrange
      final transport = _MockTransportStrategy();
      when(() => repository.currentTransport).thenReturn(transport);
      when(() => transport.networkGroup).thenReturn(networkGroup);

      when(
        () => storage.addCollection(
          accountAddress: owner,
          collection: any<NftCollectionSettings>(named: 'collection'),
        ),
      ).thenAnswer((_) {});

      // Act
      service.hideCollection(
        accountAddress: owner,
        collectionAddress: const Address(address: '0:hidden'),
      );

      // Assert
      final verification = verify(
        () => storage.addCollection(
          accountAddress: owner,
          collection: captureAny(named: 'collection'),
        ),
      )..called(1);

      final settings = verification.captured.first as NftCollectionSettings;
      expect(settings.networkGroup, networkGroup);
      expect(settings.isVisible, isFalse);
    });

    test(
      'scanNftCollections merges addresses and respects visibility',
      () async {
        // Arrange
        final transport = _MockTransportStrategy();
        when(() => transport.networkGroup).thenReturn(networkGroup);
        when(() => transport.nftInformation).thenReturn(null);
        when(() => repository.currentTransport).thenReturn(transport);

        const cachedHidden = NftCollectionSettings(
          collection: Address(address: '0:hidden'),
          networkGroup: networkGroup,
          isVisible: false,
        );
        const cachedVisible = NftCollectionSettings(
          collection: Address(address: '0:cached'),
          networkGroup: networkGroup,
          isVisible: true,
        );

        when(
          () => storage.getCollections(owner, networkGroup),
        ).thenReturn([cachedHidden, cachedVisible]);
        when(
          () => storage.getPendingNftAddresses(owner, networkGroup),
        ).thenReturn({const Address(address: '0:pending')});

        final scannedCollection = _MockNftCollection();
        const scannedAddress = Address(address: '0:cached');
        when(() => scannedCollection.address).thenReturn(scannedAddress);
        when(() => scannedCollection.name).thenReturn('Scanned');

        final scannedHiddenCollection = _MockNftCollection();
        const scannedHiddenAddress = Address(address: '0:hidden');
        when(
          () => scannedHiddenCollection.address,
        ).thenReturn(scannedHiddenAddress);
        when(() => scannedHiddenCollection.name).thenReturn('Hidden');

        when(
          () => repository.scanNftCollections(
            owner: owner,
            collections: any<List<Address>>(named: 'collections'),
          ),
        ).thenAnswer((_) async => [scannedCollection, scannedHiddenCollection]);

        when(
          () => storage.setCollections(
            accountAddress: owner,
            collections: any<List<NftCollectionSettings>>(named: 'collections'),
          ),
        ).thenAnswer((_) {});

        // Act
        await service.scanNftCollections(owner);

        // Assert
        final scanVerification = verify(
          () => repository.scanNftCollections(
            owner: owner,
            collections: captureAny(named: 'collections'),
          ),
        )..called(1);
        final collectionsArg =
            scanVerification.captured.single as List<Address>;
        expect(
          collectionsArg,
          containsAll(<Address>{
            cachedHidden.collection,
            cachedVisible.collection,
            const Address(address: '0:pending'),
          }),
        );

        final setCollectionsVerification = verify(
          () => storage.setCollections(
            accountAddress: owner,
            collections: captureAny(named: 'collections'),
          ),
        )..called(1);
        final settingsArg =
            setCollectionsVerification.captured.single
                as List<NftCollectionSettings>;
        expect(
          settingsArg.any(
            (e) => e.collection == cachedHidden.collection && !e.isVisible,
          ),
          isTrue,
        );
        expect(
          settingsArg.any(
            (e) => e.collection == cachedVisible.collection && e.isVisible,
          ),
          isTrue,
        );

        final cached = await service.getCollection(scannedAddress);
        expect(cached, same(scannedCollection));
      },
    );

    test('init handles incoming and outgoing transfer events', () async {
      // Arrange
      final accountSubject = BehaviorSubject<KeyAccount?>.seeded(null);
      when(
        () => accountsService.currentActiveAccountStream,
      ).thenAnswer((_) => accountSubject.stream);

      final eventsSubject = BehaviorSubject<NftTransferEvent>();
      when(
        () => repository.nftTransferEventStream,
      ).thenAnswer((_) => eventsSubject.stream);

      final transport = _MockTransportStrategy();
      when(() => repository.currentTransport).thenReturn(transport);
      when(() => transport.networkGroup).thenReturn(networkGroup);

      when(() => storage.addPendingNft(any<PendingNft>())).thenAnswer((_) {});
      when(
        () => storage.removePendingNft(
          id: any<String>(named: 'id'),
          owner: any<Address>(named: 'owner'),
          collection: any<Address>(named: 'collection'),
          networkGroup: any(named: 'networkGroup'),
        ),
      ).thenAnswer((_) => null);

      service.init();

      final incoming = event(
        id: '1',
        collection: const Address(address: '0:col'),
        direction: TransferDirection.incoming,
        sender: const Address(address: '0:from'),
        recipient: owner,
      );

      final outgoing = event(
        id: '2',
        collection: const Address(address: '0:col'),
        direction: TransferDirection.outgoing,
        sender: owner,
        recipient: const Address(address: '0:to'),
      );

      // Act
      eventsSubject
        ..add(incoming)
        ..add(outgoing);

      // Allow async listeners to process events
      await Future<void>.delayed(const Duration(milliseconds: 1));

      // Assert
      verify(
        () => storage.addPendingNft(
          PendingNft(
            id: '1',
            collection: const Address(address: '0:col'),
            owner: owner,
            networkGroup: networkGroup,
          ),
        ),
      ).called(1);
      verify(
        () => storage.removePendingNft(
          id: '2',
          owner: owner,
          collection: const Address(address: '0:col'),
          networkGroup: networkGroup,
        ),
      ).called(1);

      service.dispose();
    });
  });
}
