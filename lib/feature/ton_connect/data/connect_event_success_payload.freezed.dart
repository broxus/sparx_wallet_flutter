// GENERATED CODE - DO NOT MODIFY BY HAND
// coverage:ignore-file
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'connect_event_success_payload.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// dart format off
T _$identity<T>(T value) => value;

/// @nodoc
mixin _$ConnectEventSuccessPayload {
  List<ConnectItemReply> get items;
  DeviceInfo get device;

  /// Create a copy of ConnectEventSuccessPayload
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @pragma('vm:prefer-inline')
  $ConnectEventSuccessPayloadCopyWith<ConnectEventSuccessPayload>
      get copyWith =>
          _$ConnectEventSuccessPayloadCopyWithImpl<ConnectEventSuccessPayload>(
              this as ConnectEventSuccessPayload, _$identity);

  /// Serializes this ConnectEventSuccessPayload to a JSON map.
  Map<String, dynamic> toJson();

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is ConnectEventSuccessPayload &&
            const DeepCollectionEquality().equals(other.items, items) &&
            (identical(other.device, device) || other.device == device));
  }

  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  int get hashCode => Object.hash(
      runtimeType, const DeepCollectionEquality().hash(items), device);

  @override
  String toString() {
    return 'ConnectEventSuccessPayload(items: $items, device: $device)';
  }
}

/// @nodoc
abstract mixin class $ConnectEventSuccessPayloadCopyWith<$Res> {
  factory $ConnectEventSuccessPayloadCopyWith(ConnectEventSuccessPayload value,
          $Res Function(ConnectEventSuccessPayload) _then) =
      _$ConnectEventSuccessPayloadCopyWithImpl;
  @useResult
  $Res call({List<ConnectItemReply> items, DeviceInfo device});

  $DeviceInfoCopyWith<$Res> get device;
}

/// @nodoc
class _$ConnectEventSuccessPayloadCopyWithImpl<$Res>
    implements $ConnectEventSuccessPayloadCopyWith<$Res> {
  _$ConnectEventSuccessPayloadCopyWithImpl(this._self, this._then);

  final ConnectEventSuccessPayload _self;
  final $Res Function(ConnectEventSuccessPayload) _then;

  /// Create a copy of ConnectEventSuccessPayload
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? items = null,
    Object? device = null,
  }) {
    return _then(_self.copyWith(
      items: null == items
          ? _self.items
          : items // ignore: cast_nullable_to_non_nullable
              as List<ConnectItemReply>,
      device: null == device
          ? _self.device
          : device // ignore: cast_nullable_to_non_nullable
              as DeviceInfo,
    ));
  }

  /// Create a copy of ConnectEventSuccessPayload
  /// with the given fields replaced by the non-null parameter values.
  @override
  @pragma('vm:prefer-inline')
  $DeviceInfoCopyWith<$Res> get device {
    return $DeviceInfoCopyWith<$Res>(_self.device, (value) {
      return _then(_self.copyWith(device: value));
    });
  }
}

/// Adds pattern-matching-related methods to [ConnectEventSuccessPayload].
extension ConnectEventSuccessPayloadPatterns on ConnectEventSuccessPayload {
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
    TResult Function(_ConnectEventSuccessPayload value)? $default, {
    required TResult orElse(),
  }) {
    final _that = this;
    switch (_that) {
      case _ConnectEventSuccessPayload() when $default != null:
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
    TResult Function(_ConnectEventSuccessPayload value) $default,
  ) {
    final _that = this;
    switch (_that) {
      case _ConnectEventSuccessPayload():
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
    TResult? Function(_ConnectEventSuccessPayload value)? $default,
  ) {
    final _that = this;
    switch (_that) {
      case _ConnectEventSuccessPayload() when $default != null:
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
    TResult Function(List<ConnectItemReply> items, DeviceInfo device)?
        $default, {
    required TResult orElse(),
  }) {
    final _that = this;
    switch (_that) {
      case _ConnectEventSuccessPayload() when $default != null:
        return $default(_that.items, _that.device);
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
    TResult Function(List<ConnectItemReply> items, DeviceInfo device) $default,
  ) {
    final _that = this;
    switch (_that) {
      case _ConnectEventSuccessPayload():
        return $default(_that.items, _that.device);
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
    TResult? Function(List<ConnectItemReply> items, DeviceInfo device)?
        $default,
  ) {
    final _that = this;
    switch (_that) {
      case _ConnectEventSuccessPayload() when $default != null:
        return $default(_that.items, _that.device);
      case _:
        return null;
    }
  }
}

/// @nodoc
@JsonSerializable()
class _ConnectEventSuccessPayload implements ConnectEventSuccessPayload {
  const _ConnectEventSuccessPayload(
      {required final List<ConnectItemReply> items, required this.device})
      : _items = items;
  factory _ConnectEventSuccessPayload.fromJson(Map<String, dynamic> json) =>
      _$ConnectEventSuccessPayloadFromJson(json);

  final List<ConnectItemReply> _items;
  @override
  List<ConnectItemReply> get items {
    if (_items is EqualUnmodifiableListView) return _items;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableListView(_items);
  }

  @override
  final DeviceInfo device;

  /// Create a copy of ConnectEventSuccessPayload
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  @pragma('vm:prefer-inline')
  _$ConnectEventSuccessPayloadCopyWith<_ConnectEventSuccessPayload>
      get copyWith => __$ConnectEventSuccessPayloadCopyWithImpl<
          _ConnectEventSuccessPayload>(this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$ConnectEventSuccessPayloadToJson(
      this,
    );
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _ConnectEventSuccessPayload &&
            const DeepCollectionEquality().equals(other._items, _items) &&
            (identical(other.device, device) || other.device == device));
  }

  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  int get hashCode => Object.hash(
      runtimeType, const DeepCollectionEquality().hash(_items), device);

  @override
  String toString() {
    return 'ConnectEventSuccessPayload(items: $items, device: $device)';
  }
}

/// @nodoc
abstract mixin class _$ConnectEventSuccessPayloadCopyWith<$Res>
    implements $ConnectEventSuccessPayloadCopyWith<$Res> {
  factory _$ConnectEventSuccessPayloadCopyWith(
          _ConnectEventSuccessPayload value,
          $Res Function(_ConnectEventSuccessPayload) _then) =
      __$ConnectEventSuccessPayloadCopyWithImpl;
  @override
  @useResult
  $Res call({List<ConnectItemReply> items, DeviceInfo device});

  @override
  $DeviceInfoCopyWith<$Res> get device;
}

/// @nodoc
class __$ConnectEventSuccessPayloadCopyWithImpl<$Res>
    implements _$ConnectEventSuccessPayloadCopyWith<$Res> {
  __$ConnectEventSuccessPayloadCopyWithImpl(this._self, this._then);

  final _ConnectEventSuccessPayload _self;
  final $Res Function(_ConnectEventSuccessPayload) _then;

  /// Create a copy of ConnectEventSuccessPayload
  /// with the given fields replaced by the non-null parameter values.
  @override
  @pragma('vm:prefer-inline')
  $Res call({
    Object? items = null,
    Object? device = null,
  }) {
    return _then(_ConnectEventSuccessPayload(
      items: null == items
          ? _self._items
          : items // ignore: cast_nullable_to_non_nullable
              as List<ConnectItemReply>,
      device: null == device
          ? _self.device
          : device // ignore: cast_nullable_to_non_nullable
              as DeviceInfo,
    ));
  }

  /// Create a copy of ConnectEventSuccessPayload
  /// with the given fields replaced by the non-null parameter values.
  @override
  @pragma('vm:prefer-inline')
  $DeviceInfoCopyWith<$Res> get device {
    return $DeviceInfoCopyWith<$Res>(_self.device, (value) {
      return _then(_self.copyWith(device: value));
    });
  }
}

// dart format on
