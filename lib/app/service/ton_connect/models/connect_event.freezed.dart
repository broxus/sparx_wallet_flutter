// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'connect_event.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
    'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#adding-getters-and-methods-to-our-models');

ConnectEvent _$ConnectEventFromJson(Map<String, dynamic> json) {
  switch (json['event']) {
    case 'connect':
      return ConnectEventSuccess.fromJson(json);
    case 'connect_error':
      return ConnectEventError.fromJson(json);

    default:
      throw CheckedFromJsonException(json, 'event', 'ConnectEvent',
          'Invalid union type "${json['event']}"!');
  }
}

/// @nodoc
mixin _$ConnectEvent {
  @optionalTypeArgs
  TResult when<TResult extends Object?>({
    required TResult Function(num id, ConnectEventSuccessPayload payload)
        success,
    required TResult Function() error,
  }) =>
      throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>({
    TResult? Function(num id, ConnectEventSuccessPayload payload)? success,
    TResult? Function()? error,
  }) =>
      throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>({
    TResult Function(num id, ConnectEventSuccessPayload payload)? success,
    TResult Function()? error,
    required TResult orElse(),
  }) =>
      throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult map<TResult extends Object?>({
    required TResult Function(ConnectEventSuccess value) success,
    required TResult Function(ConnectEventError value) error,
  }) =>
      throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult? mapOrNull<TResult extends Object?>({
    TResult? Function(ConnectEventSuccess value)? success,
    TResult? Function(ConnectEventError value)? error,
  }) =>
      throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>({
    TResult Function(ConnectEventSuccess value)? success,
    TResult Function(ConnectEventError value)? error,
    required TResult orElse(),
  }) =>
      throw _privateConstructorUsedError;

  /// Serializes this ConnectEvent to a JSON map.
  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $ConnectEventCopyWith<$Res> {
  factory $ConnectEventCopyWith(
          ConnectEvent value, $Res Function(ConnectEvent) then) =
      _$ConnectEventCopyWithImpl<$Res, ConnectEvent>;
}

/// @nodoc
class _$ConnectEventCopyWithImpl<$Res, $Val extends ConnectEvent>
    implements $ConnectEventCopyWith<$Res> {
  _$ConnectEventCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  /// Create a copy of ConnectEvent
  /// with the given fields replaced by the non-null parameter values.
}

/// @nodoc
abstract class _$$ConnectEventSuccessImplCopyWith<$Res> {
  factory _$$ConnectEventSuccessImplCopyWith(_$ConnectEventSuccessImpl value,
          $Res Function(_$ConnectEventSuccessImpl) then) =
      __$$ConnectEventSuccessImplCopyWithImpl<$Res>;
  @useResult
  $Res call({num id, ConnectEventSuccessPayload payload});

  $ConnectEventSuccessPayloadCopyWith<$Res> get payload;
}

/// @nodoc
class __$$ConnectEventSuccessImplCopyWithImpl<$Res>
    extends _$ConnectEventCopyWithImpl<$Res, _$ConnectEventSuccessImpl>
    implements _$$ConnectEventSuccessImplCopyWith<$Res> {
  __$$ConnectEventSuccessImplCopyWithImpl(_$ConnectEventSuccessImpl _value,
      $Res Function(_$ConnectEventSuccessImpl) _then)
      : super(_value, _then);

  /// Create a copy of ConnectEvent
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? id = null,
    Object? payload = null,
  }) {
    return _then(_$ConnectEventSuccessImpl(
      id: null == id
          ? _value.id
          : id // ignore: cast_nullable_to_non_nullable
              as num,
      payload: null == payload
          ? _value.payload
          : payload // ignore: cast_nullable_to_non_nullable
              as ConnectEventSuccessPayload,
    ));
  }

  /// Create a copy of ConnectEvent
  /// with the given fields replaced by the non-null parameter values.
  @override
  @pragma('vm:prefer-inline')
  $ConnectEventSuccessPayloadCopyWith<$Res> get payload {
    return $ConnectEventSuccessPayloadCopyWith<$Res>(_value.payload, (value) {
      return _then(_value.copyWith(payload: value));
    });
  }
}

/// @nodoc
@JsonSerializable()
class _$ConnectEventSuccessImpl implements ConnectEventSuccess {
  const _$ConnectEventSuccessImpl(
      {required this.id, required this.payload, final String? $type})
      : $type = $type ?? 'connect';

  factory _$ConnectEventSuccessImpl.fromJson(Map<String, dynamic> json) =>
      _$$ConnectEventSuccessImplFromJson(json);

  @override
  final num id;
  @override
  final ConnectEventSuccessPayload payload;

  @JsonKey(name: 'event')
  final String $type;

  @override
  String toString() {
    return 'ConnectEvent.success(id: $id, payload: $payload)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$ConnectEventSuccessImpl &&
            (identical(other.id, id) || other.id == id) &&
            (identical(other.payload, payload) || other.payload == payload));
  }

  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  int get hashCode => Object.hash(runtimeType, id, payload);

  /// Create a copy of ConnectEvent
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$ConnectEventSuccessImplCopyWith<_$ConnectEventSuccessImpl> get copyWith =>
      __$$ConnectEventSuccessImplCopyWithImpl<_$ConnectEventSuccessImpl>(
          this, _$identity);

  @override
  @optionalTypeArgs
  TResult when<TResult extends Object?>({
    required TResult Function(num id, ConnectEventSuccessPayload payload)
        success,
    required TResult Function() error,
  }) {
    return success(id, payload);
  }

  @override
  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>({
    TResult? Function(num id, ConnectEventSuccessPayload payload)? success,
    TResult? Function()? error,
  }) {
    return success?.call(id, payload);
  }

  @override
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>({
    TResult Function(num id, ConnectEventSuccessPayload payload)? success,
    TResult Function()? error,
    required TResult orElse(),
  }) {
    if (success != null) {
      return success(id, payload);
    }
    return orElse();
  }

  @override
  @optionalTypeArgs
  TResult map<TResult extends Object?>({
    required TResult Function(ConnectEventSuccess value) success,
    required TResult Function(ConnectEventError value) error,
  }) {
    return success(this);
  }

  @override
  @optionalTypeArgs
  TResult? mapOrNull<TResult extends Object?>({
    TResult? Function(ConnectEventSuccess value)? success,
    TResult? Function(ConnectEventError value)? error,
  }) {
    return success?.call(this);
  }

  @override
  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>({
    TResult Function(ConnectEventSuccess value)? success,
    TResult Function(ConnectEventError value)? error,
    required TResult orElse(),
  }) {
    if (success != null) {
      return success(this);
    }
    return orElse();
  }

  @override
  Map<String, dynamic> toJson() {
    return _$$ConnectEventSuccessImplToJson(
      this,
    );
  }
}

abstract class ConnectEventSuccess implements ConnectEvent {
  const factory ConnectEventSuccess(
          {required final num id,
          required final ConnectEventSuccessPayload payload}) =
      _$ConnectEventSuccessImpl;

  factory ConnectEventSuccess.fromJson(Map<String, dynamic> json) =
      _$ConnectEventSuccessImpl.fromJson;

  num get id;
  ConnectEventSuccessPayload get payload;

  /// Create a copy of ConnectEvent
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$ConnectEventSuccessImplCopyWith<_$ConnectEventSuccessImpl> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class _$$ConnectEventErrorImplCopyWith<$Res> {
  factory _$$ConnectEventErrorImplCopyWith(_$ConnectEventErrorImpl value,
          $Res Function(_$ConnectEventErrorImpl) then) =
      __$$ConnectEventErrorImplCopyWithImpl<$Res>;
}

/// @nodoc
class __$$ConnectEventErrorImplCopyWithImpl<$Res>
    extends _$ConnectEventCopyWithImpl<$Res, _$ConnectEventErrorImpl>
    implements _$$ConnectEventErrorImplCopyWith<$Res> {
  __$$ConnectEventErrorImplCopyWithImpl(_$ConnectEventErrorImpl _value,
      $Res Function(_$ConnectEventErrorImpl) _then)
      : super(_value, _then);

  /// Create a copy of ConnectEvent
  /// with the given fields replaced by the non-null parameter values.
}

/// @nodoc
@JsonSerializable()
class _$ConnectEventErrorImpl implements ConnectEventError {
  const _$ConnectEventErrorImpl({final String? $type})
      : $type = $type ?? 'connect_error';

  factory _$ConnectEventErrorImpl.fromJson(Map<String, dynamic> json) =>
      _$$ConnectEventErrorImplFromJson(json);

  @JsonKey(name: 'event')
  final String $type;

  @override
  String toString() {
    return 'ConnectEvent.error()';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType && other is _$ConnectEventErrorImpl);
  }

  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  int get hashCode => runtimeType.hashCode;

  @override
  @optionalTypeArgs
  TResult when<TResult extends Object?>({
    required TResult Function(num id, ConnectEventSuccessPayload payload)
        success,
    required TResult Function() error,
  }) {
    return error();
  }

  @override
  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>({
    TResult? Function(num id, ConnectEventSuccessPayload payload)? success,
    TResult? Function()? error,
  }) {
    return error?.call();
  }

  @override
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>({
    TResult Function(num id, ConnectEventSuccessPayload payload)? success,
    TResult Function()? error,
    required TResult orElse(),
  }) {
    if (error != null) {
      return error();
    }
    return orElse();
  }

  @override
  @optionalTypeArgs
  TResult map<TResult extends Object?>({
    required TResult Function(ConnectEventSuccess value) success,
    required TResult Function(ConnectEventError value) error,
  }) {
    return error(this);
  }

  @override
  @optionalTypeArgs
  TResult? mapOrNull<TResult extends Object?>({
    TResult? Function(ConnectEventSuccess value)? success,
    TResult? Function(ConnectEventError value)? error,
  }) {
    return error?.call(this);
  }

  @override
  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>({
    TResult Function(ConnectEventSuccess value)? success,
    TResult Function(ConnectEventError value)? error,
    required TResult orElse(),
  }) {
    if (error != null) {
      return error(this);
    }
    return orElse();
  }

  @override
  Map<String, dynamic> toJson() {
    return _$$ConnectEventErrorImplToJson(
      this,
    );
  }
}

abstract class ConnectEventError implements ConnectEvent {
  const factory ConnectEventError() = _$ConnectEventErrorImpl;

  factory ConnectEventError.fromJson(Map<String, dynamic> json) =
      _$ConnectEventErrorImpl.fromJson;
}
