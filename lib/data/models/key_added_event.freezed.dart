// dart format width=80
// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'key_added_event.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// dart format off
T _$identity<T>(T value) => value;

/// @nodoc
mixin _$KeyAddedEvent {
  KeyStoreEntry get key;

  /// Create a copy of KeyAddedEvent
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @pragma('vm:prefer-inline')
  $KeyAddedEventCopyWith<KeyAddedEvent> get copyWith =>
      _$KeyAddedEventCopyWithImpl<KeyAddedEvent>(
          this as KeyAddedEvent, _$identity);

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is KeyAddedEvent &&
            (identical(other.key, key) || other.key == key));
  }

  @override
  int get hashCode => Object.hash(runtimeType, key);

  @override
  String toString() {
    return 'KeyAddedEvent(key: $key)';
  }
}

/// @nodoc
abstract mixin class $KeyAddedEventCopyWith<$Res> {
  factory $KeyAddedEventCopyWith(
          KeyAddedEvent value, $Res Function(KeyAddedEvent) _then) =
      _$KeyAddedEventCopyWithImpl;
  @useResult
  $Res call({KeyStoreEntry key});

  $KeyStoreEntryCopyWith<$Res> get key;
}

/// @nodoc
class _$KeyAddedEventCopyWithImpl<$Res>
    implements $KeyAddedEventCopyWith<$Res> {
  _$KeyAddedEventCopyWithImpl(this._self, this._then);

  final KeyAddedEvent _self;
  final $Res Function(KeyAddedEvent) _then;

  /// Create a copy of KeyAddedEvent
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

  /// Create a copy of KeyAddedEvent
  /// with the given fields replaced by the non-null parameter values.
  @override
  @pragma('vm:prefer-inline')
  $KeyStoreEntryCopyWith<$Res> get key {
    return $KeyStoreEntryCopyWith<$Res>(_self.key, (value) {
      return _then(_self.copyWith(key: value));
    });
  }
}

/// @nodoc

class _KeyAddedEvent implements KeyAddedEvent {
  const _KeyAddedEvent(this.key);

  @override
  final KeyStoreEntry key;

  /// Create a copy of KeyAddedEvent
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  @pragma('vm:prefer-inline')
  _$KeyAddedEventCopyWith<_KeyAddedEvent> get copyWith =>
      __$KeyAddedEventCopyWithImpl<_KeyAddedEvent>(this, _$identity);

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _KeyAddedEvent &&
            (identical(other.key, key) || other.key == key));
  }

  @override
  int get hashCode => Object.hash(runtimeType, key);

  @override
  String toString() {
    return 'KeyAddedEvent(key: $key)';
  }
}

/// @nodoc
abstract mixin class _$KeyAddedEventCopyWith<$Res>
    implements $KeyAddedEventCopyWith<$Res> {
  factory _$KeyAddedEventCopyWith(
          _KeyAddedEvent value, $Res Function(_KeyAddedEvent) _then) =
      __$KeyAddedEventCopyWithImpl;
  @override
  @useResult
  $Res call({KeyStoreEntry key});

  @override
  $KeyStoreEntryCopyWith<$Res> get key;
}

/// @nodoc
class __$KeyAddedEventCopyWithImpl<$Res>
    implements _$KeyAddedEventCopyWith<$Res> {
  __$KeyAddedEventCopyWithImpl(this._self, this._then);

  final _KeyAddedEvent _self;
  final $Res Function(_KeyAddedEvent) _then;

  /// Create a copy of KeyAddedEvent
  /// with the given fields replaced by the non-null parameter values.
  @override
  @pragma('vm:prefer-inline')
  $Res call({
    Object? key = null,
  }) {
    return _then(_KeyAddedEvent(
      null == key
          ? _self.key
          : key // ignore: cast_nullable_to_non_nullable
              as KeyStoreEntry,
    ));
  }

  /// Create a copy of KeyAddedEvent
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
