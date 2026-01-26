import 'package:app/feature/localization/domain/localization_service.dart';
import 'package:app/feature/localization/domain/supported_locale_codes.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  group('LocalizationService', () {
    late LocalizationService service;

    setUp(() {
      service = LocalizationService();
    });

    test('localeCode returns fallback when unset', () {
      // Arrange
      // Act
      final result = service.localeCode;

      // Assert
      expect(result, fallbackLocaleCode);
    });

    test('refreshLocale emits null to refresh stream', () async {
      // Arrange
      final refreshEvent = expectLater(
        service.refreshLocaleStream,
        emits(null),
      );

      // Act
      service.refreshLocale();

      // Assert
      await refreshEvent;
    });

    test(
      'updateCurrentLocaleByLanguageCodeFromServiceWidget updates locale',
      () async {
        // Arrange
        const newLocale = SupportedLocaleCodes.ko;
        final localeUpdated = expectLater(
          service.localeCodeStream,
          emits(newLocale),
        );

        // Act
        service.updateCurrentLocaleByLanguageCodeFromServiceWidget(newLocale);

        // Assert
        await localeUpdated;
        expect(service.localeCode, newLocale);
      },
    );

    test('updateCurrentLocaleByLanguageCodeFromServiceWidget '
        'ignores duplicate locale', () async {
      // Arrange
      const locale = SupportedLocaleCodes.en;
      final received = <SupportedLocaleCodes>[];
      final subscription = service.localeCodeStream.listen(received.add);

      // Act
      service
        ..updateCurrentLocaleByLanguageCodeFromServiceWidget(locale)
        ..updateCurrentLocaleByLanguageCodeFromServiceWidget(locale);
      await Future<void>.delayed(Duration.zero);
      await subscription.cancel();

      // Assert
      expect(received, [locale]);
    });

    test(
      'changeLocaleCode emits update when locale differs from current',
      () async {
        // Arrange
        const requestedLocale = SupportedLocaleCodes.ko;
        final updateEvent = expectLater(
          service.updateLocaleStream,
          emits(requestedLocale),
        );

        // Act
        service.changeLocaleCode(requestedLocale);

        // Assert
        await updateEvent;
      },
    );

    test(
      'changeLocaleCode skips emission when locale already current',
      () async {
        // Arrange
        const currentLocale = SupportedLocaleCodes.en;
        service.updateCurrentLocaleByLanguageCodeFromServiceWidget(
          currentLocale,
        );
        final received = <SupportedLocaleCodes>[];
        final subscription = service.updateLocaleStream.listen(received.add);

        // Act
        service.changeLocaleCode(currentLocale);
        await Future<void>.delayed(Duration.zero);
        await subscription.cancel();

        // Assert
        expect(received, isEmpty);
      },
    );
  });
}
