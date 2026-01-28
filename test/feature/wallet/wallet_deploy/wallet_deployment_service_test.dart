import 'package:app/feature/wallet/wallet_deploy/domain/wallet_deployment_service.dart';
import 'package:mocktail/mocktail.dart';
import 'package:nekoton_repository/nekoton_repository.dart';
import 'package:test/test.dart';

class _MockNekotonRepository extends Mock implements NekotonRepository {}

void main() {
  late _MockNekotonRepository repository;
  late WalletDeploymentService service;

  const testAddress = Address(address: '0:test_address');
  final testAmount = BigInt.from(1000000000);
  const testHash = 'test_message_hash_12345';
  const differentHash = 'different_hash_67890';

  SignedMessage createSignedMessage({String hash = testHash}) {
    return SignedMessage(
      hash: hash,
      expireAt: DateTime.fromMillisecondsSinceEpoch(0),
      boc: 'test_boc',
    );
  }

  Transaction createTransaction() {
    return Transaction(
      id: const TransactionId(lt: '1', hash: 'tx_hash'),
      createdAt: DateTime.fromMillisecondsSinceEpoch(0),
      aborted: false,
      origStatus: AccountStatus.active,
      endStatus: AccountStatus.active,
      totalFees: BigInt.zero,
      inMessage: Message(
        hash: 'in_msg_hash',
        value: BigInt.zero,
        bounce: false,
        bounced: false,
      ),
      outMessages: const [],
      boc: 'tx_boc',
    );
  }

  setUpAll(() {
    registerFallbackValue(const Address(address: '0:fallback'));
    registerFallbackValue(
      SignedMessage(
        hash: 'fallback_hash',
        expireAt: DateTime.fromMillisecondsSinceEpoch(0),
        boc: 'fallback_boc',
      ),
    );
    registerFallbackValue(BigInt.zero);
  });

  setUp(() {
    repository = _MockNekotonRepository();
    service = WalletDeploymentService(repository);
  });

  group('WalletDeploymentService', () {
    test('stores a signed message successfully', () async {
      // Arrange
      final message = createSignedMessage();

      when(
        () => repository.send(
          address: testAddress,
          signedMessage: message,
          amount: testAmount,
          destination: testAddress,
        ),
      ).thenAnswer((_) async => createTransaction());

      // Act
      service.storeSignedMessage(message);

      // Assert - verify by successful deploy (should not throw)
      final result = await service.deploy(
        messageHash: testHash,
        address: testAddress,
        amount: testAmount,
      );
      expect(result, isA<Transaction>());
    });

    test('overwrites previously stored message', () async {
      // Arrange
      final firstMessage = createSignedMessage(hash: 'first_hash');
      final secondMessage = createSignedMessage(hash: 'second_hash');

      when(
        () => repository.send(
          address: testAddress,
          signedMessage: secondMessage,
          amount: testAmount,
          destination: testAddress,
        ),
      ).thenAnswer((_) async => createTransaction());

      // Act
      service
        ..storeSignedMessage(firstMessage)
        ..storeSignedMessage(secondMessage);

      // Assert - second message should be the active one
      await service.deploy(
        messageHash: 'second_hash',
        address: testAddress,
        amount: testAmount,
      );

      verify(
        () => repository.send(
          address: testAddress,
          signedMessage: secondMessage,
          amount: testAmount,
          destination: testAddress,
        ),
      ).called(1);
    });

    test('clears the stored message', () {
      // Arrange
      final message = createSignedMessage();
      service.storeSignedMessage(message);

      // Act
      // ignore: cascade_invocations
      service.clearStoredMessage();

      // Assert - deploy should throw because no message is stored
      expect(
        () => service.deploy(
          messageHash: testHash,
          address: testAddress,
          amount: testAmount,
        ),
        throwsA(
          isA<StateError>().having(
            (e) => e.message,
            'message',
            'No signed message stored',
          ),
        ),
      );
    });

    test('can be called when no message is stored', () {
      // Arrange - no message stored

      // Act & Assert - should not throw
      expect(() => service.clearStoredMessage(), returnsNormally);
    });

    test('successfully deploys with matching hash', () async {
      // Arrange
      final message = createSignedMessage();
      final expectedTransaction = createTransaction();

      service.storeSignedMessage(message);

      when(
        () => repository.send(
          address: testAddress,
          signedMessage: message,
          amount: testAmount,
          destination: testAddress,
        ),
      ).thenAnswer((_) async => expectedTransaction);

      // Act
      final result = await service.deploy(
        messageHash: testHash,
        address: testAddress,
        amount: testAmount,
      );

      // Assert
      expect(result, equals(expectedTransaction));
      verify(
        () => repository.send(
          address: testAddress,
          signedMessage: message,
          amount: testAmount,
          destination: testAddress,
        ),
      ).called(1);
    });

    test('clears stored message after successful deploy', () async {
      // Arrange
      final message = createSignedMessage();
      service.storeSignedMessage(message);

      when(
        () => repository.send(
          address: testAddress,
          signedMessage: message,
          amount: testAmount,
          destination: testAddress,
        ),
      ).thenAnswer((_) async => createTransaction());

      // Act
      await service.deploy(
        messageHash: testHash,
        address: testAddress,
        amount: testAmount,
      );

      // Assert - second deploy should fail
      expect(
        () => service.deploy(
          messageHash: testHash,
          address: testAddress,
          amount: testAmount,
        ),
        throwsA(
          isA<StateError>().having(
            (e) => e.message,
            'message',
            'No signed message stored',
          ),
        ),
      );
    });

    test('passes correct parameters to repository.send', () async {
      // Arrange
      final message = createSignedMessage();
      const specificAddress = Address(address: '0:specific_address');
      final specificAmount = BigInt.from(5000000000);

      service.storeSignedMessage(message);

      when(
        () => repository.send(
          address: specificAddress,
          signedMessage: message,
          amount: specificAmount,
          destination: specificAddress,
        ),
      ).thenAnswer((_) async => createTransaction());

      // Act
      await service.deploy(
        messageHash: testHash,
        address: specificAddress,
        amount: specificAmount,
      );

      // Assert
      verify(
        () => repository.send(
          address: specificAddress,
          signedMessage: message,
          amount: specificAmount,
          destination: specificAddress,
        ),
      ).called(1);
    });

    test('throws StateError when no message is stored', () {
      // Arrange - no message stored

      // Act & Assert
      expect(
        () => service.deploy(
          messageHash: testHash,
          address: testAddress,
          amount: testAmount,
        ),
        throwsA(
          isA<StateError>().having(
            (e) => e.message,
            'message',
            'No signed message stored',
          ),
        ),
      );
    });

    test('throws StateError when message hash does not match', () {
      // Arrange
      final message = createSignedMessage();
      service.storeSignedMessage(message);

      // Act & Assert
      expect(
        () => service.deploy(
          messageHash: differentHash,
          address: testAddress,
          amount: testAmount,
        ),
        throwsA(
          isA<StateError>().having(
            (e) => e.message,
            'message',
            'Stored message hash does not match the provided hash',
          ),
        ),
      );
    });
  });
}
