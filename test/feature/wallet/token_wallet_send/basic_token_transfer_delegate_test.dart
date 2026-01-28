import 'package:app/app/service/connection/data/network_type.dart';
import 'package:app/app/service/connection/transport_strategies/common_transport_strategy.dart';
import 'package:app/data/models/fee.dart';
import 'package:app/feature/wallet/token_wallet_send/token_wallet_send.dart';
import 'package:app/utils/constants.dart';
import 'package:mocktail/mocktail.dart';
import 'package:money2/money2.dart';
import 'package:nekoton_repository/nekoton_repository.dart';
import 'package:test/test.dart';

class _MockNekotonRepository extends Mock implements NekotonRepository {}

class _MockTransportStrategy extends Mock implements CommonTransportStrategy {}

class _MockTransport extends Mock implements Transport {}

class _MockSigner extends Mock implements TokenTransferSigner {}

class _MockUnsignedMessage extends Mock implements UnsignedMessage {}

class _MockBridge extends Mock implements NekotonBridgeApi {}

void main() {
  final bridge = _MockBridge();
  late _MockNekotonRepository repository;
  late _MockTransportStrategy transport;
  late _MockTransport transportClient;
  late BasicTokenTransferDelegate delegate;
  late _MockSigner signer;
  late _MockUnsignedMessage unsignedMessage;

  const owner = Address(address: '0:owner');
  const rootTokenContract = Address(address: '0:root');
  const destination = Address(address: '0:destination');
  final publicKey = PublicKey(publicKey: List.filled(64, 'b').join());
  final ever = Currency.create(
    'EVER',
    9,
    pattern: '0.000000000',
    symbol: 'EVER',
  );
  setUpAll(() {
    registerFallbackValue(const Address(address: '0:dead'));
    registerFallbackValue(PublicKey(publicKey: List.filled(64, 'a').join()));
    registerFallbackValue(const Expiration.timeout(1));
    registerFallbackValue(
      TonWalletTransferParams(
        destination: const Address(address: '0:dest'),
        amount: BigInt.zero,
        bounce: false,
      ),
    );
    registerFallbackValue(BigInt.zero);

    NekotonBridge.initMock(api: bridge);
    when(
      () =>
          bridge.crateApiMergedNtRepackAddress(address: any(named: 'address')),
    ).thenAnswer((invocation) => invocation.namedArguments[#address] as String);
    when(
      () => bridge.crateApiMergedNtEncodeComment(
        comment: any(named: 'comment'),
        plain: any(named: 'plain'),
      ),
    ).thenAnswer(
      (invocation) =>
          invocation.namedArguments[#comment] as String? ?? 'encoded-comment',
    );

    Currencies().register(ever);
  });

  setUp(() {
    repository = _MockNekotonRepository();
    transport = _MockTransportStrategy();
    transportClient = _MockTransport();
    signer = _MockSigner();
    unsignedMessage = _MockUnsignedMessage();
    delegate = BasicTokenTransferDelegate(repository);

    when(() => repository.currentTransport).thenReturn(transport);
    when(() => transport.nativeTokenTicker).thenReturn('EVER');
    when(() => transport.networkType).thenReturn(NetworkType.ton);
    when(() => transport.transport).thenReturn(transportClient);
  });

  group('BasicTokenTransferDelegate', () {
    test(
      'prepareTransfer builds basic transfer with encoded comment',
      () async {
        // Arrange
        final internalMessage = InternalMessage(
          destination: destination,
          amount: BigInt.from(5),
          bounce: true,
          body: 'body',
        );

        when(
          () => repository.prepareTokenTransfer(
            owner: any(named: 'owner'),
            rootTokenContract: any(named: 'rootTokenContract'),
            destination: any(named: 'destination'),
            amount: any(named: 'amount'),
            payload: any(named: 'payload'),
            attachedAmount: any(named: 'attachedAmount'),
            notifyReceiver: any(named: 'notifyReceiver'),
          ),
        ).thenAnswer((invocation) async {
          final payload = invocation.namedArguments[#payload] as String?;
          expect(payload, isNotNull);
          expect(payload!.isNotEmpty, isTrue);
          final notifyReceiver =
              invocation.namedArguments[#notifyReceiver] as bool?;
          expect(notifyReceiver, isFalse);
          return internalMessage;
        });

        when(
          () => repository.prepareTransfer(
            address: owner,
            publicKey: publicKey,
            expiration: defaultSendTimeout,
            params: any(named: 'params'),
          ),
        ).thenAnswer((_) async => unsignedMessage);

        // Act
        final result = await delegate.prepareTransfer(
          owner: owner,
          rootTokenContract: rootTokenContract,
          publicKey: publicKey,
          destination: destination,
          amount: BigInt.from(10),
          attachedAmount: BigInt.from(1),
          comment: 'memo',
        );

        // Assert
        expect(result, isA<PreparedTokenTransferBasic>());
        final basic = result as PreparedTokenTransferBasic;
        expect(basic.unsignedMessage, unsignedMessage);
        expect(basic.destination, internalMessage.destination);
        expect(basic.attachedAmount, internalMessage.amount);
        expect(basic.owner, owner);
        expect(basic.rootTokenContract, rootTokenContract);

        verify(
          () => repository.prepareTransfer(
            address: owner,
            publicKey: publicKey,
            expiration: defaultSendTimeout,
            params: [
              TonWalletTransferParams(
                destination: internalMessage.destination,
                amount: internalMessage.amount,
                body: internalMessage.body,
                bounce: defaultMessageBounce,
              ),
            ],
          ),
        ).called(1);
      },
    );

    test('sendMessage signs and forwards basic transfer', () async {
      // Arrange
      final transfer =
          PreparedTokenTransfer.basic(
                unsignedMessage: unsignedMessage,
                destination: destination,
                attachedAmount: BigInt.from(7),
                owner: owner,
                rootTokenContract: rootTokenContract,
              )
              as PreparedTokenTransferBasic;
      final signedMessage = SignedMessage(
        hash: 'hash',
        expireAt: DateTime.fromMillisecondsSinceEpoch(0),
        boc: 'boc',
      );

      when(
        () => signer.signMessage(unsignedMessage),
      ).thenAnswer((_) async => signedMessage);
      when(
        () => repository.send(
          address: owner,
          signedMessage: signedMessage,
          amount: transfer.attachedAmount,
          destination: destination,
        ),
      ).thenAnswer(
        (_) async => Transaction(
          id: const TransactionId(lt: '1', hash: 'h'),
          createdAt: DateTime.fromMillisecondsSinceEpoch(0),
          aborted: false,
          origStatus: AccountStatus.active,
          endStatus: AccountStatus.active,
          totalFees: BigInt.zero,
          inMessage: Message(
            hash: 'in',
            value: BigInt.zero,
            bounce: false,
            bounced: false,
          ),
          outMessages: const [],
          boc: 'boc',
        ),
      );

      // Act
      final completer = await delegate.sendMessage(
        transfer: transfer,
        signer: signer,
      );

      // Assert
      await completer.future;
      verify(() => signer.signMessage(unsignedMessage)).called(1);
      verify(
        () => repository.send(
          address: owner,
          signedMessage: signedMessage,
          amount: transfer.attachedAmount,
          destination: destination,
        ),
      ).called(1);
    });

    test('sendMessage throws on non-basic transfer', () async {
      // Arrange
      final transfer = PreparedTokenTransfer.gasless(
        amount: BigInt.one,
        hash: 'aa',
        payload: 'payload',
        destination: destination,
        owner: owner,
        rootTokenContract: rootTokenContract,
        fee: Fee.native(Money.fromIntWithCurrency(0, ever)),
        publicKey: publicKey,
      );

      // Act & Assert
      expect(
        () => delegate.sendMessage(transfer: transfer, signer: signer),
        throwsStateError,
      );
    });

    test('estimateFees returns native fee for basic transfer', () async {
      // Arrange
      final transfer = PreparedTokenTransfer.basic(
        unsignedMessage: unsignedMessage,
        destination: destination,
        attachedAmount: BigInt.from(5),
        owner: owner,
        rootTokenContract: rootTokenContract,
      );

      when(
        () => repository.estimateFees(address: owner, message: unsignedMessage),
      ).thenAnswer((_) async => BigInt.from(1234));

      // Act
      final fee = await delegate.estimateFees(transfer);

      // Assert
      expect(fee.minorUnits, BigInt.from(1234));
      expect(fee.map(native: (_) => true, token: (_) => false), isTrue);
    });

    test('estimateFees throws on non-basic transfer', () async {
      // Arrange
      final transfer = PreparedTokenTransfer.gasless(
        amount: BigInt.one,
        hash: 'aa',
        payload: 'payload',
        destination: destination,
        owner: owner,
        rootTokenContract: rootTokenContract,
        fee: Fee.native(Money.fromIntWithCurrency(0, ever)),
        publicKey: publicKey,
      );

      // Act & Assert
      expect(() => delegate.estimateFees(transfer), throwsStateError);
    });

    test('simulateTransactionTree delegates for basic transfer', () async {
      // Arrange
      final transfer = PreparedTokenTransfer.basic(
        unsignedMessage: unsignedMessage,
        destination: destination,
        attachedAmount: BigInt.from(5),
        owner: owner,
        rootTokenContract: rootTokenContract,
      );
      const errorItem = TxTreeSimulationErrorItem(
        address: destination,
        error: TxTreeSimulationError(
          type: TxTreeSimulationErrorType.computePhase,
        ),
      );

      when(
        () => repository.simulateTransactionTree(
          address: owner,
          message: unsignedMessage,
        ),
      ).thenAnswer((_) async => [errorItem]);

      // Act
      final result = await delegate.simulateTransactionTree(transfer);

      // Assert
      expect(result, [errorItem]);
    });
  });
}
