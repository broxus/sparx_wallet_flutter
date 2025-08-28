// GENERATED CODE - DO NOT MODIFY BY HAND
// coverage:ignore-file
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'key_removed_event.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// dart format off
T _$identity<T>(T value) => value;

/// @nodoc
mixin _$KeyRemovedEvent {
  KeyStoreEntry get key;

  /// Create a copy of KeyRemovedEvent
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @pragma('vm:prefer-inline')
  $KeyRemovedEventCopyWith<KeyRemovedEvent> get copyWith =>
      _$KeyRemovedEventCopyWithImpl<KeyRemovedEvent>(
          this as KeyRemovedEvent, _$identity);

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is KeyRemovedEvent &&
            (identical(other.key, key) || other.key == key));
  }

  @override
  int get hashCode => Object.hash(runtimeType, key);

  @override
  String toString() {
    return 'KeyRemovedEvent(key: $key)';
  }
}

/// @nodoc
abstract mixin class $KeyRemovedEventCopyWith<$Res> {
  factory $KeyRemovedEventCopyWith(
          KeyRemovedEvent value, $Res Function(KeyRemovedEvent) _then) =
      _$KeyRemovedEventCopyWithImpl;
  @useResult
  $Res call({KeyStoreEntry key});

  $KeyStoreEntryCopyWith<$Res> get key;
}

/// @nodoc
class _$KeyRemovedEventCopyWithImpl<$Res>
    implements $KeyRemovedEventCopyWith<$Res> {
  _$KeyRemovedEventCopyWithImpl(this._self, this._then);

  final KeyRemovedEvent _self;
  final $Res Function(KeyRemovedEvent) _then;

  /// Create a copy of KeyRemovedEvent
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? key = null,
  }) {
    return _then(_self.copyWith(
      key: null == key
          ? _self.key
          : key // ignore: cast_nullable_to_non_nullable
              as KeyStoreEntry,
    ));
  }

  /// Create a copy of KeyRemovedEvent
  /// with the given fields replaced by the non-null parameter values.
  @override
  @pragma('vm:prefer-inline')
  $KeyStoreEntryCopyWith<$Res> get key {
    return $KeyStoreEntryCopyWith<$Res>(_self.key, (value) {
      return _then(_self.copyWith(key: value));
    });
  }
}

/// Adds pattern-matching-related methods to [KeyRemovedEvent].
extension KeyRemovedEventPatterns on KeyRemovedEvent {
  /// A variant of `map` that fallback to returning `orElse`.
  ///
  /// It is equivalent to doing:
  /// ```dart
  /// switch (sealedClass) {
  ///   case final Subclass value:
  ///     return ...;
  ///   case _:
  ///     return orElse();
  /// }
  /// ```

  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>(
    TResult Function(_KeyRemovedEvent value)? $default, {
    required TResult orElse(),
  }) {
    final _that = this;
    switch (_that) {
      case _KeyRemovedEvent() when $default != null:
        return $default(_that);
      case _:
        return orElse();
    }
  }

  /// A `switch`-like method, using callbacks.
  ///
  /// Callbacks receives the raw object, upcasted.
  /// It is equivalent to doing:
  /// ```dart
  /// switch (sealedClass) {
  ///   case final Subclass value:
  ///     return ...;
  ///   case final Subclass2 value:
  ///     return ...;
  /// }
  /// ```

  @optionalTypeArgs
  TResult map<TResult extends Object?>(
    TResult Function(_KeyRemovedEvent value) $default,
  ) {
    final _that = this;
    switch (_that) {
      case _KeyRemovedEvent():
        return $default(_that);
      case _:
        throw StateError('Unexpected subclass');
    }
  }

  /// A variant of `map` that fallback to returning `null`.
  ///
  /// It is equivalent to doing:
  /// ```dart
  /// switch (sealedClass) {
  ///   case final Subclass value:
  ///     return ...;
  ///   case _:
  ///     return null;
  /// }
  /// ```

  @optionalTypeArgs
  TResult? mapOrNull<TResult extends Object?>(
    TResult? Function(_KeyRemovedEvent value)? $default,
  ) {
    final _that = this;
    switch (_that) {
      case _KeyRemovedEvent() when $default != null:
        return $default(_that);
      case _:
        return null;
    }
  }

  /// A variant of `when` that fallback to an `orElse` callback.
  ///
  /// It is equivalent to doing:
  /// ```dart
  /// switch (sealedClass) {
  ///   case Subclass(:final field):
  ///     return ...;
  ///   case _:
  ///     return orElse();
  /// }
  /// ```

  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>(
    TResult Function(KeyStoreEntry key)? $default, {
    required TResult orElse(),
  }) {
    final _that = this;
    switch (_that) {
      case _KeyRemovedEvent() when $default != null:
        return $default(_that.key);
      case _:
        return orElse();
    }
  }

  /// A `switch`-like method, using callbacks.
  ///
  /// As opposed to `map`, this offers destructuring.
  /// It is equivalent to doing:
  /// ```dart
  /// switch (sealedClass) {
  ///   case Subclass(:final field):
  ///     return ...;
  ///   case Subclass2(:final field2):
  ///     return ...;
  /// }
  /// ```

  @optionalTypeArgs
  TResult when<TResult extends Object?>(
    TResult Function(KeyStoreEntry key) $default,
  ) {
    final _that = this;
    switch (_that) {
      case _KeyRemovedEvent():
        return $default(_that.key);
      case _:
        throw StateError('Unexpected subclass');
    }
  }

  /// A variant of `when` that fallback to returning `null`
  ///
  /// It is equivalent to doing:
  /// ```dart
  /// switch (sealedClass) {
  ///   case Subclass(:final field):
  ///     return ...;
  ///   case _:
  ///     return null;
  /// }
  /// ```

  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>(
    TResult? Function(KeyStoreEntry key)? $default,
  ) {
    final _that = this;
    switch (_that) {
      case _KeyRemovedEvent() when $default != null:
        return $default(_that.key);
      case _:
        return null;
    }
  }
}

/// @nodoc

class _KeyRemovedEvent implements KeyRemovedEvent {
  const _KeyRemovedEvent(this.key);

  @override
  final KeyStoreEntry key;

  /// Create a copy of KeyRemovedEvent
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  @pragma('vm:prefer-inline')
  _$KeyRemovedEventCopyWith<_KeyRemovedEvent> get copyWith =>
      __$KeyRemovedEventCopyWithImpl<_KeyRemovedEvent>(this, _$identity);

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _KeyRemovedEvent &&
            (identical(other.key, key) || other.key == key));
  }

  @override
  int get hashCode => Object.hash(runtimeType, key);

  @override
  String toString() {
    return 'KeyRemovedEvent(key: $key)';
  }
}

/// @nodoc
abstract mixin class _$KeyRemovedEventCopyWith<$Res>
    implements $KeyRemovedEventCopyWith<$Res> {
  factory _$KeyRemovedEventCopyWith(
          _KeyRemovedEvent value, $Res Function(_KeyRemovedEvent) _then) =
      __$KeyRemovedEventCopyWithImpl;
  @override
  @useResult
  $Res call({KeyStoreEntry key});

  @override
  $KeyStoreEntryCopyWith<$Res> get key;
}

/// @nodoc
class __$KeyRemovedEventCopyWithImpl<$Res>
    implements _$KeyRemovedEventCopyWith<$Res> {
  __$KeyRemovedEventCopyWithImpl(this._self, this._then);

  final _KeyRemovedEvent _self;
  final $Res Function(_KeyRemovedEvent) _then;

  /// Create a copy of KeyRemovedEvent
  /// with the given fields replaced by the non-null parameter values.
  @override
  @pragma('vm:prefer-inline')
  $Res call({
    Object? key = null,
  }) {
    return _then(_KeyRemovedEvent(
      null == key
          ? _self.key
          : key // ignore: cast_nullable_to_non_nullable
              as KeyStoreEntry,
    ));
  }

  /// Create a copy of KeyRemovedEvent
  /// with the given fields replaced by the non-null parameter values.
  @override
  @pragma('vm:prefer-inline')
  $KeyStoreEntryCopyWith<$Res> get key {
    return $KeyStoreEntryCopyWith<$Res>(_self.key, (value) {
      return _then(_self.copyWith(key: value));
    });
  }
}

// dart format on
