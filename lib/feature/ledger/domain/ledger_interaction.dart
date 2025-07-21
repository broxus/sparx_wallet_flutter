import 'package:app/feature/ledger/ledger.dart';
import 'package:async/async.dart';
import 'package:flutter_blue_plus/flutter_blue_plus.dart';
import 'package:nekoton_repository/nekoton_repository.dart';
import 'package:rxdart/rxdart.dart';

class LedgerInteraction {
  LedgerInteraction({
    required this.interactionType,
    required this.device,
    required this.connected,
  });

  final LedgerInteractionType interactionType;
  final BluetoothDevice device;
  final ConnectedLedger connected;

  final _subject = BehaviorSubject.seeded(LedgerInteractionState.connecting);
  CancelableOperation<bool>? _operation;

  Stream<LedgerInteractionState> get stateStream => _subject.stream;

  bool get isFinalState =>
      _subject.value == LedgerInteractionState.done ||
      _subject.value == LedgerInteractionState.cancelled;

  Future<LedgerAppInterface> prepare() async {
    try {
      _operation = device.waitForConnection();
      final connectResult = await _operation?.valueOrCancellation(false);

      if (connectResult == false || (_operation?.isCanceled ?? false)) {
        throw const OperationCanceledException();
      }

      _subject.add(LedgerInteractionState.initializing);

      final appInterface = LedgerAppInterface(
        device: device,
        deviceModelId: connected.deviceModelId,
      );

      _operation = appInterface.waitForApp();
      final appResult = await _operation?.valueOrCancellation(false);

      if (appResult == false || (_operation?.isCanceled ?? false)) {
        throw const OperationCanceledException();
      }

      return appInterface;
    } finally {
      await _operation?.cancel();
      _operation = null;
    }
  }

  Future<void> start() async {
    if (isFinalState) return;
    if (interactionType.needsConfirmation) {
      _subject.add(LedgerInteractionState.confirming);
    } else {
      _subject.add(LedgerInteractionState.done);
    }
  }

  Future<void> finish() async {
    if (isFinalState) return;
    _subject.add(LedgerInteractionState.done);
  }

  Future<void> cancel() async {
    await _operation?.cancel();
    _operation = null;

    if (isFinalState) return;
    _subject.add(LedgerInteractionState.cancelled);
  }

  Future<void> dispose() async {
    await _operation?.cancel();
    _operation = null;

    if (_subject.isClosed) return;
    if (!isFinalState) {
      _subject.add(LedgerInteractionState.cancelled);
    }
    await _subject.close();
  }
}
