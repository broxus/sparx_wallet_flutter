import 'dart:ui' show AppLifecycleState;

import 'package:app/app/service/app_lifecycle_service.dart';
import 'package:app/feature/ledger/ledger.dart';
import 'package:mocktail/mocktail.dart';
import 'package:nekoton_repository/nekoton_repository.dart';
import 'package:test/test.dart';

class _MockLedgerStorageService extends Mock implements LedgerStorageService {}

class _MockLedgerConnectionHandler extends Mock
    implements LedgerConnectionHandlerImpl {}

class _MockNekotonRepository extends Mock implements NekotonRepository {}

class _MockTonWallet extends Mock implements TonWallet {}

class _MockAppLifecycleService extends Mock implements AppLifecycleService {
  @override
  Stream<AppLifecycleState> get appLifecycleStateStream =>
      const Stream<AppLifecycleState>.empty();
}

void main() {
  group('LedgerService.prepareSignatureContext', () {
    late LedgerService service;

    setUp(() {
      service = LedgerService(
        _MockLedgerStorageService(),
        _MockLedgerConnectionHandler(),
        _MockNekotonRepository(),
        _MockAppLifecycleService(),
      );
    });

    test('adds workchainId when wallet uses non-zero workchain', () {
      // Arrange
      final wallet = _MockTonWallet();
      final address = Address(address: '1:${'a' * 64}');
      when(() => wallet.address).thenReturn(address);
      when(() => wallet.walletType).thenReturn(const WalletType.everWallet());

      final params = PrepareSignatureContext.deploy(
        wallet: wallet,
        asset: 'EVER',
        decimals: 9,
      );

      // Act
      final context = service.prepareSignatureContext(params);

      // Assert
      expect(context.workchainId, equals(1));
      expect(context.address, isNull);
    });

    test(
      'sets address for multisig confirm flows that require confirmation',
      () {
        // Arrange
        final wallet = _MockTonWallet();
        final address = Address(address: '0:${'b' * 64}');
        when(() => wallet.address).thenReturn(address);
        when(
          () => wallet.walletType,
        ).thenReturn(const WalletType.multisig(MultisigType.multisig2));

        final params = PrepareSignatureContext.confirm(
          wallet: wallet,
          asset: 'EVER',
          decimals: 9,
        );

        // Act
        final context = service.prepareSignatureContext(params);

        // Assert
        expect(context.address, equals(address.hash));
        expect(context.workchainId, isNull);
      },
    );

    test('adds address for transfer when custodians differ', () {
      // Arrange
      final wallet = _MockTonWallet();
      final address = Address(address: '0:${'c' * 64}');
      const custodian = PublicKey(publicKey: 'custodian');
      when(() => wallet.address).thenReturn(address);
      when(
        () => wallet.walletType,
      ).thenReturn(const WalletType.multisig(MultisigType.multisig2_1));
      when(() => wallet.custodians).thenReturn([
        const PublicKey(publicKey: 'owner'),
        const PublicKey(publicKey: 'other'),
      ]);
      when(
        () => wallet.publicKey,
      ).thenReturn(const PublicKey(publicKey: 'owner'));

      final params = PrepareSignatureContext.transfer(
        wallet: wallet,
        asset: 'EVER',
        decimals: 9,
        custodian: custodian,
      );

      // Act
      final context = service.prepareSignatureContext(params);

      // Assert
      expect(context.address, equals(address.hash));
      expect(context.workchainId, isNull);
    });

    test('skips address for transfer when confirmation is unnecessary', () {
      // Arrange
      final wallet = _MockTonWallet();
      final address = Address(address: '0:${'d' * 64}');
      const custodian = PublicKey(publicKey: 'owner');
      when(() => wallet.address).thenReturn(address);
      when(() => wallet.walletType).thenReturn(const WalletType.everWallet());
      when(() => wallet.custodians).thenReturn([custodian]);
      when(() => wallet.publicKey).thenReturn(custodian);

      final params = PrepareSignatureContext.transfer(
        wallet: wallet,
        asset: 'EVER',
        decimals: 9,
        custodian: custodian,
      );

      // Act
      final context = service.prepareSignatureContext(params);

      // Assert
      expect(context.address, isNull);
      expect(context.workchainId, isNull);
    });
  });
}
