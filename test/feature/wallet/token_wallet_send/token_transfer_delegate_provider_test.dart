import 'package:app/data/models/gasless_config.dart';
import 'package:app/feature/wallet/token_wallet_send/token_wallet_send.dart';
import 'package:app/http/repository/gasless_repository.dart';
import 'package:mocktail/mocktail.dart';
import 'package:nekoton_repository/nekoton_repository.dart';
import 'package:test/test.dart';

class _MockNekotonRepository extends Mock implements NekotonRepository {}

class _MockGaslessRepository extends Mock implements GaslessRepository {}

class _MockSeedList extends Mock implements SeedList {}

class _MockSeed extends Mock implements Seed {}

class _MockSeedKey extends Mock implements SeedKey {}

void main() {
  setUpAll(() {
    registerFallbackValue(const Address(address: '0:dead'));
    registerFallbackValue(PublicKey(publicKey: List.filled(64, 'a').join()));
  });

  late _MockNekotonRepository repository;
  late _MockGaslessRepository gaslessRepository;
  late GaslessTokenTransferDelegate gaslessDelegate;
  late BasicTokenTransferDelegate basicDelegate;
  late _MockSeedList seedList;
  late _MockSeed seed;
  late _MockSeedKey seedKey;
  late TokenTransferDelegateProvider provider;

  final publicKey = PublicKey(publicKey: List.filled(64, 'b').join());
  const accountAddress = Address(address: '0:owner');
  final keyAccount = KeyAccount(
    account: AssetsList(
      name: 'account',
      tonWallet: TonWalletAsset(
        address: accountAddress,
        publicKey: publicKey,
        contract: const WalletType.walletV5R1(),
      ),
      additionalAssets: <String, AdditionalAssets>{},
    ),
    isExternal: false,
    isHidden: false,
    publicKey: publicKey,
  );
  const rootTokenContract = Address(address: '0:root');

  setUp(() {
    repository = _MockNekotonRepository();
    gaslessRepository = _MockGaslessRepository();
    gaslessDelegate = GaslessTokenTransferDelegate(
      repository,
      gaslessRepository,
    );
    basicDelegate = BasicTokenTransferDelegate(repository);
    seedList = _MockSeedList();
    seed = _MockSeed();
    seedKey = _MockSeedKey();

    provider = TokenTransferDelegateProvider(
      repository,
      gaslessRepository,
      gaslessDelegate,
      basicDelegate,
    );

    when(() => repository.seedList).thenReturn(seedList);
    when(() => seedList.findSeedByAnyPublicKey(publicKey)).thenReturn(seed);
    when(() => seed.masterKey).thenReturn(seedKey);
    when(() => seedKey.isLedger).thenReturn(false);
  });

  group('TokenTransferDelegateProvider', () {
    test('isGaslessAvailable returns true when gasless jetton found', () async {
      // Arrange
      when(() => gaslessRepository.getConfig()).thenAnswer(
        (_) async => const GaslessConfig(
          relayAddress: Address(address: '0:relay'),
          gasJettons: [GasJetton(masterId: rootTokenContract)],
        ),
      );

      // Act
      final available = await provider.isGaslessAvailable(
        keyAccount: keyAccount,
        rootTokenContract: rootTokenContract,
      );

      // Assert
      expect(available, isTrue);
      verify(() => gaslessRepository.getConfig()).called(1);
    });

    test('isGaslessAvailable returns false for ledger seed', () async {
      // Arrange
      when(() => seedKey.isLedger).thenReturn(true);

      // Act
      final available = await provider.isGaslessAvailable(
        keyAccount: keyAccount,
        rootTokenContract: rootTokenContract,
      );

      // Assert
      expect(available, isFalse);
      verifyNever(() => gaslessRepository.getConfig());
    });

    test('provide returns gasless delegate when available', () async {
      // Arrange
      when(() => gaslessRepository.getConfig()).thenAnswer(
        (_) async => const GaslessConfig(
          relayAddress: Address(address: '0:relay'),
          gasJettons: [GasJetton(masterId: rootTokenContract)],
        ),
      );

      // Act
      final delegate = await provider.provide(
        keyAccount: keyAccount,
        rootTokenContract: rootTokenContract,
      );

      // Assert
      expect(delegate, same(gaslessDelegate));
    });

    test('provide returns basic delegate when gasless unavailable', () async {
      // Arrange
      when(() => gaslessRepository.getConfig()).thenAnswer((_) async => null);

      // Act
      final delegate = await provider.provide(
        keyAccount: keyAccount,
        rootTokenContract: rootTokenContract,
      );

      // Assert
      expect(delegate, same(basicDelegate));
    });
  });
}
