import 'dart:async';

import 'package:app/generated/generated.dart';
import 'package:app/utils/utils.dart';
import 'package:flutter/material.dart';
import 'package:ui_components_lib/ui_components_lib.dart';

const _secondsPerMinute = 60;
const _secondsPerHour = 3600;
const _minTimerDelay = 1;

/// A widget that displays remaining time until a transaction expires.
/// Updates automatically at optimal intervals to minimize unnecessary rebuilds.
class TransactionExpirationCountdown extends StatefulWidget {
  const TransactionExpirationCountdown({
    required this.expireAt,
    this.style,
    super.key,
  });

  final DateTime expireAt;
  final TextStyle? style;

  @override
  State<TransactionExpirationCountdown> createState() =>
      _TransactionExpirationCountdownState();
}

class _TransactionExpirationCountdownState
    extends State<TransactionExpirationCountdown> {
  Timer? _timer;
  late int _remainingSeconds;

  @override
  void initState() {
    super.initState();
    _remainingSeconds = _calculateRemainingSeconds();
    _scheduleNextUpdate();
  }

  @override
  void didUpdateWidget(TransactionExpirationCountdown oldWidget) {
    super.didUpdateWidget(oldWidget);
    if (oldWidget.expireAt != widget.expireAt) {
      _cancelTimer();
      _remainingSeconds = _calculateRemainingSeconds();
      _scheduleNextUpdate();
    }
  }

  @override
  void dispose() {
    _cancelTimer();
    super.dispose();
  }

  void _cancelTimer() {
    _timer?.cancel();
    _timer = null;
  }

  int _calculateRemainingSeconds() {
    return widget.expireAt.difference(NtpTime.clockNow()).inSeconds;
  }

  void _scheduleNextUpdate() {
    _cancelTimer();

    if (_remainingSeconds <= 0) return;

    _timer = Timer(Duration(seconds: _nextUpdateDelay), () {
      if (!mounted) {
        return;
      }

      setState(() {
        _remainingSeconds = _calculateRemainingSeconds();
      });
      _scheduleNextUpdate();
    });
  }

  int get _nextUpdateDelay {
    if (_remainingSeconds < _secondsPerMinute) {
      return _remainingSeconds > 0 ? _remainingSeconds : _minTimerDelay;
    }

    return (_remainingSeconds % _secondsPerMinute) + _minTimerDelay;
  }

  String _displayText() {
    if (_remainingSeconds <= 0) {
      return LocaleKeys.transactionExpired.tr();
    }

    final hours = _remainingSeconds ~/ _secondsPerHour;
    final minutes = (_remainingSeconds % _secondsPerHour) ~/ _secondsPerMinute;
    final countdownText = hours > 0
        ? _formatHoursAndMinutes(hours, minutes)
        : _formatMinutes(minutes);

    return LocaleKeys.expiresInCustodians.tr(args: [countdownText]);
  }

  String _formatHoursAndMinutes(int hours, int minutes) {
    final hoursText = '$hours ${LocaleKeys.timeUnitHourShort.tr()}';

    return minutes > 0
        ? '$hoursText $minutes ${LocaleKeys.timeUnitMinuteShort.tr()}'
        : hoursText;
  }

  String _formatMinutes(int minutes) {
    return minutes > 0
        ? '$minutes ${LocaleKeys.timeUnitMinuteShort.tr()}'
        : LocaleKeys.lessThanOneMinute.tr();
  }

  @override
  Widget build(BuildContext context) {
    return Text(
      _displayText(),
      overflow: TextOverflow.ellipsis,
      softWrap: false,
      maxLines: 1,
      style:
          widget.style ??
          context.themeStyle.textStyles.labelXSmall.copyWith(
            color: context.themeStyle.colors.content3,
          ),
    );
  }
}
