import 'package:flutter/cupertino.dart';

sealed class AppNotificationEvent {}

class AppNotificationBrowserExternalUrl extends AppNotificationEvent {
  AppNotificationBrowserExternalUrl(this.link, this.onResult);

  final String link;

  final ValueChanged<bool> onResult;
}
