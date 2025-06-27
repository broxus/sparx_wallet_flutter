import 'package:flutter/widgets.dart';
import 'package:injectable/injectable.dart';
import 'package:logging/logging.dart';
import 'package:rxdart/rxdart.dart';

/// Service that helps watching app lifecycle state.
@singleton
class AppLifecycleService {
  static final _logger = Logger('AppLifecycleService');

  final _appLifecycleStateSubject =
      BehaviorSubject<AppLifecycleState>(sync: true);

  /// Stream of app lifecycle state
  Stream<AppLifecycleState> get appLifecycleStateStream =>
      _appLifecycleStateSubject.stream;

  /// Current app lifecycle state
  AppLifecycleState get appLifecycleState => _appLifecycleStateSubject.value;

  /// Set new app lifecycle state
  void updateState(AppLifecycleState state) {
    _appLifecycleStateSubject.add(state);
    _logger.info('State updated: $state');
  }
}
