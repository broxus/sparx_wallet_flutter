import 'dart:async';

import 'package:app/core/wm/not_null_safe_notifier.dart';
import 'package:app/core/wm/safe_state_notifier.dart';
import 'package:elementary/elementary.dart';
import 'package:elementary_helper/elementary_helper.dart';
import 'package:flutter/widgets.dart';

/// Collection [ChangeNotifier]]
class _NotifierSubscriptionsCollection {
  final _notifiers = <ChangeNotifier>[];

  /// Add [ChangeNotifier] or its successor to the notifier collection
  T add<T extends ChangeNotifier>(T notifier) {
    _notifiers.add(notifier);
    return notifier;
  }

  /// Closes all [ChangeNotifier] and clears the collection
  void dispose() {
    for (final notifier in _notifiers) {
      notifier.dispose();
    }
    _notifiers.clear();
  }
}

/// Collection [StreamSubscription]]
class _StreamSubscriptionsCollection {
  final _subscriptions = <StreamSubscription<dynamic>>[];

  /// Add [StreamSubscription] or its successor to the subscription collection
  T add<T extends StreamSubscription<dynamic>>(T subscription) {
    _subscriptions.add(subscription);
    return subscription;
  }

  /// Cancels all [StreamSubscription] and clears the collection
  void dispose() {
    for (final subscription in _subscriptions) {
      subscription.cancel();
    }
    _subscriptions.clear();
  }
}

mixin NotifierSubscriptionsMixin<W extends ElementaryWidget,
    M extends ElementaryModel> on WidgetModel<W, M> {
  late final _subscriptionsCollection = _NotifierSubscriptionsCollection();
  late final _streamSubscriptionsCollection = _StreamSubscriptionsCollection();
  late final _widgetPropsReaders =
      <StateNotifier<dynamic>, dynamic Function(W)>{};

  void _readWidgetProps() {
    for (final MapEntry(key: notifier, value: reader)
        in _widgetPropsReaders.entries) {
      notifier.accept(reader(widget));
    }
  }

  @override
  @mustCallSuper
  void initWidgetModel() {
    _readWidgetProps();
    super.initWidgetModel();
  }

  @override
  @mustCallSuper
  void didUpdateWidget(W oldWidget) {
    _readWidgetProps();
    super.didUpdateWidget(oldWidget);
  }

  @override
  @mustCallSuper
  void dispose() {
    _subscriptionsCollection.dispose();
    _streamSubscriptionsCollection.dispose();
    _widgetPropsReaders.clear();
    super.dispose();
  }

  /// Create [NotNullNotifier] and add to the notifier collection
  @protected
  NotNullNotifier<T> createNotNullNotifier<T>(T initValue) {
    return _subscriptionsCollection.add(
      NotNullNotifier<T>(initValue),
    );
  }

  /// Create [StateNotifier] and add to the notifier collection
  @protected
  StateNotifier<T> createNotifier<T>([T? initValue]) {
    return _subscriptionsCollection.add(
      SafeStateNotifier<T>(initValue: initValue),
    );
  }

  /// Create [ValueNotifier] and add to the notifier collection
  @protected
  ValueNotifier<T> createValueNotifier<T>(T initValue) {
    return _subscriptionsCollection.add(
      ValueNotifier<T>(initValue),
    );
  }

  /// Create [Entity StateNotifier] and add to the notifier collection
  @protected
  EntityStateNotifier<T> createEntityNotifier<T>([
    EntityState<T>? initialData,
  ]) {
    return _subscriptionsCollection.add(
      EntityStateNotifier<T>(initialData),
    );
  }

  /// Creates a [StateNotifier] and adds it to the notifier collection.
  /// The notifier will be populated with data during [initWidgetModel]
  /// and [didUpdateWidget].
  @protected
  ListenableState<T> createWidgetProperty<T>(T Function(W) reader) {
    final initialValue = isMounted ? reader(widget) : null;
    final notifier = createNotifier<T>(initialValue);
    _widgetPropsReaders[notifier] = reader;
    return notifier;
  }

  /// Create [TextEditingController] and add to the informant collection
  @protected
  TextEditingController createTextEditingController([
    String? initialText,
  ]) {
    return _subscriptionsCollection.add(
      TextEditingController(text: initialText),
    );
  }

  /// Create [FocusNode] and add to the informant collection
  @protected
  FocusNode createFocusNode() {
    return _subscriptionsCollection.add(FocusNode());
  }

  /// Create [ScrollController] and add to the informants collectionx
  @protected
  ScrollController createScrollController() {
    return _subscriptionsCollection.add(ScrollController());
  }

  /// Create [StateNotifier] from [Stream] and add to the notifier collection
  @protected
  StateNotifier<T> createNotifierFromStream<T>(Stream<T> stream) {
    final notifier = SafeStateNotifier<T>();

    _streamSubscriptionsCollection.add(
      stream.listen(notifier.accept),
    );

    return _subscriptionsCollection.add(notifier);
  }

  @protected
  void disposableListen<T>(
    Stream<T> stream,
    void Function(T event)? onData, {
    Function? onError,
    void Function()? onDone,
    bool? cancelOnError,
  }) {
    _streamSubscriptionsCollection.add(
      stream.listen(
        onData,
        onError: onError,
        onDone: onDone,
        cancelOnError: cancelOnError,
      ),
    );
  }
}
