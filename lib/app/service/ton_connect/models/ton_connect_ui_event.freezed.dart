// dart format width=80
// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'ton_connect_ui_event.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// dart format off
T _$identity<T>(T value) => value;

/// @nodoc
mixin _$TonConnectUiEvent {
  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType && other is TonConnectUiEvent);
  }

  @override
  int get hashCode => runtimeType.hashCode;

  @override
  String toString() {
    return 'TonConnectUiEvent()';
  }
}

/// @nodoc
class $TonConnectUiEventCopyWith<$Res> {
  $TonConnectUiEventCopyWith(
      TonConnectUiEvent _, $Res Function(TonConnectUiEvent) __);
}

/// @nodoc

class TonConnectUiEventError implements TonConnectUiEvent {
  TonConnectUiEventError({required this.message});

  final String message;

  /// Create a copy of TonConnectUiEvent
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @pragma('vm:prefer-inline')
  $TonConnectUiEventErrorCopyWith<TonConnectUiEventError> get copyWith =>
      _$TonConnectUiEventErrorCopyWithImpl<TonConnectUiEventError>(
          this, _$identity);

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is TonConnectUiEventError &&
            (identical(other.message, message) || other.message == message));
  }

  @override
  int get hashCode => Object.hash(runtimeType, message);

  @override
  String toString() {
    return 'TonConnectUiEvent.error(message: $message)';
  }
}

/// @nodoc
abstract mixin class $TonConnectUiEventErrorCopyWith<$Res>
    implements $TonConnectUiEventCopyWith<$Res> {
  factory $TonConnectUiEventErrorCopyWith(TonConnectUiEventError value,
          $Res Function(TonConnectUiEventError) _then) =
      _$TonConnectUiEventErrorCopyWithImpl;
  @useResult
  $Res call({String message});
}

/// @nodoc
class _$TonConnectUiEventErrorCopyWithImpl<$Res>
    implements $TonConnectUiEventErrorCopyWith<$Res> {
  _$TonConnectUiEventErrorCopyWithImpl(this._self, this._then);

  final TonConnectUiEventError _self;
  final $Res Function(TonConnectUiEventError) _then;

  /// Create a copy of TonConnectUiEvent
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  $Res call({
    Object? message = null,
  }) {
    return _then(TonConnectUiEventError(
      message: null == message
          ? _self.message
          : message // ignore: cast_nullable_to_non_nullable
              as String,
    ));
  }
}

/// @nodoc

class TonConnectUiEventConnect implements TonConnectUiEvent {
  TonConnectUiEventConnect(
      {required this.request, required this.manifest, required this.completer});

  final ConnectRequest request;
  final DappManifest manifest;
  final Completer<(KeyAccount, List<ConnectItemReply>)?> completer;

  /// Create a copy of TonConnectUiEvent
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @pragma('vm:prefer-inline')
  $TonConnectUiEventConnectCopyWith<TonConnectUiEventConnect> get copyWith =>
      _$TonConnectUiEventConnectCopyWithImpl<TonConnectUiEventConnect>(
          this, _$identity);

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is TonConnectUiEventConnect &&
            (identical(other.request, request) || other.request == request) &&
            (identical(other.manifest, manifest) ||
                other.manifest == manifest) &&
            (identical(other.completer, completer) ||
                other.completer == completer));
  }

  @override
  int get hashCode => Object.hash(runtimeType, request, manifest, completer);

  @override
  String toString() {
    return 'TonConnectUiEvent.connect(request: $request, manifest: $manifest, completer: $completer)';
  }
}

/// @nodoc
abstract mixin class $TonConnectUiEventConnectCopyWith<$Res>
    implements $TonConnectUiEventCopyWith<$Res> {
  factory $TonConnectUiEventConnectCopyWith(TonConnectUiEventConnect value,
          $Res Function(TonConnectUiEventConnect) _then) =
      _$TonConnectUiEventConnectCopyWithImpl;
  @useResult
  $Res call(
      {ConnectRequest request,
      DappManifest manifest,
      Completer<(KeyAccount, List<ConnectItemReply>)?> completer});

  $ConnectRequestCopyWith<$Res> get request;
  $DappManifestCopyWith<$Res> get manifest;
}

/// @nodoc
class _$TonConnectUiEventConnectCopyWithImpl<$Res>
    implements $TonConnectUiEventConnectCopyWith<$Res> {
  _$TonConnectUiEventConnectCopyWithImpl(this._self, this._then);

  final TonConnectUiEventConnect _self;
  final $Res Function(TonConnectUiEventConnect) _then;

  /// Create a copy of TonConnectUiEvent
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  $Res call({
    Object? request = null,
    Object? manifest = null,
    Object? completer = null,
  }) {
    return _then(TonConnectUiEventConnect(
      request: null == request
          ? _self.request
          : request // ignore: cast_nullable_to_non_nullable
              as ConnectRequest,
      manifest: null == manifest
          ? _self.manifest
          : manifest // ignore: cast_nullable_to_non_nullable
              as DappManifest,
      completer: null == completer
          ? _self.completer
          : completer // ignore: cast_nullable_to_non_nullable
              as Completer<(KeyAccount, List<ConnectItemReply>)?>,
    ));
  }

  /// Create a copy of TonConnectUiEvent
  /// with the given fields replaced by the non-null parameter values.
  @override
  @pragma('vm:prefer-inline')
  $ConnectRequestCopyWith<$Res> get request {
    return $ConnectRequestCopyWith<$Res>(_self.request, (value) {
      return _then(_self.copyWith(request: value));
    });
  }

  /// Create a copy of TonConnectUiEvent
  /// with the given fields replaced by the non-null parameter values.
  @override
  @pragma('vm:prefer-inline')
  $DappManifestCopyWith<$Res> get manifest {
    return $DappManifestCopyWith<$Res>(_self.manifest, (value) {
      return _then(_self.copyWith(manifest: value));
    });
  }
}

/// @nodoc

class TonConnectUiEventSendTransaction implements TonConnectUiEvent {
  TonConnectUiEventSendTransaction(
      {required this.connection,
      required this.payload,
      required this.completer});

  final TonAppConnection connection;
  final TransactionPayload payload;
  final Completer<SignedMessage?> completer;

  /// Create a copy of TonConnectUiEvent
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @pragma('vm:prefer-inline')
  $TonConnectUiEventSendTransactionCopyWith<TonConnectUiEventSendTransaction>
      get copyWith => _$TonConnectUiEventSendTransactionCopyWithImpl<
          TonConnectUiEventSendTransaction>(this, _$identity);

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is TonConnectUiEventSendTransaction &&
            (identical(other.connection, connection) ||
                other.connection == connection) &&
            (identical(other.payload, payload) || other.payload == payload) &&
            (identical(other.completer, completer) ||
                other.completer == completer));
  }

  @override
  int get hashCode => Object.hash(runtimeType, connection, payload, completer);

  @override
  String toString() {
    return 'TonConnectUiEvent.sendTransaction(connection: $connection, payload: $payload, completer: $completer)';
  }
}

/// @nodoc
abstract mixin class $TonConnectUiEventSendTransactionCopyWith<$Res>
    implements $TonConnectUiEventCopyWith<$Res> {
  factory $TonConnectUiEventSendTransactionCopyWith(
          TonConnectUiEventSendTransaction value,
          $Res Function(TonConnectUiEventSendTransaction) _then) =
      _$TonConnectUiEventSendTransactionCopyWithImpl;
  @useResult
  $Res call(
      {TonAppConnection connection,
      TransactionPayload payload,
      Completer<SignedMessage?> completer});

  $TonAppConnectionCopyWith<$Res> get connection;
  $TransactionPayloadCopyWith<$Res> get payload;
}

/// @nodoc
class _$TonConnectUiEventSendTransactionCopyWithImpl<$Res>
    implements $TonConnectUiEventSendTransactionCopyWith<$Res> {
  _$TonConnectUiEventSendTransactionCopyWithImpl(this._self, this._then);

  final TonConnectUiEventSendTransaction _self;
  final $Res Function(TonConnectUiEventSendTransaction) _then;

  /// Create a copy of TonConnectUiEvent
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  $Res call({
    Object? connection = null,
    Object? payload = null,
    Object? completer = null,
  }) {
    return _then(TonConnectUiEventSendTransaction(
      connection: null == connection
          ? _self.connection
          : connection // ignore: cast_nullable_to_non_nullable
              as TonAppConnection,
      payload: null == payload
          ? _self.payload
          : payload // ignore: cast_nullable_to_non_nullable
              as TransactionPayload,
      completer: null == completer
          ? _self.completer
          : completer // ignore: cast_nullable_to_non_nullable
              as Completer<SignedMessage?>,
    ));
  }

  /// Create a copy of TonConnectUiEvent
  /// with the given fields replaced by the non-null parameter values.
  @override
  @pragma('vm:prefer-inline')
  $TonAppConnectionCopyWith<$Res> get connection {
    return $TonAppConnectionCopyWith<$Res>(_self.connection, (value) {
      return _then(_self.copyWith(connection: value));
    });
  }

  /// Create a copy of TonConnectUiEvent
  /// with the given fields replaced by the non-null parameter values.
  @override
  @pragma('vm:prefer-inline')
  $TransactionPayloadCopyWith<$Res> get payload {
    return $TransactionPayloadCopyWith<$Res>(_self.payload, (value) {
      return _then(_self.copyWith(payload: value));
    });
  }
}

/// @nodoc

class TonConnectUiEventSignData implements TonConnectUiEvent {
  TonConnectUiEventSignData(
      {required this.connection,
      required this.payload,
      required this.completer});

  final TonAppConnection connection;
  final SignDataPayload payload;
  final Completer<SignDataResult?> completer;

  /// Create a copy of TonConnectUiEvent
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @pragma('vm:prefer-inline')
  $TonConnectUiEventSignDataCopyWith<TonConnectUiEventSignData> get copyWith =>
      _$TonConnectUiEventSignDataCopyWithImpl<TonConnectUiEventSignData>(
          this, _$identity);

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is TonConnectUiEventSignData &&
            (identical(other.connection, connection) ||
                other.connection == connection) &&
            (identical(other.payload, payload) || other.payload == payload) &&
            (identical(other.completer, completer) ||
                other.completer == completer));
  }

  @override
  int get hashCode => Object.hash(runtimeType, connection, payload, completer);

  @override
  String toString() {
    return 'TonConnectUiEvent.signData(connection: $connection, payload: $payload, completer: $completer)';
  }
}

/// @nodoc
abstract mixin class $TonConnectUiEventSignDataCopyWith<$Res>
    implements $TonConnectUiEventCopyWith<$Res> {
  factory $TonConnectUiEventSignDataCopyWith(TonConnectUiEventSignData value,
          $Res Function(TonConnectUiEventSignData) _then) =
      _$TonConnectUiEventSignDataCopyWithImpl;
  @useResult
  $Res call(
      {TonAppConnection connection,
      SignDataPayload payload,
      Completer<SignDataResult?> completer});

  $TonAppConnectionCopyWith<$Res> get connection;
  $SignDataPayloadCopyWith<$Res> get payload;
}

/// @nodoc
class _$TonConnectUiEventSignDataCopyWithImpl<$Res>
    implements $TonConnectUiEventSignDataCopyWith<$Res> {
  _$TonConnectUiEventSignDataCopyWithImpl(this._self, this._then);

  final TonConnectUiEventSignData _self;
  final $Res Function(TonConnectUiEventSignData) _then;

  /// Create a copy of TonConnectUiEvent
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  $Res call({
    Object? connection = null,
    Object? payload = null,
    Object? completer = null,
  }) {
    return _then(TonConnectUiEventSignData(
      connection: null == connection
          ? _self.connection
          : connection // ignore: cast_nullable_to_non_nullable
              as TonAppConnection,
      payload: null == payload
          ? _self.payload
          : payload // ignore: cast_nullable_to_non_nullable
              as SignDataPayload,
      completer: null == completer
          ? _self.completer
          : completer // ignore: cast_nullable_to_non_nullable
              as Completer<SignDataResult?>,
    ));
  }

  /// Create a copy of TonConnectUiEvent
  /// with the given fields replaced by the non-null parameter values.
  @override
  @pragma('vm:prefer-inline')
  $TonAppConnectionCopyWith<$Res> get connection {
    return $TonAppConnectionCopyWith<$Res>(_self.connection, (value) {
      return _then(_self.copyWith(connection: value));
    });
  }

  /// Create a copy of TonConnectUiEvent
  /// with the given fields replaced by the non-null parameter values.
  @override
  @pragma('vm:prefer-inline')
  $SignDataPayloadCopyWith<$Res> get payload {
    return $SignDataPayloadCopyWith<$Res>(_self.payload, (value) {
      return _then(_self.copyWith(payload: value));
    });
  }
}

// dart format on
