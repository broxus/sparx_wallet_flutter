// dart format width=80
// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'wallet_event.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// dart format off
T _$identity<T>(T value) => value;
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
  String get id;
  Object get payload;

  /// Create a copy of WalletEvent
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @pragma('vm:prefer-inline')
  $WalletEventCopyWith<WalletEvent> get copyWith =>
      _$WalletEventCopyWithImpl<WalletEvent>(this as WalletEvent, _$identity);

  /// Serializes this WalletEvent to a JSON map.
  Map<String, dynamic> toJson();

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is WalletEvent &&
            (identical(other.id, id) || other.id == id) &&
            const DeepCollectionEquality().equals(other.payload, payload));
  }

  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  int get hashCode => Object.hash(
      runtimeType, id, const DeepCollectionEquality().hash(payload));

  @override
  String toString() {
    return 'WalletEvent(id: $id, payload: $payload)';
  }
}

/// @nodoc
abstract mixin class $WalletEventCopyWith<$Res> {
  factory $WalletEventCopyWith(
          WalletEvent value, $Res Function(WalletEvent) _then) =
      _$WalletEventCopyWithImpl;
  @useResult
  $Res call({String id});
}

/// @nodoc
class _$WalletEventCopyWithImpl<$Res> implements $WalletEventCopyWith<$Res> {
  _$WalletEventCopyWithImpl(this._self, this._then);

  final WalletEvent _self;
  final $Res Function(WalletEvent) _then;

  /// Create a copy of WalletEvent
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? id = null,
  }) {
    return _then(_self.copyWith(
      id: null == id
          ? _self.id
          : id // ignore: cast_nullable_to_non_nullable
              as String,
    ));
  }
}

/// @nodoc
@JsonSerializable()
class ConnectEventSuccess implements WalletEvent {
  const ConnectEventSuccess(
      {required this.id, required this.payload, final String? $type})
      : $type = $type ?? 'connect';
  factory ConnectEventSuccess.fromJson(Map<String, dynamic> json) =>
      _$ConnectEventSuccessFromJson(json);

  @override
  final String id;
  @override
  final ConnectEventSuccessPayload payload;

  @JsonKey(name: 'event')
  final String $type;

  /// Create a copy of WalletEvent
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  @pragma('vm:prefer-inline')
  $ConnectEventSuccessCopyWith<ConnectEventSuccess> get copyWith =>
      _$ConnectEventSuccessCopyWithImpl<ConnectEventSuccess>(this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$ConnectEventSuccessToJson(
      this,
    );
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is ConnectEventSuccess &&
            (identical(other.id, id) || other.id == id) &&
            (identical(other.payload, payload) || other.payload == payload));
  }

  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  int get hashCode => Object.hash(runtimeType, id, payload);

  @override
  String toString() {
    return 'WalletEvent.connectSuccess(id: $id, payload: $payload)';
  }
}

/// @nodoc
abstract mixin class $ConnectEventSuccessCopyWith<$Res>
    implements $WalletEventCopyWith<$Res> {
  factory $ConnectEventSuccessCopyWith(
          ConnectEventSuccess value, $Res Function(ConnectEventSuccess) _then) =
      _$ConnectEventSuccessCopyWithImpl;
  @override
  @useResult
  $Res call({String id, ConnectEventSuccessPayload payload});

  $ConnectEventSuccessPayloadCopyWith<$Res> get payload;
}

/// @nodoc
class _$ConnectEventSuccessCopyWithImpl<$Res>
    implements $ConnectEventSuccessCopyWith<$Res> {
  _$ConnectEventSuccessCopyWithImpl(this._self, this._then);

  final ConnectEventSuccess _self;
  final $Res Function(ConnectEventSuccess) _then;

  /// Create a copy of WalletEvent
  /// with the given fields replaced by the non-null parameter values.
  @override
  @pragma('vm:prefer-inline')
  $Res call({
    Object? id = null,
    Object? payload = null,
  }) {
    return _then(ConnectEventSuccess(
      id: null == id
          ? _self.id
          : id // ignore: cast_nullable_to_non_nullable
              as String,
      payload: null == payload
          ? _self.payload
          : payload // ignore: cast_nullable_to_non_nullable
              as ConnectEventSuccessPayload,
    ));
  }

  /// Create a copy of WalletEvent
  /// with the given fields replaced by the non-null parameter values.
  @override
  @pragma('vm:prefer-inline')
  $ConnectEventSuccessPayloadCopyWith<$Res> get payload {
    return $ConnectEventSuccessPayloadCopyWith<$Res>(_self.payload, (value) {
      return _then(_self.copyWith(payload: value));
    });
  }
}

/// @nodoc
@JsonSerializable()
class ConnectEventError implements WalletEvent {
  const ConnectEventError(
      {required this.id, required this.payload, final String? $type})
      : $type = $type ?? 'connect_error';
  factory ConnectEventError.fromJson(Map<String, dynamic> json) =>
      _$ConnectEventErrorFromJson(json);

  @override
  final String id;
  @override
  final TonConnectError payload;

  @JsonKey(name: 'event')
  final String $type;

  /// Create a copy of WalletEvent
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  @pragma('vm:prefer-inline')
  $ConnectEventErrorCopyWith<ConnectEventError> get copyWith =>
      _$ConnectEventErrorCopyWithImpl<ConnectEventError>(this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$ConnectEventErrorToJson(
      this,
    );
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is ConnectEventError &&
            (identical(other.id, id) || other.id == id) &&
            (identical(other.payload, payload) || other.payload == payload));
  }

  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  int get hashCode => Object.hash(runtimeType, id, payload);

  @override
  String toString() {
    return 'WalletEvent.connectError(id: $id, payload: $payload)';
  }
}

/// @nodoc
abstract mixin class $ConnectEventErrorCopyWith<$Res>
    implements $WalletEventCopyWith<$Res> {
  factory $ConnectEventErrorCopyWith(
          ConnectEventError value, $Res Function(ConnectEventError) _then) =
      _$ConnectEventErrorCopyWithImpl;
  @override
  @useResult
  $Res call({String id, TonConnectError payload});

  $TonConnectErrorCopyWith<$Res> get payload;
}

/// @nodoc
class _$ConnectEventErrorCopyWithImpl<$Res>
    implements $ConnectEventErrorCopyWith<$Res> {
  _$ConnectEventErrorCopyWithImpl(this._self, this._then);

  final ConnectEventError _self;
  final $Res Function(ConnectEventError) _then;

  /// Create a copy of WalletEvent
  /// with the given fields replaced by the non-null parameter values.
  @override
  @pragma('vm:prefer-inline')
  $Res call({
    Object? id = null,
    Object? payload = null,
  }) {
    return _then(ConnectEventError(
      id: null == id
          ? _self.id
          : id // ignore: cast_nullable_to_non_nullable
              as String,
      payload: null == payload
          ? _self.payload
          : payload // ignore: cast_nullable_to_non_nullable
              as TonConnectError,
    ));
  }

  /// Create a copy of WalletEvent
  /// with the given fields replaced by the non-null parameter values.
  @override
  @pragma('vm:prefer-inline')
  $TonConnectErrorCopyWith<$Res> get payload {
    return $TonConnectErrorCopyWith<$Res>(_self.payload, (value) {
      return _then(_self.copyWith(payload: value));
    });
  }
}

/// @nodoc
@JsonSerializable()
class DisconnectEvent implements WalletEvent {
  const DisconnectEvent(
      {required this.id,
      final Map<String, dynamic> payload = const {},
      final String? $type})
      : _payload = payload,
        $type = $type ?? 'disconnect';
  factory DisconnectEvent.fromJson(Map<String, dynamic> json) =>
      _$DisconnectEventFromJson(json);

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

  /// Create a copy of WalletEvent
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  @pragma('vm:prefer-inline')
  $DisconnectEventCopyWith<DisconnectEvent> get copyWith =>
      _$DisconnectEventCopyWithImpl<DisconnectEvent>(this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$DisconnectEventToJson(
      this,
    );
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is DisconnectEvent &&
            (identical(other.id, id) || other.id == id) &&
            const DeepCollectionEquality().equals(other._payload, _payload));
  }

  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  int get hashCode => Object.hash(
      runtimeType, id, const DeepCollectionEquality().hash(_payload));

  @override
  String toString() {
    return 'WalletEvent.disconnect(id: $id, payload: $payload)';
  }
}

/// @nodoc
abstract mixin class $DisconnectEventCopyWith<$Res>
    implements $WalletEventCopyWith<$Res> {
  factory $DisconnectEventCopyWith(
          DisconnectEvent value, $Res Function(DisconnectEvent) _then) =
      _$DisconnectEventCopyWithImpl;
  @override
  @useResult
  $Res call({String id, Map<String, dynamic> payload});
}

/// @nodoc
class _$DisconnectEventCopyWithImpl<$Res>
    implements $DisconnectEventCopyWith<$Res> {
  _$DisconnectEventCopyWithImpl(this._self, this._then);

  final DisconnectEvent _self;
  final $Res Function(DisconnectEvent) _then;

  /// Create a copy of WalletEvent
  /// with the given fields replaced by the non-null parameter values.
  @override
  @pragma('vm:prefer-inline')
  $Res call({
    Object? id = null,
    Object? payload = null,
  }) {
    return _then(DisconnectEvent(
      id: null == id
          ? _self.id
          : id // ignore: cast_nullable_to_non_nullable
              as String,
      payload: null == payload
          ? _self._payload
          : payload // ignore: cast_nullable_to_non_nullable
              as Map<String, dynamic>,
    ));
  }
}

// dart format on
