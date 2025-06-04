import 'package:elementary_helper/elementary_helper.dart';
import 'package:flutter/foundation.dart';

abstract interface class NotNullListenableState<T> extends Listenable
    implements ListenableState<T> {
  /// Returns current state.
  @override
  T get value;
}
