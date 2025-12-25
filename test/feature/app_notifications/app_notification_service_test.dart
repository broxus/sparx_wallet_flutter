import 'package:app/feature/app_notifications/domain/app_notifications_service.dart';
import 'package:app/feature/app_notifications/domain/events.dart';
import 'package:test/test.dart';

void main() {
  group('AppNotificationService', () {
    test(
      'showBrowserUrlAlert emits event and resolves true when confirmed',
      () async {
        // Arrange
        final service = AppNotificationService();
        final eventsFuture = service.events.first;

        // Act
        final resultFuture = service.showBrowserUrlAlert('https://example.com');
        final event = await eventsFuture as AppNotificationBrowserExternalUrl;
        event.onResult(true);

        // Assert
        expect(await resultFuture, isTrue);

        service.dispose();
      },
    );

    test('showBrowserUrlAlert resolves provided result when denied', () async {
      // Arrange
      final service = AppNotificationService();
      final eventsFuture = service.events.first;

      // Act
      final resultFuture = service.showBrowserUrlAlert('https://example.com');
      final event = await eventsFuture as AppNotificationBrowserExternalUrl;
      event.onResult(false);

      // Assert
      expect(await resultFuture, isFalse);

      service.dispose();
    });

    test(
      'showBrowserUrlAlert returns false when events stream is closed',
      () async {
        // Arrange
        final service = AppNotificationService();
        service.dispose();

        // Act
        final result = await service.showBrowserUrlAlert('https://example.com');

        // Assert
        expect(result, isFalse);
      },
    );
  });
}
