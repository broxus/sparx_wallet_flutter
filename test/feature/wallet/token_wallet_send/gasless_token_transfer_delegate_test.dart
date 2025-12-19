import 'dart:convert';

import 'package:app/app/service/connection/transport_strategies/common_transport_strategy.dart';
import 'package:app/app/service/service.dart';
import 'package:app/data/models/fee.dart';
import 'package:app/data/models/gasless_config.dart';
import 'package:app/feature/wallet/token_wallet_send/token_wallet_send.dart';
import 'package:app/http/dto/gasless/gasless_estimate_response_dto.dart';
import 'package:app/http/dto/gasless/gasless_send_response_dto.dart';
import 'package:app/http/repository/gasless_repository.dart';
import 'package:convert/convert.dart';
import 'package:mocktail/mocktail.dart';
import 'package:money2/money2.dart';
import 'package:nekoton_repository/nekoton_repository.dart';
import 'package:test/test.dart';

class _MockNekotonRepository extends Mock implements NekotonRepository {}

class _MockGaslessRepository extends Mock implements GaslessRepository {}

class _MockTransportStrategy extends Mock implements CommonTransportStrategy {}

class _MockTransport extends Mock implements Transport {}

class _MockSigner extends Mock implements TokenTransferSigner {}

class _MockUnsignedMessage extends Mock implements UnsignedMessage {}

class _MockTonWallet extends Mock implements TonWallet {}

class _MockJettonWallet extends Mock implements JettonWallet {}

class _MockBridge extends Mock implements NekotonBridgeApi {}

void main() {
  final bridge = _MockBridge();
  late Currency everCurrency;

  setUpAll(() {
    NekotonBridge.initMock(api: bridge);

    registerFallbackValue(const Address(address: '0:dead'));
    registerFallbackValue(PublicKey(publicKey: List.filled(64, 'a').join()));
    registerFallbackValue(const Expiration.timeout(60));
    registerFallbackValue(
      TonWalletTransferParams(
        destination: const Address(address: '0:dest'),
        amount: BigInt.zero,
        bounce: false,
      ),
    );
    registerFallbackValue(BigInt.zero);
    registerFallbackValue(
      const RawContractState.exists(
        ExistingContract(
          account: 'fallback',
          timings: GenTimings(genLt: '0', genUtime: 0),
          lastTransactionId: LastTransactionId(isExact: true, lt: '0'),
        ),
      ),
    );

    everCurrency = Currency.create(
      'EVER',
      9,
      pattern: '0.000000000',
      symbol: 'EVER',
    );
    Currencies().register(everCurrency);

    when(
      () =>
          bridge.crateApiMergedNtRepackAddress(address: any(named: 'address')),
    ).thenAnswer((invocation) => invocation.namedArguments[#address] as String);
  });

  late _MockNekotonRepository repository;
  late _MockGaslessRepository gaslessRepository;
  late _MockTransportStrategy transportStrategy;
  late _MockTransport transportClient;
  late _MockJettonWallet jettonWallet;
  late JettonTokenWallet tokenWallet;
  late _MockTonWallet tonWallet;
  late _MockSigner signer;
  late _MockUnsignedMessage unsignedMessage;
  late GaslessTokenTransferDelegate delegate;

  const owner = Address(address: '0:owner');
  const rootTokenContract = Address(address: '0:root');
  const destination = Address(address: '0:destination');
  final publicKey = PublicKey(publicKey: List.filled(64, 'b').join());

  setUp(() {
    repository = _MockNekotonRepository();
    gaslessRepository = _MockGaslessRepository();
    transportStrategy = _MockTransportStrategy();
    transportClient = _MockTransport();
    jettonWallet = _MockJettonWallet();
    tonWallet = _MockTonWallet();
    signer = _MockSigner();
    unsignedMessage = _MockUnsignedMessage();
    when(() => jettonWallet.owner).thenReturn(owner);
    when(() => jettonWallet.rootTokenContract).thenReturn(rootTokenContract);
    when(() => tonWallet.address).thenReturn(owner);

    when(() => repository.currentTransport).thenReturn(transportStrategy);
    when(() => transportStrategy.transport).thenReturn(transportClient);

    when(() => jettonWallet.transport).thenReturn(transportClient);
    tokenWallet = JettonTokenWallet(
      jettonWallet,
      const Symbol(
        name: 'JTN',
        fullName: 'Jetton',
        decimals: 9,
        rootTokenContract: rootTokenContract,
      ),
    );

    delegate = GaslessTokenTransferDelegate(repository, gaslessRepository);
  });

  group('GaslessTokenTransferDelegate', () {
    test('prepareTransfer throws when gasless config is missing', () async {
      when(() => gaslessRepository.getConfig()).thenAnswer((_) async => null);

      expect(
        () => delegate.prepareTransfer(
          owner: owner,
          rootTokenContract: rootTokenContract,
          publicKey: publicKey,
          destination: destination,
          amount: BigInt.one,
        ),
        throwsStateError,
      );
    });

    test('prepareTransfer builds gasless transfer with fee', () async {
      const config = GaslessConfig(
        relayAddress: Address(address: '0:relay'),
        gasJettons: [GasJetton(masterId: rootTokenContract)],
      );
      final internalMessage = InternalMessage(
        destination: destination,
        amount: BigInt.from(2),
        bounce: true,
        body: 'body',
      );

      when(() => gaslessRepository.getConfig()).thenAnswer((_) async => config);
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
      ).thenAnswer((_) async => internalMessage);
      when(
        () => bridge.crateApiMergedNtEncodeInternalMessage(
          src: any(named: 'src'),
          dst: any(named: 'dst'),
          bounce: any(named: 'bounce'),
          stateInit: any(named: 'stateInit'),
          body: any(named: 'body'),
          amount: any(named: 'amount'),
          bounced: any(named: 'bounced'),
        ),
      ).thenAnswer((_) async => 'encoded-boc');
      when(
        () => gaslessRepository.estimate(
          masterId: any(named: 'masterId'),
          walletAddress: any(named: 'walletAddress'),
          walletPublicKey: any(named: 'walletPublicKey'),
          messages: any(named: 'messages'),
        ),
      ).thenAnswer(
        (_) async => GaslessEstimateResponseDto(
          protocolName: 'proto',
          relayAddress: destination,
          from: owner,
          messages: [
            SignRawMessageDto(
              address: destination,
              amount: BigInt.from(3),
              payload: 'payload',
              stateInit: 'state-init',
            ),
          ],
          commission: BigInt.from(123),
          validUntil: 0,
        ),
      );

      when(
        () => repository.getWallet(owner),
      ).thenAnswer((_) async => TonWalletState.wallet(tonWallet));
      when(() => tonWallet.address).thenReturn(owner);
      when(() => tonWallet.transport).thenReturn(transportClient);
      when(() => transportClient.getContractState(owner)).thenAnswer(
        (_) async => const RawContractState.exists(
          ExistingContract(
            account: 'state',
            timings: GenTimings(genLt: '0', genUtime: 0),
            lastTransactionId: LastTransactionId(isExact: true, lt: '0'),
          ),
        ),
      );
      when(
        () => tonWallet.prepareWalletV5R1MessageBody(
          contractState: any(named: 'contractState'),
          publicKey: any(named: 'publicKey'),
          expiration: any(named: 'expiration'),
          params: any(named: 'params'),
          isInternalFlow: any(named: 'isInternalFlow'),
        ),
      ).thenAnswer((_) async => ('hash-value', 'payload-value'));

      when(
        () => repository.getTokenWallet(owner, rootTokenContract),
      ).thenAnswer((_) async => TokenWalletState.wallet(tokenWallet));

      final transfer = await delegate.prepareTransfer(
        owner: owner,
        rootTokenContract: rootTokenContract,
        publicKey: publicKey,
        destination: destination,
        amount: BigInt.from(2),
        attachedAmount: BigInt.from(1),
      );

      expect(transfer, isA<PreparedTokenTransferGasless>());
      final gasless = transfer as PreparedTokenTransferGasless;
      expect(gasless.hash, 'hash-value');
      expect(gasless.payload, 'payload-value');
      expect(gasless.destination, internalMessage.destination);
      expect(gasless.fee, isA<FeeToken>());
      expect(gasless.fee.amount.minorUnits, BigInt.from(123));
      expect((gasless.fee as FeeToken).tokenRootAddress, rootTokenContract);
    });

    test('sendMessage signs payload and dispatches gasless request', () async {
      const hash = '0a0b';
      final transfer =
          PreparedTokenTransfer.gasless(
                amount: BigInt.from(5),
                hash: hash,
                payload: 'payload',
                destination: destination,
                owner: owner,
                rootTokenContract: rootTokenContract,
                fee: Fee.native(Money.fromIntWithCurrency(0, everCurrency)),
                publicKey: publicKey,
              )
              as PreparedTokenTransferGasless;

      when(
        () =>
            bridge
            // ignore: lines_longer_than_80_chars
            .crateApiMergedTonWalletDartWrapperAppendSignatureToWalletV5R1Payload(
              payload: any(named: 'payload'),
              base64Signature: any(named: 'base64Signature'),
            ),
      ).thenAnswer((_) async => 'payload-with-signature');
      when(
        () => bridge.crateApiMergedNtCreateRawExternalMessage(
          dst: any(named: 'dst'),
          stateInit: any(named: 'stateInit'),
          body: any(named: 'body'),
          timeout: any(named: 'timeout'),
        ),
      ).thenAnswer(
        (_) async => jsonEncode({
          'hash': 'message-hash',
          'expire_at': 0,
          'expireAt': 0,
          'boc': 'external-boc',
        }),
      );

      when(() => signer.signDataRaw(any())).thenAnswer((invocation) async {
        final encoded = invocation.positionalArguments.first as String;
        expect(encoded, base64Encode(hex.decode(hash)));
        return 'signature';
      });

      when(
        () => repository.getWallet(owner),
      ).thenAnswer((_) async => TonWalletState.wallet(tonWallet));
      when(() => tonWallet.transport).thenReturn(transportClient);
      when(() => transportClient.getContractState(owner)).thenAnswer(
        (_) async => const RawContractState.exists(
          ExistingContract(
            account: 'state',
            timings: GenTimings(genLt: '0', genUtime: 0),
            lastTransactionId: LastTransactionId(isExact: true, lt: '0'),
          ),
        ),
      );
      when(
        () => tonWallet.getWalletV5R1Seqno(
          contractState: any(named: 'contractState'),
          publicKey: any(named: 'publicKey'),
        ),
      ).thenAnswer((_) async => 0);
      when(
        () => tonWallet.makeStateInit(),
      ).thenAnswer((_) async => 'state-init');

      when(
        () => gaslessRepository.send(
          walletPublicKey: transfer.publicKey,
          boc: any(named: 'boc'),
        ),
      ).thenAnswer(
        (_) async => const GaslessSendResponseDto(
          protocolName: 'proto',
          messageHash: 'message-hash',
        ),
      );

      final completer = await delegate.sendMessage(
        transfer: transfer,
        signer: signer,
      );

      await completer.future;
      verify(() => signer.signDataRaw(any())).called(1);
      verify(
        () => gaslessRepository.send(
          walletPublicKey: transfer.publicKey,
          boc: 'external-boc',
        ),
      ).called(1);
    });

    test('sendMessage throws on non-gasless transfer', () async {
      final transfer = PreparedTokenTransfer.basic(
        unsignedMessage: unsignedMessage,
        destination: destination,
        attachedAmount: BigInt.one,
        owner: owner,
        rootTokenContract: rootTokenContract,
      );

      expect(
        () => delegate.sendMessage(transfer: transfer, signer: signer),
        throwsStateError,
      );
    });

    test('estimateFees returns fee from transfer', () async {
      final transfer =
          PreparedTokenTransfer.gasless(
                amount: BigInt.one,
                hash: 'hash',
                payload: 'payload',
                destination: destination,
                owner: owner,
                rootTokenContract: rootTokenContract,
                fee: Fee.native(Money.fromIntWithCurrency(0, everCurrency)),
                publicKey: publicKey,
              )
              as PreparedTokenTransferGasless;

      final fee = await delegate.estimateFees(transfer);

      expect(fee, same(transfer.fee));
    });

    test('simulateTransactionTree returns empty list', () async {
      final transfer =
          PreparedTokenTransfer.gasless(
                amount: BigInt.one,
                hash: 'hash',
                payload: 'payload',
                destination: destination,
                owner: owner,
                rootTokenContract: rootTokenContract,
                fee: Fee.native(Money.fromIntWithCurrency(0, everCurrency)),
                publicKey: publicKey,
              )
              as PreparedTokenTransferGasless;

      final result = await delegate.simulateTransactionTree(transfer);

      expect(result, isEmpty);
    });
  });
}
