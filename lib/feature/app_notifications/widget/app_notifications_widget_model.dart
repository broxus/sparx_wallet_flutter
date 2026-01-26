import 'package:app/feature/app_notifications/app_notifications.dart';
import 'package:elementary/elementary.dart';
import 'package:injectable/injectable.dart';

/// [ElementaryModel] for [AppNotificationsWidget]
@injectable
class AppNotificationsWidgetModel extends ElementaryModel {
  AppNotificationsWidgetModel(
    ErrorHandler errorHandler,
    this._appNotificationService,
  ) : super(errorHandler: errorHandler);

  final AppNotificationService _appNotificationService;

  Stream<AppNotificationEvent> get events => _appNotificationService.events;
}
