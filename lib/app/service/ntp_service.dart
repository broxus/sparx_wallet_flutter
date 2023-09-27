import 'dart:async';

import 'package:injectable/injectable.dart';
import 'package:logging/logging.dart';
import 'package:ntp/ntp.dart';
import 'package:rxdart/rxdart.dart';

/// Maximum time to wait for NTP server response
const _updateTimeout = Duration(seconds: 10);

/// Period of time between NTP server requests
const _updatePeriod = Duration(minutes: 1);

Timer? _updateTimer;

/// Service that helps watching app lifecycle state.
@singleton
class NtpService {
  final _log = Logger('NtpService');

  bool _periodicUpdatesEnabled = false;

  Future<void> init() async {
    /// Start periodic updates, but don't wait for it to complete
    /// because it may take a long time (network request of the
    /// first update)
    unawaited(_startPeriodicUpdates());
  }

  @disposeMethod
  void dispose() {
    _stopPeriodicUpdates();
  }

  final _offsetSubject = BehaviorSubject<Duration>.seeded(Duration.zero);

  /// Stream of the offset of the system clock from the NTP server
  Stream<Duration> get offsetStream => _offsetSubject;

  /// Current offset of the system clock from the NTP server
  Duration get offset => _offsetSubject.value;

  /// Current time of the system clock with offset from the NTP server
  DateTime now() => DateTime.now().add(offset);

  Future<void> _startPeriodicUpdates() async {
    _log.info('Starting periodic updates');

    _periodicUpdatesEnabled = true;

    await update();
    _scheduleNextUpdate();
  }

  void _stopPeriodicUpdates() {
    _log.info('Stopping periodic updates');

    _periodicUpdatesEnabled = false;
    _updateTimer?.cancel();
  }

  void _scheduleNextUpdate() {
    _updateTimer?.cancel();

    _updateTimer = Timer(
      _updatePeriod,
      () async {
        if (_periodicUpdatesEnabled) {
          await update();
          _scheduleNextUpdate();
        }
      },
    );
  }

  /// Updates offset from the NTP server
  Future<void> update() async {
    _log.finest('Updating offset...');
    try {
      final offset = await NTP.getNtpOffset(timeout: _updateTimeout);
      _offsetSubject.add(Duration(milliseconds: offset));
      _log.finest('...offset updated: $offset');
    } catch (e, s) {
      _log.warning('...failed to update offset', e, s);
    }
  }
}
