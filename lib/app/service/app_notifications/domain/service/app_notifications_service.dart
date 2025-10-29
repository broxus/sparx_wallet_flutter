import 'dart:async';

import 'package:app/app/service/app_notifications/domain/events/events.dart';
import 'package:app/extensions/completer_extension.dart';
import 'package:injectable/injectable.dart';
import 'package:logging/logging.dart';
import 'package:rxdart/rxdart.dart';

@singleton
class AppNotificationService {
  final _eventSubject = BehaviorSubject<AppNotificationEvent>();

  final _log = Logger('AppNotificationService');

  Stream<AppNotificationEvent> get events => _eventSubject;

  @disposeMethod
  void dispose() {
    _eventSubject.close();
  }

  Future<bool> showBrowserUrlAlert(String url) async {
    try {
      final completer = Completer<bool>();
      _eventSubject.add(
        AppNotificationBrowserExternalUrl(url, completer.completeSafe),
      );
      return completer.future;
    } catch (e, s) {
      _log.severe('showBrowserUrlAlert error', e, s);
      return false;
    }
  }
}
