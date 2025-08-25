import 'package:app/generated/generated.dart';
import 'package:app/utils/utils.dart';

const _dtf = <(String, String?), DateFormat>{};

class DateTimeUtils {
  static DateFormat getDateFormat(String pattern, [String? locale]) {
    final key = (pattern, locale);
    return _dtf.putIfAbsent(key, () => DateFormat(pattern, locale));
  }

  static String formatExpirationDate(DateTime dateTime, [String? locale]) {
    // final currentLocale = Intl.getCurrentLocale()
    final now = DateTime.now();
    final duration = dateTime.difference(now);

    final hours = duration.inHours.toString();
    final minutes = (duration.inMinutes % 60).toString();

    final formattedDate = getDateFormat('MMM d', locale).format(dateTime);
    final formattedTime = getDateFormat('HH:mm', locale).format(dateTime);

    return LocaleKeys.expirationTimeDetails.tr(
      args: [
        hours,
        minutes,
        formattedDate,
        formattedTime,
      ],
    );
  }

  /// Formats transaction date, showing 'Today' for current date or formatted
  /// date otherwise
  static String formatTransactionDate(DateTime dateTime, [String? locale]) {
    final now = NtpTime.now();

    // Check if transaction date is today
    if (dateTime.isSameDay(now)) {
      return LocaleKeys.today.tr();
    }

    // Format date based on year comparison
    final formatter = dateTime.year == now.year
        ? getDateFormat('MMMM dd', locale)
        : getDateFormat('MMMM dd y', locale);

    return formatter.format(dateTime);
  }
}
