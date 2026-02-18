import 'dart:typed_data';

import 'package:app/feature/ledger/ledger.dart';
import 'package:flutter_blue_plus/flutter_blue_plus.dart';
import 'package:mocktail/mocktail.dart';
import 'package:nekoton_repository/nekoton_repository.dart';
import 'package:test/test.dart';

class _MockLedgerAppInterface extends Mock implements LedgerAppInterface {}

class _MockBluetoothDevice extends Mock implements BluetoothDevice {}

class _FakeDeviceIdentifier extends Fake implements DeviceIdentifier {
  _FakeDeviceIdentifier(this.str);

  @override
  final String str;

  @override
  String toString() => str;
}

void main() {
  setUpAll(() {
    registerFallbackValue(_FakeDeviceIdentifier('fallback'));
    registerFallbackValue(Uint8List(0));
  });

  group('LedgerConnectionHandlerImpl', () {
    late LedgerConnectionHandlerImpl handler;

    setUp(() {
      handler = LedgerConnectionHandlerImpl();
    });

    test(
      'setAppInterface disposes previous interface when device differs',
      () async {
        // Arrange
        final firstInterface = _MockLedgerAppInterface();
        final secondInterface = _MockLedgerAppInterface();
        final firstDevice = _MockBluetoothDevice();
        final secondDevice = _MockBluetoothDevice();

        when(() => firstInterface.device).thenReturn(firstDevice);
        when(() => secondInterface.device).thenReturn(secondDevice);
        when(
          () => firstDevice.remoteId,
        ).thenReturn(_FakeDeviceIdentifier('first'));
        when(
          () => secondDevice.remoteId,
        ).thenReturn(_FakeDeviceIdentifier('second'));
        when(firstInterface.dispose).thenAnswer((_) async {});

        await handler.setAppInterface(firstInterface);

        // Act
        await handler.setAppInterface(secondInterface);

        // Assert
        verify(firstInterface.dispose).called(1);
        expect(handler.appInterface, same(secondInterface));
      },
    );

    test('setAppInterface keeps interface when device is the same', () async {
      // Arrange
      final firstInterface = _MockLedgerAppInterface();
      final secondInterface = _MockLedgerAppInterface();
      final device = _MockBluetoothDevice();

      when(() => firstInterface.device).thenReturn(device);
      when(() => secondInterface.device).thenReturn(device);
      when(() => device.remoteId).thenReturn(_FakeDeviceIdentifier('same'));
      when(firstInterface.dispose).thenAnswer((_) async {});

      await handler.setAppInterface(firstInterface);

      // Act
      await handler.setAppInterface(secondInterface);

      // Assert
      verifyNever(firstInterface.dispose);
      expect(handler.appInterface, same(secondInterface));
    });

    test('getPublicKey throws when interface is not set', () async {
      // Arrange & Act
      final call = handler.getPublicKey;

      // Assert
      expect(() => call(1), throwsA(isA<LedgerException>()));
    });

    test('getPublicKey delegates to current interface', () async {
      // Arrange
      final interface = _MockLedgerAppInterface();
      when(() => interface.device).thenReturn(_MockBluetoothDevice());
      when(
        () => interface.getPublicKey(42),
      ).thenAnswer((_) async => Uint8List.fromList([1, 2, 3]));
      await handler.setAppInterface(interface);

      // Act
      final result = await handler.getPublicKey(42);

      // Assert
      expect(result, equals([1, 2, 3]));
      verify(() => interface.getPublicKey(42)).called(1);
    });

    test('sign delegates to current interface', () async {
      // Arrange
      final interface = _MockLedgerAppInterface();
      const signatureContext = SignatureContext(
        globalId: 7,
        signatureType: SignatureType.signatureId,
      );
      when(() => interface.device).thenReturn(_MockBluetoothDevice());
      when(
        () => interface.sign(accountId: 1, message: [9, 9], signatureId: 7),
      ).thenAnswer((_) async => Uint8List.fromList([7]));
      await handler.setAppInterface(interface);

      // Act
      final result = await handler.sign(
        accountId: 1,
        message: const [9, 9],
        signatureContext: signatureContext,
      );

      // Assert
      expect(result, equals([7]));
      verify(
        () => interface.sign(accountId: 1, message: [9, 9], signatureId: 7),
      ).called(1);
    });

    test('signTransaction delegates to current interface', () async {
      // Arrange
      final interface = _MockLedgerAppInterface();
      const context = LedgerSignatureContext(decimals: 9, asset: 'EVER');
      const signatureContext = SignatureContext(
        globalId: 10,
        signatureType: SignatureType.signatureId,
      );
      when(() => interface.device).thenReturn(_MockBluetoothDevice());
      when(
        () => interface.signTransaction(
          accountId: 5,
          wallet: 3,
          message: [1, 2, 3],
          context: context,
          signatureId: 10,
        ),
      ).thenAnswer((_) async => Uint8List.fromList([0xAA]));
      await handler.setAppInterface(interface);

      // Act
      final result = await handler.signTransaction(
        accountId: 5,
        wallet: 3,
        message: const [1, 2, 3],
        context: context,
        signatureContext: signatureContext,
      );

      // Assert
      expect(result, equals([0xAA]));
      verify(
        () => interface.signTransaction(
          accountId: 5,
          wallet: 3,
          message: [1, 2, 3],
          context: context,
          signatureId: 10,
        ),
      ).called(1);
    });
  });
}
