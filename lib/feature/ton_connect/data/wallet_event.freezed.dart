// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'wallet_event.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
    'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#adding-getters-and-methods-to-our-models');

WalletEvent _$WalletEventFromJson(Map<String, dynamic> json) {
  switch (json['event']) {
    case 'connect':
      return ConnectEventSuccess.fromJson(json);
    case 'connect_error':
      return ConnectEventError.fromJson(json);
    case 'disconnect':
      return DisconnectEvent.fromJson(json);

    default:
      throw CheckedFromJsonException(json, 'event', 'WalletEvent',
          'Invalid union type "${json['event']}"!');
  }
}

/// @nodoc
mixin _$WalletEvent {
  String get id => throw _privateConstructorUsedError;
  Object get payload => throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult when<TResult extends Object?>({
    required TResult Function(String id, ConnectEventSuccessPayload payload)
        connectSuccess,
    required TResult Function(String id, TonConnectError payload) connectError,
    required TResult Function(String id, Map<String, dynamic> payload)
        disconnect,
  }) =>
      throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>({
    TResult? Function(String id, ConnectEventSuccessPayload payload)?
        connectSuccess,
    TResult? Function(String id, TonConnectError payload)? connectError,
    TResult? Function(String id, Map<String, dynamic> payload)? disconnect,
  }) =>
      throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>({
    TResult Function(String id, ConnectEventSuccessPayload payload)?
        connectSuccess,
    TResult Function(String id, TonConnectError payload)? connectError,
    TResult Function(String id, Map<String, dynamic> payload)? disconnect,
    required TResult orElse(),
  }) =>
      throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult map<TResult extends Object?>({
    required TResult Function(ConnectEventSuccess value) connectSuccess,
    required TResult Function(ConnectEventError value) connectError,
    required TResult Function(DisconnectEvent value) disconnect,
  }) =>
      throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult? mapOrNull<TResult extends Object?>({
    TResult? Function(ConnectEventSuccess value)? connectSuccess,
    TResult? Function(ConnectEventError value)? connectError,
    TResult? Function(DisconnectEvent value)? disconnect,
  }) =>
      throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>({
    TResult Function(ConnectEventSuccess value)? connectSuccess,
    TResult Function(ConnectEventError value)? connectError,
    TResult Function(DisconnectEvent value)? disconnect,
    required TResult orElse(),
  }) =>
      throw _privateConstructorUsedError;

  /// Serializes this WalletEvent to a JSON map.
  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;

  /// Create a copy of WalletEvent
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  $WalletEventCopyWith<WalletEvent> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $WalletEventCopyWith<$Res> {
  factory $WalletEventCopyWith(
          WalletEvent value, $Res Function(WalletEvent) then) =
      _$WalletEventCopyWithImpl<$Res, WalletEvent>;
  @useResult
  $Res call({String id});
}

/// @nodoc
class _$WalletEventCopyWithImpl<$Res, $Val extends WalletEvent>
    implements $WalletEventCopyWith<$Res> {
  _$WalletEventCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  /// Create a copy of WalletEvent
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? id = null,
  }) {
    return _then(_value.copyWith(
      id: null == id
          ? _value.id
          : id // ignore: cast_nullable_to_non_nullable
              as String,
    ) as $Val);
  }
}

/// @nodoc
abstract class _$$ConnectEventSuccessImplCopyWith<$Res>
    implements $WalletEventCopyWith<$Res> {
  factory _$$ConnectEventSuccessImplCopyWith(_$ConnectEventSuccessImpl value,
          $Res Function(_$ConnectEventSuccessImpl) then) =
      __$$ConnectEventSuccessImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call({String id, ConnectEventSuccessPayload payload});

  $ConnectEventSuccessPayloadCopyWith<$Res> get payload;
}

/// @nodoc
class __$$ConnectEventSuccessImplCopyWithImpl<$Res>
    extends _$WalletEventCopyWithImpl<$Res, _$ConnectEventSuccessImpl>
    implements _$$ConnectEventSuccessImplCopyWith<$Res> {
  __$$ConnectEventSuccessImplCopyWithImpl(_$ConnectEventSuccessImpl _value,
      $Res Function(_$ConnectEventSuccessImpl) _then)
      : super(_value, _then);

  /// Create a copy of WalletEvent
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
              as String,
      payload: null == payload
          ? _value.payload
          : payload // ignore: cast_nullable_to_non_nullable
              as ConnectEventSuccessPayload,
    ));
  }

  /// Create a copy of WalletEvent
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
  final String id;
  @override
  final ConnectEventSuccessPayload payload;

  @JsonKey(name: 'event')
  final String $type;

  @override
  String toString() {
    return 'WalletEvent.connectSuccess(id: $id, payload: $payload)';
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

  /// Create a copy of WalletEvent
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
    required TResult Function(String id, ConnectEventSuccessPayload payload)
        connectSuccess,
    required TResult Function(String id, TonConnectError payload) connectError,
    required TResult Function(String id, Map<String, dynamic> payload)
        disconnect,
  }) {
    return connectSuccess(id, payload);
  }

  @override
  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>({
    TResult? Function(String id, ConnectEventSuccessPayload payload)?
        connectSuccess,
    TResult? Function(String id, TonConnectError payload)? connectError,
    TResult? Function(String id, Map<String, dynamic> payload)? disconnect,
  }) {
    return connectSuccess?.call(id, payload);
  }

  @override
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>({
    TResult Function(String id, ConnectEventSuccessPayload payload)?
        connectSuccess,
    TResult Function(String id, TonConnectError payload)? connectError,
    TResult Function(String id, Map<String, dynamic> payload)? disconnect,
    required TResult orElse(),
  }) {
    if (connectSuccess != null) {
      return connectSuccess(id, payload);
    }
    return orElse();
  }

  @override
  @optionalTypeArgs
  TResult map<TResult extends Object?>({
    required TResult Function(ConnectEventSuccess value) connectSuccess,
    required TResult Function(ConnectEventError value) connectError,
    required TResult Function(DisconnectEvent value) disconnect,
  }) {
    return connectSuccess(this);
  }

  @override
  @optionalTypeArgs
  TResult? mapOrNull<TResult extends Object?>({
    TResult? Function(ConnectEventSuccess value)? connectSuccess,
    TResult? Function(ConnectEventError value)? connectError,
    TResult? Function(DisconnectEvent value)? disconnect,
  }) {
    return connectSuccess?.call(this);
  }

  @override
  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>({
    TResult Function(ConnectEventSuccess value)? connectSuccess,
    TResult Function(ConnectEventError value)? connectError,
    TResult Function(DisconnectEvent value)? disconnect,
    required TResult orElse(),
  }) {
    if (connectSuccess != null) {
      return connectSuccess(this);
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

abstract class ConnectEventSuccess implements WalletEvent {
  const factory ConnectEventSuccess(
          {required final String id,
          required final ConnectEventSuccessPayload payload}) =
      _$ConnectEventSuccessImpl;

  factory ConnectEventSuccess.fromJson(Map<String, dynamic> json) =
      _$ConnectEventSuccessImpl.fromJson;

  @override
  String get id;
  @override
  ConnectEventSuccessPayload get payload;

  /// Create a copy of WalletEvent
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$ConnectEventSuccessImplCopyWith<_$ConnectEventSuccessImpl> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class _$$ConnectEventErrorImplCopyWith<$Res>
    implements $WalletEventCopyWith<$Res> {
  factory _$$ConnectEventErrorImplCopyWith(_$ConnectEventErrorImpl value,
          $Res Function(_$ConnectEventErrorImpl) then) =
      __$$ConnectEventErrorImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call({String id, TonConnectError payload});

  $TonConnectErrorCopyWith<$Res> get payload;
}

/// @nodoc
class __$$ConnectEventErrorImplCopyWithImpl<$Res>
    extends _$WalletEventCopyWithImpl<$Res, _$ConnectEventErrorImpl>
    implements _$$ConnectEventErrorImplCopyWith<$Res> {
  __$$ConnectEventErrorImplCopyWithImpl(_$ConnectEventErrorImpl _value,
      $Res Function(_$ConnectEventErrorImpl) _then)
      : super(_value, _then);

  /// Create a copy of WalletEvent
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? id = null,
    Object? payload = null,
  }) {
    return _then(_$ConnectEventErrorImpl(
      id: null == id
          ? _value.id
          : id // ignore: cast_nullable_to_non_nullable
              as String,
      payload: null == payload
          ? _value.payload
          : payload // ignore: cast_nullable_to_non_nullable
              as TonConnectError,
    ));
  }

  /// Create a copy of WalletEvent
  /// with the given fields replaced by the non-null parameter values.
  @override
  @pragma('vm:prefer-inline')
  $TonConnectErrorCopyWith<$Res> get payload {
    return $TonConnectErrorCopyWith<$Res>(_value.payload, (value) {
      return _then(_value.copyWith(payload: value));
    });
  }
}

/// @nodoc
@JsonSerializable()
class _$ConnectEventErrorImpl implements ConnectEventError {
  const _$ConnectEventErrorImpl(
      {required this.id, required this.payload, final String? $type})
      : $type = $type ?? 'connect_error';

  factory _$ConnectEventErrorImpl.fromJson(Map<String, dynamic> json) =>
      _$$ConnectEventErrorImplFromJson(json);

  @override
  final String id;
  @override
  final TonConnectError payload;

  @JsonKey(name: 'event')
  final String $type;

  @override
  String toString() {
    return 'WalletEvent.connectError(id: $id, payload: $payload)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$ConnectEventErrorImpl &&
            (identical(other.id, id) || other.id == id) &&
            (identical(other.payload, payload) || other.payload == payload));
  }

  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  int get hashCode => Object.hash(runtimeType, id, payload);

  /// Create a copy of WalletEvent
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$ConnectEventErrorImplCopyWith<_$ConnectEventErrorImpl> get copyWith =>
      __$$ConnectEventErrorImplCopyWithImpl<_$ConnectEventErrorImpl>(
          this, _$identity);

  @override
  @optionalTypeArgs
  TResult when<TResult extends Object?>({
    required TResult Function(String id, ConnectEventSuccessPayload payload)
        connectSuccess,
    required TResult Function(String id, TonConnectError payload) connectError,
    required TResult Function(String id, Map<String, dynamic> payload)
        disconnect,
  }) {
    return connectError(id, payload);
  }

  @override
  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>({
    TResult? Function(String id, ConnectEventSuccessPayload payload)?
        connectSuccess,
    TResult? Function(String id, TonConnectError payload)? connectError,
    TResult? Function(String id, Map<String, dynamic> payload)? disconnect,
  }) {
    return connectError?.call(id, payload);
  }

  @override
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>({
    TResult Function(String id, ConnectEventSuccessPayload payload)?
        connectSuccess,
    TResult Function(String id, TonConnectError payload)? connectError,
    TResult Function(String id, Map<String, dynamic> payload)? disconnect,
    required TResult orElse(),
  }) {
    if (connectError != null) {
      return connectError(id, payload);
    }
    return orElse();
  }

  @override
  @optionalTypeArgs
  TResult map<TResult extends Object?>({
    required TResult Function(ConnectEventSuccess value) connectSuccess,
    required TResult Function(ConnectEventError value) connectError,
    required TResult Function(DisconnectEvent value) disconnect,
  }) {
    return connectError(this);
  }

  @override
  @optionalTypeArgs
  TResult? mapOrNull<TResult extends Object?>({
    TResult? Function(ConnectEventSuccess value)? connectSuccess,
    TResult? Function(ConnectEventError value)? connectError,
    TResult? Function(DisconnectEvent value)? disconnect,
  }) {
    return connectError?.call(this);
  }

  @override
  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>({
    TResult Function(ConnectEventSuccess value)? connectSuccess,
    TResult Function(ConnectEventError value)? connectError,
    TResult Function(DisconnectEvent value)? disconnect,
    required TResult orElse(),
  }) {
    if (connectError != null) {
      return connectError(this);
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

abstract class ConnectEventError implements WalletEvent {
  const factory ConnectEventError(
      {required final String id,
      required final TonConnectError payload}) = _$ConnectEventErrorImpl;

  factory ConnectEventError.fromJson(Map<String, dynamic> json) =
      _$ConnectEventErrorImpl.fromJson;

  @override
  String get id;
  @override
  TonConnectError get payload;

  /// Create a copy of WalletEvent
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$ConnectEventErrorImplCopyWith<_$ConnectEventErrorImpl> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class _$$DisconnectEventImplCopyWith<$Res>
    implements $WalletEventCopyWith<$Res> {
  factory _$$DisconnectEventImplCopyWith(_$DisconnectEventImpl value,
          $Res Function(_$DisconnectEventImpl) then) =
      __$$DisconnectEventImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call({String id, Map<String, dynamic> payload});
}

/// @nodoc
class __$$DisconnectEventImplCopyWithImpl<$Res>
    extends _$WalletEventCopyWithImpl<$Res, _$DisconnectEventImpl>
    implements _$$DisconnectEventImplCopyWith<$Res> {
  __$$DisconnectEventImplCopyWithImpl(
      _$DisconnectEventImpl _value, $Res Function(_$DisconnectEventImpl) _then)
      : super(_value, _then);

  /// Create a copy of WalletEvent
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? id = null,
    Object? payload = null,
  }) {
    return _then(_$DisconnectEventImpl(
      id: null == id
          ? _value.id
          : id // ignore: cast_nullable_to_non_nullable
              as String,
      payload: null == payload
          ? _value._payload
          : payload // ignore: cast_nullable_to_non_nullable
              as Map<String, dynamic>,
    ));
  }
}

/// @nodoc
@JsonSerializable()
class _$DisconnectEventImpl implements DisconnectEvent {
  const _$DisconnectEventImpl(
      {required this.id,
      final Map<String, dynamic> payload = const {},
      final String? $type})
      : _payload = payload,
        $type = $type ?? 'disconnect';

  factory _$DisconnectEventImpl.fromJson(Map<String, dynamic> json) =>
      _$$DisconnectEventImplFromJson(json);

  @override
  final String id;
  final Map<String, dynamic> _payload;
  @override
  @JsonKey()
  Map<String, dynamic> get payload {
    if (_payload is EqualUnmodifiableMapView) return _payload;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableMapView(_payload);
  }

  @JsonKey(name: 'event')
  final String $type;

  @override
  String toString() {
    return 'WalletEvent.disconnect(id: $id, payload: $payload)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$DisconnectEventImpl &&
            (identical(other.id, id) || other.id == id) &&
            const DeepCollectionEquality().equals(other._payload, _payload));
  }

  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  int get hashCode => Object.hash(
      runtimeType, id, const DeepCollectionEquality().hash(_payload));

  /// Create a copy of WalletEvent
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$DisconnectEventImplCopyWith<_$DisconnectEventImpl> get copyWith =>
      __$$DisconnectEventImplCopyWithImpl<_$DisconnectEventImpl>(
          this, _$identity);

  @override
  @optionalTypeArgs
  TResult when<TResult extends Object?>({
    required TResult Function(String id, ConnectEventSuccessPayload payload)
        connectSuccess,
    required TResult Function(String id, TonConnectError payload) connectError,
    required TResult Function(String id, Map<String, dynamic> payload)
        disconnect,
  }) {
    return disconnect(id, payload);
  }

  @override
  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>({
    TResult? Function(String id, ConnectEventSuccessPayload payload)?
        connectSuccess,
    TResult? Function(String id, TonConnectError payload)? connectError,
    TResult? Function(String id, Map<String, dynamic> payload)? disconnect,
  }) {
    return disconnect?.call(id, payload);
  }

  @override
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>({
    TResult Function(String id, ConnectEventSuccessPayload payload)?
        connectSuccess,
    TResult Function(String id, TonConnectError payload)? connectError,
    TResult Function(String id, Map<String, dynamic> payload)? disconnect,
    required TResult orElse(),
  }) {
    if (disconnect != null) {
      return disconnect(id, payload);
    }
    return orElse();
  }

  @override
  @optionalTypeArgs
  TResult map<TResult extends Object?>({
    required TResult Function(ConnectEventSuccess value) connectSuccess,
    required TResult Function(ConnectEventError value) connectError,
    required TResult Function(DisconnectEvent value) disconnect,
  }) {
    return disconnect(this);
  }

  @override
  @optionalTypeArgs
  TResult? mapOrNull<TResult extends Object?>({
    TResult? Function(ConnectEventSuccess value)? connectSuccess,
    TResult? Function(ConnectEventError value)? connectError,
    TResult? Function(DisconnectEvent value)? disconnect,
  }) {
    return disconnect?.call(this);
  }

  @override
  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>({
    TResult Function(ConnectEventSuccess value)? connectSuccess,
    TResult Function(ConnectEventError value)? connectError,
    TResult Function(DisconnectEvent value)? disconnect,
    required TResult orElse(),
  }) {
    if (disconnect != null) {
      return disconnect(this);
    }
    return orElse();
  }

  @override
  Map<String, dynamic> toJson() {
    return _$$DisconnectEventImplToJson(
      this,
    );
  }
}

abstract class DisconnectEvent implements WalletEvent {
  const factory DisconnectEvent(
      {required final String id,
      final Map<String, dynamic> payload}) = _$DisconnectEventImpl;

  factory DisconnectEvent.fromJson(Map<String, dynamic> json) =
      _$DisconnectEventImpl.fromJson;

  @override
  String get id;
  @override
  Map<String, dynamic> get payload;

  /// Create a copy of WalletEvent
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$DisconnectEventImplCopyWith<_$DisconnectEventImpl> get copyWith =>
      throw _privateConstructorUsedError;
}
