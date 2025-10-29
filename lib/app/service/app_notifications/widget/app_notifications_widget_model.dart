import 'package:app/app/service/app_notifications/domain/events/events.dart';
import 'package:app/app/service/app_notifications/domain/service/app_notifications_service.dart';
import 'package:app/app/service/app_notifications/widget/app_notifications_widget.dart';
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
