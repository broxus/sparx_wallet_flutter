import 'dart:convert';

import 'package:app/app/service/service.dart';
import 'package:app/utils/utils.dart';
import 'package:injectable/injectable.dart';
import 'package:logging/logging.dart';
import 'package:nekoton_repository/nekoton_repository.dart';
import 'package:rxdart/rxdart.dart';

@singleton
final class PasswordService {
  PasswordService(this._storageService, this._nekotonRepository);

  static final _logger = Logger('PasswordService');

  final NekotonRepository _nekotonRepository;
  final SecureStorageService _storageService;

  _State _state = const _State();

  bool get isLocked => _state.isLocked;

  DateTime? get lockUntil => _state.lockUntil;

  Stream<bool> get isLockedStream => Stream<dynamic>.periodic(
    const Duration(seconds: 1),
  ).map((_) => isLocked).startWith(isLocked).distinct();

  Future<void> init() async {
    try {
      final json = await _storageService.getPasswordServiceStateJson();
      if (json != null) {
        _state = _State.fromJson(jsonDecode(json) as Map<String, dynamic>);
      }
    } catch (e, s) {
      _logger.warning('Failed to parse state', e, s);
    }
  }

  Future<void> reset() => _updateState();

  /// Check if the password is correct for the given public key
  Future<bool> checkKeyPassword({
    required PublicKey publicKey,
    required String password,
    required int? signatureId,
  }) async {
    if (isLocked) return false;

    final correct = await _nekotonRepository.seedList.checkKeyPassword(
      publicKey: publicKey,
      password: password,
      signatureId: signatureId,
    );

    if (correct) {
      await _updateState();
    } else {
      await _updateState(_state);
    }

    return correct;
  }

  Future<void> _updateState([_State? newState]) async {
    _state = _State.from(newState);
    await _storageService.setPasswordServiceStateJson(
      jsonEncode(_state.toJson()),
    );
  }
}

final class _State {
  const _State({this.lastAttempt, this.attempts = 0});

  factory _State.from([_State? previous]) {
    if (previous == null) {
      return const _State();
    }

    return _State(lastAttempt: NtpTime.now(), attempts: previous.attempts + 1);
  }

  factory _State.fromJson(Map<String, dynamic> json) {
    return _State(
      attempts: json['attempts'] as int,
      lastAttempt: json['lastAttempt'] != null
          ? DateTime.tryParse(json['lastAttempt'] as String)
          : null,
    );
  }

  final int attempts;
  final DateTime? lastAttempt;

  /// Returns the time until which password entry remains locked after
  /// consecutive failed attempts, or null if no lock is currently in effect.
  ///
  /// Behavior:
  /// - Returns null when there are fewer than 3 consecutive failed attempts,
  ///   or when there is no recorded timestamp for the last attempt.
  /// - Otherwise, returns `lastAttempt + lockDuration`.
  ///
  /// Lockout policy (critical security feature):
  /// - 3 failed attempts → 30 seconds lock
  /// - 4 failed attempts → 5 minutes lock
  /// - 5 failed attempts → 30 minutes lock
  /// - 6+ failed attempts → 1 hour lock
  DateTime? get lockUntil {
    if (attempts < 3) return null;
    final lockDuration = switch (attempts) {
      3 => const Duration(seconds: 30),
      4 => const Duration(minutes: 5),
      5 => const Duration(minutes: 30),
      _ => const Duration(hours: 1),
    };
    return lastAttempt?.add(lockDuration);
  }

  bool get isLocked {
    final lockUntil = this.lockUntil;
    if (lockUntil == null) return false;
    return NtpTime.now().isBefore(lockUntil);
  }

  Map<String, dynamic> toJson() {
    return {
      'attempts': attempts,
      'lastAttempt': lastAttempt?.toIso8601String(),
    };
  }
}
