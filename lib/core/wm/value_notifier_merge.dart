import 'package:app/core/wm/not_null_listenable_state.dart';
import 'package:elementary_helper/elementary_helper.dart';
import 'package:flutter/foundation.dart';

class ValueNotifierMergeWithNotNullListenableState<T> extends ValueNotifier<T> {
  ValueNotifierMergeWithNotNullListenableState(this._mergingNotifier)
      : super(_mergingNotifier.value.value) {
    _mergingNotifier.addListener(_listenUpdates);
    _listenUpdates();
  }

  final ValueListenable<NotNullListenableState<T>> _mergingNotifier;
  NotNullListenableState<T>? _previousNotifier;

  @override
  void dispose() {
    _previousNotifier?.removeListener(_update);
    _previousNotifier = null;
    _mergingNotifier.removeListener(_listenUpdates);
    super.dispose();
  }

  void _listenUpdates() {
    _previousNotifier?.removeListener(_update);
    _previousNotifier = _mergingNotifier.value;
    _previousNotifier?.addListener(_update);
  }

  void _update() {
    value = _mergingNotifier.value.value;
  }
}

class ValueNotifierMerge<T> extends ValueNotifier<T> {
  ValueNotifierMerge(this._mergingNotifier)
      : super(_mergingNotifier.value.value) {
    _mergingNotifier.addListener(_listenUpdates);
    _listenUpdates();
  }

  final ValueListenable<ValueListenable<T>> _mergingNotifier;
  ValueListenable<T>? _previousNotifier;

  @override
  void dispose() {
    _previousNotifier?.removeListener(_update);
    _previousNotifier = null;
    _mergingNotifier.removeListener(_listenUpdates);
    super.dispose();
  }

  void _listenUpdates() {
    _previousNotifier?.removeListener(_update);
    _previousNotifier = _mergingNotifier.value;
    _previousNotifier?.addListener(_update);
  }

  void _update() {
    value = _mergingNotifier.value.value;
  }
}

class ValueNotifierMergeWithListenableState<T> extends ValueNotifier<T?> {
  ValueNotifierMergeWithListenableState(this._mergingNotifier)
      : super(_mergingNotifier.value.value) {
    _mergingNotifier.addListener(_listenUpdates);
    _listenUpdates();
  }

  final ValueListenable<ListenableState<T>> _mergingNotifier;
  ListenableState<T>? _previousNotifier;

  @override
  void dispose() {
    _previousNotifier?.removeListener(_update);
    _previousNotifier = null;
    _mergingNotifier.removeListener(_listenUpdates);
    super.dispose();
  }

  void _listenUpdates() {
    _previousNotifier?.removeListener(_update);
    _previousNotifier = _mergingNotifier.value;
    _previousNotifier?.addListener(_update);
  }

  void _update() {
    value = _mergingNotifier.value.value;
  }
}

extension ValueNotifierMergeWithNotNullListenableStateExtension<T>
    on ValueListenable<NotNullListenableState<T>> {
  /// Merges the value of this notifier with another notifier.
  ValueNotifier<T> asMerged() {
    return ValueNotifierMergeWithNotNullListenableState(this);
  }
}

extension ValueNotifierMergeExtension<T>
    on ValueListenable<ValueListenable<T>> {
  /// Merges the value of this notifier with another notifier.
  ValueNotifier<T> asMerged() {
    return ValueNotifierMerge(this);
  }
}

extension ValueNotifierMergeWithListenableStateExtension<T>
    on ValueListenable<ListenableState<T>> {
  ValueNotifier<T?> asMerged() {
    return ValueNotifierMergeWithListenableState(this);
  }
}
