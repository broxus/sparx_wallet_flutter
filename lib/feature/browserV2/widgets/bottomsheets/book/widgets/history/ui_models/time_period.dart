enum TimePeriod { lastHour, today, todayYesterday, allHistory }

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
}
