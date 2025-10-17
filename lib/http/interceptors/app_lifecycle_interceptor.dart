import 'dart:async';
import 'dart:ui';

import 'package:app/app/service/service.dart';
import 'package:dio/dio.dart';
import 'package:injectable/injectable.dart';

@singleton
class AppLifecycleInterceptor extends Interceptor {
  AppLifecycleInterceptor(this._appLifecycleService) {
    _appLifecycleSubscription = _appLifecycleService.appLifecycleStateStream
        .listen((state) {
          switch (state) {
            case AppLifecycleState.inactive:
            case AppLifecycleState.hidden:
            case AppLifecycleState.paused:
            case AppLifecycleState.detached:
              _handleAppBackground();
            case AppLifecycleState.resumed:
              _handleAppForeground();
          }
        });
  }

  final AppLifecycleService _appLifecycleService;
  late final StreamSubscription<AppLifecycleState> _appLifecycleSubscription;

  bool _isAppInBackground = false;
  final _pendingCompleters = <Completer<void>>[];

  @override
  void onRequest(RequestOptions options, RequestInterceptorHandler handler) {
    if (_isAppInBackground) {
      // Create a completer for this request
      final completer = Completer<void>();
      _pendingCompleters.add(completer);

      // Wait for the app to come back to the foreground
      completer.future.then((_) => handler.next(options));

      return;
    }

    handler.next(options);
  }

  @disposeMethod
  void dispose() {
    _appLifecycleSubscription.cancel();
    _completePendingRequests();
  }

  void _handleAppBackground() {
    _isAppInBackground = true;
  }

  void _handleAppForeground() {
    _isAppInBackground = false;
    _completePendingRequests();
  }

  void _completePendingRequests() {
    for (final completer in _pendingCompleters) {
      if (!completer.isCompleted) {
        completer.complete();
      }
    }
    _pendingCompleters.clear();
  }
}
