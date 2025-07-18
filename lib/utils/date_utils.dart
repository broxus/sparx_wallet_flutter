import 'package:app/generated/generated.dart';
import 'package:app/utils/utils.dart';
import 'package:flutter/material.dart';

class DateTimeUtils {
  static String formatExpirationDate(DateTime dateTime) {
    final now = DateTime.now();
    final duration = dateTime.difference(now);

    final hours = duration.inHours.toString();
    final minutes = (duration.inMinutes % 60).toString();

    final formattedDate = DateFormat('MMM d').format(dateTime);
    final formattedTime = DateFormat('HH:mm').format(dateTime);

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
  static String formatTransactionDate(DateTime dateTime, BuildContext context) {
    final now = NtpTime.now();

    // Check if transaction date is today
    if (dateTime.isSameDay(now)) {
      return LocaleKeys.today.tr();
    }

    // Format date based on year comparison
    final formatter = dateTime.year == now.year
        ? DateFormat('MMMM dd', context.locale.languageCode)
        : DateFormat('MMMM dd y', context.locale.languageCode);

    return formatter.format(dateTime);
  }
}
