import 'package:app/app/service/ntp_service.dart';
import 'package:app/feature/ton_connect/ton_connect.dart';
import 'package:mocktail/mocktail.dart';
import 'package:nekoton_repository/nekoton_repository.dart';
import 'package:test/test.dart';

class _MockNekotonRepository extends Mock implements NekotonRepository {}

class _MockNtpService extends Mock implements NtpService {}

class _MockTonWalletState extends Mock implements TonWalletState {}

class _MockTonWallet extends Mock implements TonWallet {}

class _MockBridge extends Mock implements NekotonBridgeApi {}

void main() {
  final bridge = _MockBridge();

  setUpAll(() {
    registerFallbackValue(
      const Address(
        address: 'EQC2vKG4Xz7uZf8U5Fw6g4zUMIqFZ3VAb9/T/jGj33jjCu1F',
      ),
    );

    NekotonBridge.initMock(api: bridge);

    when(
      () =>
          bridge.crateApiMergedNtRepackAddress(address: any(named: 'address')),
    ).thenAnswer((invocation) => invocation.namedArguments[#address] as String);
    when(
      () => bridge.crateApiMergedNtValidateAddress(
        address: any(named: 'address'),
      ),
    ).thenAnswer((invocation) {
      final addr = invocation.namedArguments[#address] as String;
      return !addr.startsWith('0:');
    });
  });

  group('TonConnectRequestValidator', () {
    late _MockNekotonRepository repository;
    late _MockNtpService ntpService;
    late TonConnectRequestValidator validator;
    late DappManifest manifest;
    late Address walletAddress;
    late TonAppConnection connection;

    setUp(() {
      repository = _MockNekotonRepository();
      ntpService = _MockNtpService();
      validator = TonConnectRequestValidator(repository, ntpService);
      manifest = DappManifest(
        url: Uri.parse('https://dapp.test'),
        name: 'DApp',
        iconUrl: 'https://dapp.test/icon.png',
      );
      walletAddress = const Address(
        address: 'EQC2vKG4Xz7uZf8U5Fw6g4zUMIqFZ3VAb9/T/jGj33jjCu1F',
      );
      connection = TonAppConnection.remote(
        clientId: 'client',
        sessionCrypto: SessionCrypto(),
        replyItems: const [],
        walletAddress: walletAddress,
        manifest: manifest,
      );
    });

    group('validateSignDataRequest', () {
      test('returns error when wallet not found', () async {
        // Arrange
        final walletState = _MockTonWalletState();
        when(() => walletState.wallet).thenReturn(null);
        when(
          () => repository.getWalletByAddress(any()),
        ).thenAnswer((_) async => walletState);

        final payload = SignDataPayload.text(
          text: 'hello',
          from: walletAddress.toString(),
        );

        // Act
        final error = await validator.validateSignDataRequest(
          connection: connection,
          payload: payload,
        );

        // Assert
        expect(error, isNotNull);
        expect(error?.code, TonConnectErrorCode.badRequest);
        expect(error?.message, 'Wallet not found');
      });

      test('returns error when payload uses different wallet', () async {
        // Arrange
        final walletState = _MockTonWalletState();
        final wallet = _MockTonWallet();
        when(() => wallet.address).thenReturn(walletAddress);
        when(() => walletState.wallet).thenReturn(wallet);
        when(
          () => repository.getWalletByAddress(any()),
        ).thenAnswer((_) async => walletState);

        const payload = SignDataPayload.text(
          text: 'hello',
          from: 'EQBfXwVkYz4SH5HcNf0HbAwSNPvxyGvJ2RjLSV6NWlw8vYEX',
        );

        // Act
        final error = await validator.validateSignDataRequest(
          connection: connection,
          payload: payload,
        );

        // Assert
        expect(error, isNotNull);
        expect(error?.message, 'Invalid wallet address');
      });

      test('returns null for valid payload', () async {
        // Arrange
        final walletState = _MockTonWalletState();
        final wallet = _MockTonWallet();
        when(() => wallet.address).thenReturn(walletAddress);
        when(() => walletState.wallet).thenReturn(wallet);
        when(
          () => repository.getWalletByAddress(any()),
        ).thenAnswer((_) async => walletState);

        const payload = SignDataPayload.text(text: 'hello');

        // Act
        final error = await validator.validateSignDataRequest(
          connection: connection,
          payload: payload,
        );

        // Assert
        expect(error, isNull);
      });
    });

    group('validateSendTransactionRequest', () {
      test('fails when "from" differs from connection address', () async {
        // Arrange
        final payload = TransactionPayload(
          from: const Address(
            address: 'EQC9YWIOvHpdbk7OwF7g8fO9bk8WA3vpz1eUX4Ir05oKdR2J',
          ),
          messages: [
            TransactionPayloadMessage(address: walletAddress, amount: '1'),
          ],
        );

        // Act
        final error = await validator.validateSendTransactionRequest(
          connection: connection,
          payload: payload,
        );

        // Assert
        expect(error, isNotNull);
        expect(error?.message, 'Wrong "from" parameter');
      });

      test('fails when messages list is empty', () async {
        // Arrange
        final payload = TransactionPayload(messages: []);

        // Act
        final error = await validator.validateSendTransactionRequest(
          connection: connection,
          payload: payload,
        );

        // Assert
        expect(error, isNotNull);
        expect(error?.message, 'Messages cannot be empty');
      });

      test('fails when address format is invalid', () async {
        // Arrange
        final payload = TransactionPayload(
          messages: [
            TransactionPayloadMessage(
              address: Address(address: '0:${'0' * 64}'),
              amount: '1',
            ),
          ],
        );

        // Act
        final error = await validator.validateSendTransactionRequest(
          connection: connection,
          payload: payload,
        );

        // Assert
        expect(error, isNotNull);
        expect(error?.message, 'Invalid address format');
      });

      test('fails when wallet for transaction is not found', () async {
        // Arrange
        final walletState = _MockTonWalletState();
        when(() => walletState.wallet).thenReturn(null);
        when(
          () => repository.getWalletByAddress(any()),
        ).thenAnswer((_) async => walletState);

        final payload = TransactionPayload(
          messages: [
            TransactionPayloadMessage(address: walletAddress, amount: '1'),
          ],
        );

        // Act
        final error = await validator.validateSendTransactionRequest(
          connection: connection,
          payload: payload,
        );

        // Assert
        expect(error, isNotNull);
        expect(error?.message, 'Wallet not found');
      });
    });
  });
}
