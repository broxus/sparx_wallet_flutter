import 'package:app/core/wm/custom_wm.dart';
import 'package:app/feature/app_notifications/app_notifications.dart';
import 'package:flutter/material.dart';

class AppNotificationsWidget
    extends InjectedElementaryWidget<AppNotificationsWidgetWidgetModel> {
  const AppNotificationsWidget({required this.child, super.key});

  final Widget child;

  @override
  Widget build(AppNotificationsWidgetWidgetModel wm) {
    return child;
  }
}
