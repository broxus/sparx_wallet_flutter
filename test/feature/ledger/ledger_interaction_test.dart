import 'package:app/feature/ledger/ledger.dart';
import 'package:flutter_blue_plus/flutter_blue_plus.dart';
import 'package:mocktail/mocktail.dart';
import 'package:nekoton_repository/nekoton_repository.dart';
import 'package:test/test.dart';

class _MockBluetoothDevice extends Mock implements BluetoothDevice {}

void main() {
  group('LedgerInteraction', () {
    late LedgerInteraction interactionWithConfirm;
    late LedgerInteraction interactionWithoutConfirm;
    late ConnectedLedger connected;
    late BluetoothDevice device;

    setUp(() {
      device = _MockBluetoothDevice();
      connected = const ConnectedLedger(
        remoteId: 'remote',
        masterKey: PublicKey(publicKey: 'pk'),
        deviceModelId: DeviceModelId.nanoX,
      );

      interactionWithConfirm = LedgerInteraction(
        interactionType: LedgerInteractionType.sign,
        device: device,
        connected: connected,
      );

      interactionWithoutConfirm = LedgerInteraction(
        interactionType: LedgerInteractionType.getPublicKey,
        device: device,
        connected: connected,
      );
    });

    test(
      'start moves to confirming when interaction requires confirmation',
      () async {
        // Arrange -> Act
        await interactionWithConfirm.start();

        // Assert
        expect(interactionWithConfirm.state, LedgerInteractionState.confirming);
        expect(interactionWithConfirm.isFinalState, isFalse);
      },
    );

    test(
      'start completes immediately when confirmation is not required',
      () async {
        // Arrange -> Act
        await interactionWithoutConfirm.start();

        // Assert
        expect(interactionWithoutConfirm.state, LedgerInteractionState.done);
        expect(interactionWithoutConfirm.isFinalState, isTrue);
      },
    );

    test('finish sets state to done when still active', () async {
      // Arrange
      await interactionWithConfirm.start();

      // Act
      await interactionWithConfirm.finish();

      // Assert
      expect(interactionWithConfirm.state, LedgerInteractionState.done);
      expect(interactionWithConfirm.isFinalState, isTrue);
    });

    test('cancel transitions to cancelled and final state', () async {
      // Arrange
      await interactionWithConfirm.start();

      // Act
      await interactionWithConfirm.cancel();

      // Assert
      expect(interactionWithConfirm.state, LedgerInteractionState.cancelled);
      expect(interactionWithConfirm.isFinalState, isTrue);
    });

    test('dispose cancels interaction and closes stream', () async {
      // Arrange
      final states = <LedgerInteractionState>[];
      final subscription = interactionWithConfirm.stateStream.listen(
        states.add,
      );

      // Act
      await interactionWithConfirm.dispose();

      // Assert
      expect(states.last, LedgerInteractionState.cancelled);
      expect(interactionWithConfirm.isFinalState, isTrue);
      await subscription.cancel();
    });
  });
}
