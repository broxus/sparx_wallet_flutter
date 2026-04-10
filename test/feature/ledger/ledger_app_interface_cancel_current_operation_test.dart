import 'dart:async';

import 'package:app/feature/ledger/ledger.dart';
import 'package:async/async.dart';
import 'package:flutter_blue_plus/flutter_blue_plus.dart';
import 'package:mocktail/mocktail.dart';
import 'package:test/test.dart';

class _MockBleTransport extends Mock implements BleTransport {}

class _MockBluetoothDevice extends Mock implements BluetoothDevice {}

class _MockBluetoothService extends Mock implements BluetoothService {}

void main() {
  setUpAll(() {
    registerFallbackValue(<int>[]);
  });

  group('LedgerAppInterface.cancelCurrentOperation', () {
    late BleTransport transport;
    late BluetoothDevice device;

    setUp(() {
      transport = _MockBleTransport();
      device = _MockBluetoothDevice();

      when(() => device.isConnected).thenReturn(true);
      when(() => device.servicesList).thenReturn([_MockBluetoothService()]);
    });

    test('completes when there is no current operation', () async {
      // Arrange
      final interface = LedgerAppInterface.test(
        device: device,
        deviceModelId: DeviceModelId.nanoX,
        transport: transport,
      );

      // Act
      await interface.cancelCurrentOperation();

      // Assert
      verifyNever(() => transport.exchange(any()));
    });

    test(
      'cancels an in-flight exchange and getAppName throws cancellation',
      () async {
        // Arrange
        final interface = LedgerAppInterface.test(
          device: device,
          deviceModelId: DeviceModelId.nanoX,
          transport: transport,
        );
        final operationCompleter = CancelableCompleter<LedgerResponse>();

        when(
          () => transport.exchange(any()),
        ).thenAnswer((_) async => operationCompleter.operation);

        final result = interface.getAppName();
        final expectation = expectLater(
          result,
          throwsA(
            isA<Exception>().having(
              (error) => error.isLedgerOperationCancelled,
              'isLedgerOperationCancelled',
              isTrue,
            ),
          ),
        );

        await Future<void>.delayed(Duration.zero);

        // Act
        await interface.cancelCurrentOperation();

        // Assert
        await expectation;
      },
    );

    test(
      'ignores repeated cancellation after the current operation is cleared',
      () async {
        // Arrange
        final interface = LedgerAppInterface.test(
          device: device,
          deviceModelId: DeviceModelId.nanoX,
          transport: transport,
        );
        var cancelCount = 0;
        final operationCompleter = CancelableCompleter<LedgerResponse>(
          onCancel: () async {
            cancelCount++;
          },
        );

        when(
          () => transport.exchange(any()),
        ).thenAnswer((_) async => operationCompleter.operation);

        final result = interface.getAppName();
        final expectation = expectLater(
          result,
          throwsA(
            isA<Exception>().having(
              (error) => error.isLedgerOperationCancelled,
              'isLedgerOperationCancelled',
              isTrue,
            ),
          ),
        );

        await Future<void>.delayed(Duration.zero);

        // Act
        await interface.cancelCurrentOperation();
        await interface.cancelCurrentOperation();

        // Assert
        expect(cancelCount, 1);
        await expectation;
      },
    );
  });
}
