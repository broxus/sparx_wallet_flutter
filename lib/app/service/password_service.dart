import 'dart:async';
import 'dart:convert';

import 'package:app/app/service/service.dart';
import 'package:injectable/injectable.dart';
import 'package:logging/logging.dart';
import 'package:nekoton_repository/nekoton_repository.dart';
import 'package:rxdart/rxdart.dart';

@singleton
final class PasswordService {
  PasswordService(
    this._storageService,
    this._nekotonRepository,
    this._ntpService,
  );

  static final _logger = Logger('PasswordService');

  final NekotonRepository _nekotonRepository;
  final SecureStorageService _storageService;
  final NtpService _ntpService;

  /// Master key to state map
  final _state = <PublicKey, _State>{};

  StreamSubscription<SeedListDiffChange>? _subscription;

  Future<void> init() async {
    try {
      final json = await _storageService.getPasswordServiceStateJson();
      if (json != null) {
        final map = jsonDecode(json) as Map<String, dynamic>;

        for (final entry in map.entries) {
          try {
            final masterKey = PublicKey(publicKey: entry.key);
            final json = entry.value as Map<String, dynamic>;
            final state = _State(
              _ntpService,
              attempts: json['attempts'] as int,
              lastAttempt: json['lastAttempt'] != null
                  ? DateTime.tryParse(json['lastAttempt'] as String)
                  : null,
            );

            _state[masterKey] = state;
          } catch (e, s) {
            _logger.warning('Failed to parse state for key ${entry.key}', e, s);
          }
        }
      }
    } catch (e, s) {
      _logger.warning('Failed to parse state', e, s);
    }

    _subscription = _nekotonRepository.seedChangesStream.listen((event) async {
      final removedKeys = event.deletedSeeds.map(
        (seed) => seed.masterPublicKey,
      );

      var changed = false;
      for (final key in removedKeys) {
        final removed = _state.remove(key);
        if (removed != null) {
          changed = true;
          removed.dispose();
        }
      }

      if (changed) {
        await _saveState();
      }
    });
  }

  @disposeMethod
  void dispose() {
    _subscription?.cancel();
    _subscription = null;

    for (final state in _state.values) {
      state.dispose();
    }
  }

  PasswordLockState getLockState(PublicKey publicKey) {
    final masterKey = _getMasterKey(publicKey);

    // invalid state, should not happen
    if (masterKey == null) return _State(_ntpService);

    return _getLockState(masterKey);
  }

  Future<void> reset(PublicKey publicKey) async {
    final masterKey = _getMasterKey(publicKey);

    if (masterKey != null) {
      _getLockState(masterKey).reset();
    }

    await _saveState();
  }

  /// Check if the password is correct for the given public key
  Future<bool> checkKeyPassword({
    required PublicKey publicKey,
    required String password,
    required int? signatureId,
  }) async {
    final masterKey = _getMasterKey(publicKey);

    if (masterKey == null) return false;

    try {
      final state = _getLockState(masterKey);
      final correct = await _nekotonRepository.seedList.checkKeyPassword(
        publicKey: publicKey,
        password: password,
        signatureId: signatureId,
      );

      if (correct) {
        state.reset();
      } else {
        state.attempt();
      }

      return correct;
    } finally {
      await _saveState();
    }
  }

  _State _getLockState(PublicKey masterKey) {
    return _state[masterKey] ??= _State(_ntpService);
  }

  PublicKey? _getMasterKey(PublicKey publicKey) => _nekotonRepository.seedList
      .findSeedByAnyPublicKey(publicKey)
      ?.masterKey
      .publicKey;

  Future<void> _saveState() async {
    final state = Map<PublicKey, _State>.of(_state)
      ..removeWhere((_, value) => value.attempts == 0);
    final json = jsonEncode(
      state.map((key, value) => MapEntry(key.publicKey, value.toJson())),
    );

    await _storageService.setPasswordServiceStateJson(json);
  }
}

abstract class PasswordLockState {
  int get attempts;
  bool get isLocked;
  Stream<bool> get isLockedStream;
  DateTime? get lastAttempt;
  DateTime? get lockUntil;
}

final class _State implements PasswordLockState {
  _State(this._ntpService, {this.lastAttempt, this.attempts = 0}) {
    _update();
  }

  final NtpService _ntpService;

  @override
  int attempts;

  @override
  DateTime? lastAttempt;

  final _subject = BehaviorSubject<bool>();
  Timer? _unlockTimer;

  /// Returns the time until which password entry remains locked after
  /// consecutive failed attempts, or null if no lock is currently in effect.
  ///
  /// Behavior:
  /// - Returns null when there are fewer than 3 consecutive failed attempts,
  ///   or when there is no recorded timestamp for the last attempt.
  /// - Otherwise, returns `lastAttempt + lockDuration`.
  ///
  /// Lockout policy (critical security feature):
  /// - 7-9 failed attempts → 1 minute lock
  /// - 10+ failed attempts → 5 minutes lock
  @override
  DateTime? get lockUntil {
    if (attempts < 7) return null;
    final lockDuration = switch (attempts) {
      7 => const Duration(minutes: 1),
      8 => const Duration(minutes: 1),
      9 => const Duration(minutes: 1),
      _ => const Duration(minutes: 5),
    };
    return lastAttempt?.add(lockDuration);
  }

  @override
  bool get isLocked {
    final lockUntil = this.lockUntil;
    if (lockUntil == null) return false;
    return _ntpService.now().isBefore(lockUntil);
  }

  @override
  Stream<bool> get isLockedStream => _subject.stream.distinct();

  Map<String, dynamic> toJson() {
    return {
      'attempts': attempts,
      'lastAttempt': lastAttempt?.toIso8601String(),
    };
  }

  void attempt() {
    lastAttempt = _ntpService.now();
    attempts += 1;

    _update();
  }

  void reset() {
    lastAttempt = null;
    attempts = 0;

    _update();
  }

  void dispose() {
    _unlockTimer?.cancel();
    _unlockTimer = null;
    _subject.close();
  }

  void _update() {
    final lockUntil = this.lockUntil;
    final isLocked = this.isLocked;

    _unlockTimer?.cancel();
    _unlockTimer = null;

    if (isLocked && lockUntil != null) {
      final now = _ntpService.now();
      final timeToWait = lockUntil.difference(now) + const Duration(seconds: 1);

      if (!timeToWait.isNegative) {
        // Schedule unlock notification
        _unlockTimer = Timer(timeToWait, () {
          _subject.add(false);
          _unlockTimer = null;
        });
      }
    }

    _subject.add(isLocked);
  }
}
