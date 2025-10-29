import 'dart:async';

import 'package:app/app/router/router.dart';
import 'package:app/app/service/app_notifications/domain/events/events.dart';
import 'package:app/app/service/app_notifications/widget/app_notifications_widget.dart';
import 'package:app/app/service/app_notifications/widget/app_notifications_widget_model.dart';
import 'package:app/app/service/app_notifications/widget/url_alert.dart';
import 'package:app/core/wm/custom_wm.dart';
import 'package:elementary/elementary.dart';
import 'package:flutter/cupertino.dart';
import 'package:injectable/injectable.dart';

/// [WidgetModel] for [AppNotificationsWidget]
@injectable
class AppNotificationsWidgetWidgetModel
    extends
        CustomWidgetModel<AppNotificationsWidget, AppNotificationsWidgetModel> {
  AppNotificationsWidgetWidgetModel(super.model);

  StreamSubscription<AppNotificationEvent>? _eventsSubscription;

  late final _rootContext = CompassRouter.navigatorKey.currentContext;

  @override
  void initWidgetModel() {
    super.initWidgetModel();
    _eventsSubscription = model.events.listen(_handleEvents);
  }

  @override
  void dispose() {
    _eventsSubscription?.cancel();
    super.dispose();
  }

  Future<void> _handleEvents(AppNotificationEvent event) async {
    switch (event) {
      case AppNotificationBrowserExternalUrl(:final link, :final onResult):
        WidgetsBinding.instance.addPostFrameCallback((_) async {
          if (_rootContext != null) {
            onResult(await UrlAlert.show(_rootContext, link) ?? false);
          }
        });
    }
  }
}
