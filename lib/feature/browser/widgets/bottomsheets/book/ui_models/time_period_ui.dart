import 'package:app/feature/browser/data/history_type.dart';
import 'package:app/utils/common_utils.dart';

extension TimePeriodExtension on TimePeriod {
  String get displayName {
    switch (this) {
      case TimePeriod.lastHour:
        return 'Last hour';
      case TimePeriod.today:
        return 'Today';
      case TimePeriod.todayYesterday:
        return 'Today and yesterday';
      case TimePeriod.allHistory:
        return 'History';
    }
  }

  DateTime get date {
    final now = NtpTime.now();
    switch (this) {
      case TimePeriod.lastHour:
        return now.subtract(const Duration(hours: 1));
      case TimePeriod.today:
        return DateTime(now.year, now.month, now.day);
      case TimePeriod.todayYesterday:
        final yesterday = now.subtract(const Duration(days: 1));
        return DateTime(yesterday.year, yesterday.month, yesterday.day);
      case TimePeriod.allHistory:
        return DateTime.fromMillisecondsSinceEpoch(0);
    }
  }
}
