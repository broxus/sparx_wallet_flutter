// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'ton_connect_ui_event.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
    'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#adding-getters-and-methods-to-our-models');

/// @nodoc
mixin _$TonConnectUiEvent {
  @optionalTypeArgs
  TResult when<TResult extends Object?>({
    required TResult Function(String message) error,
    required TResult Function(ConnectRequest request, DappManifest manifest,
            Completer<(KeyAccount, List<ConnectItemReply>)?> completer)
        connect,
    required TResult Function(TonAppConnection connection,
            TransactionPayload payload, Completer<SignedMessage?> completer)
        sendTransaction,
    required TResult Function(TonAppConnection connection,
            SignDataPayload payload, Completer<SignDataResult?> completer)
        signData,
  }) =>
      throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>({
    TResult? Function(String message)? error,
    TResult? Function(ConnectRequest request, DappManifest manifest,
            Completer<(KeyAccount, List<ConnectItemReply>)?> completer)?
        connect,
    TResult? Function(TonAppConnection connection, TransactionPayload payload,
            Completer<SignedMessage?> completer)?
        sendTransaction,
    TResult? Function(TonAppConnection connection, SignDataPayload payload,
            Completer<SignDataResult?> completer)?
        signData,
  }) =>
      throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>({
    TResult Function(String message)? error,
    TResult Function(ConnectRequest request, DappManifest manifest,
            Completer<(KeyAccount, List<ConnectItemReply>)?> completer)?
        connect,
    TResult Function(TonAppConnection connection, TransactionPayload payload,
            Completer<SignedMessage?> completer)?
        sendTransaction,
    TResult Function(TonAppConnection connection, SignDataPayload payload,
            Completer<SignDataResult?> completer)?
        signData,
    required TResult orElse(),
  }) =>
      throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult map<TResult extends Object?>({
    required TResult Function(TonConnectUiEventError value) error,
    required TResult Function(TonConnectUiEventConnect value) connect,
    required TResult Function(TonConnectUiEventSendTransaction value)
        sendTransaction,
    required TResult Function(TonConnectUiEventSignData value) signData,
  }) =>
      throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult? mapOrNull<TResult extends Object?>({
    TResult? Function(TonConnectUiEventError value)? error,
    TResult? Function(TonConnectUiEventConnect value)? connect,
    TResult? Function(TonConnectUiEventSendTransaction value)? sendTransaction,
    TResult? Function(TonConnectUiEventSignData value)? signData,
  }) =>
      throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>({
    TResult Function(TonConnectUiEventError value)? error,
    TResult Function(TonConnectUiEventConnect value)? connect,
    TResult Function(TonConnectUiEventSendTransaction value)? sendTransaction,
    TResult Function(TonConnectUiEventSignData value)? signData,
    required TResult orElse(),
  }) =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $TonConnectUiEventCopyWith<$Res> {
  factory $TonConnectUiEventCopyWith(
          TonConnectUiEvent value, $Res Function(TonConnectUiEvent) then) =
      _$TonConnectUiEventCopyWithImpl<$Res, TonConnectUiEvent>;
}

/// @nodoc
class _$TonConnectUiEventCopyWithImpl<$Res, $Val extends TonConnectUiEvent>
    implements $TonConnectUiEventCopyWith<$Res> {
  _$TonConnectUiEventCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  /// Create a copy of TonConnectUiEvent
  /// with the given fields replaced by the non-null parameter values.
}

/// @nodoc
abstract class _$$TonConnectUiEventErrorImplCopyWith<$Res> {
  factory _$$TonConnectUiEventErrorImplCopyWith(
          _$TonConnectUiEventErrorImpl value,
          $Res Function(_$TonConnectUiEventErrorImpl) then) =
      __$$TonConnectUiEventErrorImplCopyWithImpl<$Res>;
  @useResult
  $Res call({String message});
}

/// @nodoc
class __$$TonConnectUiEventErrorImplCopyWithImpl<$Res>
    extends _$TonConnectUiEventCopyWithImpl<$Res, _$TonConnectUiEventErrorImpl>
    implements _$$TonConnectUiEventErrorImplCopyWith<$Res> {
  __$$TonConnectUiEventErrorImplCopyWithImpl(
      _$TonConnectUiEventErrorImpl _value,
      $Res Function(_$TonConnectUiEventErrorImpl) _then)
      : super(_value, _then);

  /// Create a copy of TonConnectUiEvent
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? message = null,
  }) {
    return _then(_$TonConnectUiEventErrorImpl(
      message: null == message
          ? _value.message
          : message // ignore: cast_nullable_to_non_nullable
              as String,
    ));
  }
}

/// @nodoc

class _$TonConnectUiEventErrorImpl implements TonConnectUiEventError {
  _$TonConnectUiEventErrorImpl({required this.message});

  @override
  final String message;

  @override
  String toString() {
    return 'TonConnectUiEvent.error(message: $message)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$TonConnectUiEventErrorImpl &&
            (identical(other.message, message) || other.message == message));
  }

  @override
  int get hashCode => Object.hash(runtimeType, message);

  /// Create a copy of TonConnectUiEvent
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$TonConnectUiEventErrorImplCopyWith<_$TonConnectUiEventErrorImpl>
      get copyWith => __$$TonConnectUiEventErrorImplCopyWithImpl<
          _$TonConnectUiEventErrorImpl>(this, _$identity);

  @override
  @optionalTypeArgs
  TResult when<TResult extends Object?>({
    required TResult Function(String message) error,
    required TResult Function(ConnectRequest request, DappManifest manifest,
            Completer<(KeyAccount, List<ConnectItemReply>)?> completer)
        connect,
    required TResult Function(TonAppConnection connection,
            TransactionPayload payload, Completer<SignedMessage?> completer)
        sendTransaction,
    required TResult Function(TonAppConnection connection,
            SignDataPayload payload, Completer<SignDataResult?> completer)
        signData,
  }) {
    return error(message);
  }

  @override
  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>({
    TResult? Function(String message)? error,
    TResult? Function(ConnectRequest request, DappManifest manifest,
            Completer<(KeyAccount, List<ConnectItemReply>)?> completer)?
        connect,
    TResult? Function(TonAppConnection connection, TransactionPayload payload,
            Completer<SignedMessage?> completer)?
        sendTransaction,
    TResult? Function(TonAppConnection connection, SignDataPayload payload,
            Completer<SignDataResult?> completer)?
        signData,
  }) {
    return error?.call(message);
  }

  @override
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>({
    TResult Function(String message)? error,
    TResult Function(ConnectRequest request, DappManifest manifest,
            Completer<(KeyAccount, List<ConnectItemReply>)?> completer)?
        connect,
    TResult Function(TonAppConnection connection, TransactionPayload payload,
            Completer<SignedMessage?> completer)?
        sendTransaction,
    TResult Function(TonAppConnection connection, SignDataPayload payload,
            Completer<SignDataResult?> completer)?
        signData,
    required TResult orElse(),
  }) {
    if (error != null) {
      return error(message);
    }
    return orElse();
  }

  @override
  @optionalTypeArgs
  TResult map<TResult extends Object?>({
    required TResult Function(TonConnectUiEventError value) error,
    required TResult Function(TonConnectUiEventConnect value) connect,
    required TResult Function(TonConnectUiEventSendTransaction value)
        sendTransaction,
    required TResult Function(TonConnectUiEventSignData value) signData,
  }) {
    return error(this);
  }

  @override
  @optionalTypeArgs
  TResult? mapOrNull<TResult extends Object?>({
    TResult? Function(TonConnectUiEventError value)? error,
    TResult? Function(TonConnectUiEventConnect value)? connect,
    TResult? Function(TonConnectUiEventSendTransaction value)? sendTransaction,
    TResult? Function(TonConnectUiEventSignData value)? signData,
  }) {
    return error?.call(this);
  }

  @override
  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>({
    TResult Function(TonConnectUiEventError value)? error,
    TResult Function(TonConnectUiEventConnect value)? connect,
    TResult Function(TonConnectUiEventSendTransaction value)? sendTransaction,
    TResult Function(TonConnectUiEventSignData value)? signData,
    required TResult orElse(),
  }) {
    if (error != null) {
      return error(this);
    }
    return orElse();
  }
}

abstract class TonConnectUiEventError implements TonConnectUiEvent {
  factory TonConnectUiEventError({required final String message}) =
      _$TonConnectUiEventErrorImpl;

  String get message;

  /// Create a copy of TonConnectUiEvent
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$TonConnectUiEventErrorImplCopyWith<_$TonConnectUiEventErrorImpl>
      get copyWith => throw _privateConstructorUsedError;
}

/// @nodoc
abstract class _$$TonConnectUiEventConnectImplCopyWith<$Res> {
  factory _$$TonConnectUiEventConnectImplCopyWith(
          _$TonConnectUiEventConnectImpl value,
          $Res Function(_$TonConnectUiEventConnectImpl) then) =
      __$$TonConnectUiEventConnectImplCopyWithImpl<$Res>;
  @useResult
  $Res call(
      {ConnectRequest request,
      DappManifest manifest,
      Completer<(KeyAccount, List<ConnectItemReply>)?> completer});

  $ConnectRequestCopyWith<$Res> get request;
  $DappManifestCopyWith<$Res> get manifest;
}

/// @nodoc
class __$$TonConnectUiEventConnectImplCopyWithImpl<$Res>
    extends _$TonConnectUiEventCopyWithImpl<$Res,
        _$TonConnectUiEventConnectImpl>
    implements _$$TonConnectUiEventConnectImplCopyWith<$Res> {
  __$$TonConnectUiEventConnectImplCopyWithImpl(
      _$TonConnectUiEventConnectImpl _value,
      $Res Function(_$TonConnectUiEventConnectImpl) _then)
      : super(_value, _then);

  /// Create a copy of TonConnectUiEvent
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? request = null,
    Object? manifest = null,
    Object? completer = null,
  }) {
    return _then(_$TonConnectUiEventConnectImpl(
      request: null == request
          ? _value.request
          : request // ignore: cast_nullable_to_non_nullable
              as ConnectRequest,
      manifest: null == manifest
          ? _value.manifest
          : manifest // ignore: cast_nullable_to_non_nullable
              as DappManifest,
      completer: null == completer
          ? _value.completer
          : completer // ignore: cast_nullable_to_non_nullable
              as Completer<(KeyAccount, List<ConnectItemReply>)?>,
    ));
  }

  /// Create a copy of TonConnectUiEvent
  /// with the given fields replaced by the non-null parameter values.
  @override
  @pragma('vm:prefer-inline')
  $ConnectRequestCopyWith<$Res> get request {
    return $ConnectRequestCopyWith<$Res>(_value.request, (value) {
      return _then(_value.copyWith(request: value));
    });
  }

  /// Create a copy of TonConnectUiEvent
  /// with the given fields replaced by the non-null parameter values.
  @override
  @pragma('vm:prefer-inline')
  $DappManifestCopyWith<$Res> get manifest {
    return $DappManifestCopyWith<$Res>(_value.manifest, (value) {
      return _then(_value.copyWith(manifest: value));
    });
  }
}

/// @nodoc

class _$TonConnectUiEventConnectImpl implements TonConnectUiEventConnect {
  _$TonConnectUiEventConnectImpl(
      {required this.request, required this.manifest, required this.completer});

  @override
  final ConnectRequest request;
  @override
  final DappManifest manifest;
  @override
  final Completer<(KeyAccount, List<ConnectItemReply>)?> completer;

  @override
  String toString() {
    return 'TonConnectUiEvent.connect(request: $request, manifest: $manifest, completer: $completer)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$TonConnectUiEventConnectImpl &&
            (identical(other.request, request) || other.request == request) &&
            (identical(other.manifest, manifest) ||
                other.manifest == manifest) &&
            (identical(other.completer, completer) ||
                other.completer == completer));
  }

  @override
  int get hashCode => Object.hash(runtimeType, request, manifest, completer);

  /// Create a copy of TonConnectUiEvent
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$TonConnectUiEventConnectImplCopyWith<_$TonConnectUiEventConnectImpl>
      get copyWith => __$$TonConnectUiEventConnectImplCopyWithImpl<
          _$TonConnectUiEventConnectImpl>(this, _$identity);

  @override
  @optionalTypeArgs
  TResult when<TResult extends Object?>({
    required TResult Function(String message) error,
    required TResult Function(ConnectRequest request, DappManifest manifest,
            Completer<(KeyAccount, List<ConnectItemReply>)?> completer)
        connect,
    required TResult Function(TonAppConnection connection,
            TransactionPayload payload, Completer<SignedMessage?> completer)
        sendTransaction,
    required TResult Function(TonAppConnection connection,
            SignDataPayload payload, Completer<SignDataResult?> completer)
        signData,
  }) {
    return connect(request, manifest, completer);
  }

  @override
  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>({
    TResult? Function(String message)? error,
    TResult? Function(ConnectRequest request, DappManifest manifest,
            Completer<(KeyAccount, List<ConnectItemReply>)?> completer)?
        connect,
    TResult? Function(TonAppConnection connection, TransactionPayload payload,
            Completer<SignedMessage?> completer)?
        sendTransaction,
    TResult? Function(TonAppConnection connection, SignDataPayload payload,
            Completer<SignDataResult?> completer)?
        signData,
  }) {
    return connect?.call(request, manifest, completer);
  }

  @override
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>({
    TResult Function(String message)? error,
    TResult Function(ConnectRequest request, DappManifest manifest,
            Completer<(KeyAccount, List<ConnectItemReply>)?> completer)?
        connect,
    TResult Function(TonAppConnection connection, TransactionPayload payload,
            Completer<SignedMessage?> completer)?
        sendTransaction,
    TResult Function(TonAppConnection connection, SignDataPayload payload,
            Completer<SignDataResult?> completer)?
        signData,
    required TResult orElse(),
  }) {
    if (connect != null) {
      return connect(request, manifest, completer);
    }
    return orElse();
  }

  @override
  @optionalTypeArgs
  TResult map<TResult extends Object?>({
    required TResult Function(TonConnectUiEventError value) error,
    required TResult Function(TonConnectUiEventConnect value) connect,
    required TResult Function(TonConnectUiEventSendTransaction value)
        sendTransaction,
    required TResult Function(TonConnectUiEventSignData value) signData,
  }) {
    return connect(this);
  }

  @override
  @optionalTypeArgs
  TResult? mapOrNull<TResult extends Object?>({
    TResult? Function(TonConnectUiEventError value)? error,
    TResult? Function(TonConnectUiEventConnect value)? connect,
    TResult? Function(TonConnectUiEventSendTransaction value)? sendTransaction,
    TResult? Function(TonConnectUiEventSignData value)? signData,
  }) {
    return connect?.call(this);
  }

  @override
  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>({
    TResult Function(TonConnectUiEventError value)? error,
    TResult Function(TonConnectUiEventConnect value)? connect,
    TResult Function(TonConnectUiEventSendTransaction value)? sendTransaction,
    TResult Function(TonConnectUiEventSignData value)? signData,
    required TResult orElse(),
  }) {
    if (connect != null) {
      return connect(this);
    }
    return orElse();
  }
}

abstract class TonConnectUiEventConnect implements TonConnectUiEvent {
  factory TonConnectUiEventConnect(
      {required final ConnectRequest request,
      required final DappManifest manifest,
      required final Completer<(KeyAccount, List<ConnectItemReply>)?>
          completer}) = _$TonConnectUiEventConnectImpl;

  ConnectRequest get request;
  DappManifest get manifest;
  Completer<(KeyAccount, List<ConnectItemReply>)?> get completer;

  /// Create a copy of TonConnectUiEvent
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$TonConnectUiEventConnectImplCopyWith<_$TonConnectUiEventConnectImpl>
      get copyWith => throw _privateConstructorUsedError;
}

/// @nodoc
abstract class _$$TonConnectUiEventSendTransactionImplCopyWith<$Res> {
  factory _$$TonConnectUiEventSendTransactionImplCopyWith(
          _$TonConnectUiEventSendTransactionImpl value,
          $Res Function(_$TonConnectUiEventSendTransactionImpl) then) =
      __$$TonConnectUiEventSendTransactionImplCopyWithImpl<$Res>;
  @useResult
  $Res call(
      {TonAppConnection connection,
      TransactionPayload payload,
      Completer<SignedMessage?> completer});

  $TonAppConnectionCopyWith<$Res> get connection;
  $TransactionPayloadCopyWith<$Res> get payload;
}

/// @nodoc
class __$$TonConnectUiEventSendTransactionImplCopyWithImpl<$Res>
    extends _$TonConnectUiEventCopyWithImpl<$Res,
        _$TonConnectUiEventSendTransactionImpl>
    implements _$$TonConnectUiEventSendTransactionImplCopyWith<$Res> {
  __$$TonConnectUiEventSendTransactionImplCopyWithImpl(
      _$TonConnectUiEventSendTransactionImpl _value,
      $Res Function(_$TonConnectUiEventSendTransactionImpl) _then)
      : super(_value, _then);

  /// Create a copy of TonConnectUiEvent
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? connection = null,
    Object? payload = null,
    Object? completer = null,
  }) {
    return _then(_$TonConnectUiEventSendTransactionImpl(
      connection: null == connection
          ? _value.connection
          : connection // ignore: cast_nullable_to_non_nullable
              as TonAppConnection,
      payload: null == payload
          ? _value.payload
          : payload // ignore: cast_nullable_to_non_nullable
              as TransactionPayload,
      completer: null == completer
          ? _value.completer
          : completer // ignore: cast_nullable_to_non_nullable
              as Completer<SignedMessage?>,
    ));
  }

  /// Create a copy of TonConnectUiEvent
  /// with the given fields replaced by the non-null parameter values.
  @override
  @pragma('vm:prefer-inline')
  $TonAppConnectionCopyWith<$Res> get connection {
    return $TonAppConnectionCopyWith<$Res>(_value.connection, (value) {
      return _then(_value.copyWith(connection: value));
    });
  }

  /// Create a copy of TonConnectUiEvent
  /// with the given fields replaced by the non-null parameter values.
  @override
  @pragma('vm:prefer-inline')
  $TransactionPayloadCopyWith<$Res> get payload {
    return $TransactionPayloadCopyWith<$Res>(_value.payload, (value) {
      return _then(_value.copyWith(payload: value));
    });
  }
}

/// @nodoc

class _$TonConnectUiEventSendTransactionImpl
    implements TonConnectUiEventSendTransaction {
  _$TonConnectUiEventSendTransactionImpl(
      {required this.connection,
      required this.payload,
      required this.completer});

  @override
  final TonAppConnection connection;
  @override
  final TransactionPayload payload;
  @override
  final Completer<SignedMessage?> completer;

  @override
  String toString() {
    return 'TonConnectUiEvent.sendTransaction(connection: $connection, payload: $payload, completer: $completer)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$TonConnectUiEventSendTransactionImpl &&
            (identical(other.connection, connection) ||
                other.connection == connection) &&
            (identical(other.payload, payload) || other.payload == payload) &&
            (identical(other.completer, completer) ||
                other.completer == completer));
  }

  @override
  int get hashCode => Object.hash(runtimeType, connection, payload, completer);

  /// Create a copy of TonConnectUiEvent
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$TonConnectUiEventSendTransactionImplCopyWith<
          _$TonConnectUiEventSendTransactionImpl>
      get copyWith => __$$TonConnectUiEventSendTransactionImplCopyWithImpl<
          _$TonConnectUiEventSendTransactionImpl>(this, _$identity);

  @override
  @optionalTypeArgs
  TResult when<TResult extends Object?>({
    required TResult Function(String message) error,
    required TResult Function(ConnectRequest request, DappManifest manifest,
            Completer<(KeyAccount, List<ConnectItemReply>)?> completer)
        connect,
    required TResult Function(TonAppConnection connection,
            TransactionPayload payload, Completer<SignedMessage?> completer)
        sendTransaction,
    required TResult Function(TonAppConnection connection,
            SignDataPayload payload, Completer<SignDataResult?> completer)
        signData,
  }) {
    return sendTransaction(connection, payload, completer);
  }

  @override
  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>({
    TResult? Function(String message)? error,
    TResult? Function(ConnectRequest request, DappManifest manifest,
            Completer<(KeyAccount, List<ConnectItemReply>)?> completer)?
        connect,
    TResult? Function(TonAppConnection connection, TransactionPayload payload,
            Completer<SignedMessage?> completer)?
        sendTransaction,
    TResult? Function(TonAppConnection connection, SignDataPayload payload,
            Completer<SignDataResult?> completer)?
        signData,
  }) {
    return sendTransaction?.call(connection, payload, completer);
  }

  @override
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>({
    TResult Function(String message)? error,
    TResult Function(ConnectRequest request, DappManifest manifest,
            Completer<(KeyAccount, List<ConnectItemReply>)?> completer)?
        connect,
    TResult Function(TonAppConnection connection, TransactionPayload payload,
            Completer<SignedMessage?> completer)?
        sendTransaction,
    TResult Function(TonAppConnection connection, SignDataPayload payload,
            Completer<SignDataResult?> completer)?
        signData,
    required TResult orElse(),
  }) {
    if (sendTransaction != null) {
      return sendTransaction(connection, payload, completer);
    }
    return orElse();
  }

  @override
  @optionalTypeArgs
  TResult map<TResult extends Object?>({
    required TResult Function(TonConnectUiEventError value) error,
    required TResult Function(TonConnectUiEventConnect value) connect,
    required TResult Function(TonConnectUiEventSendTransaction value)
        sendTransaction,
    required TResult Function(TonConnectUiEventSignData value) signData,
  }) {
    return sendTransaction(this);
  }

  @override
  @optionalTypeArgs
  TResult? mapOrNull<TResult extends Object?>({
    TResult? Function(TonConnectUiEventError value)? error,
    TResult? Function(TonConnectUiEventConnect value)? connect,
    TResult? Function(TonConnectUiEventSendTransaction value)? sendTransaction,
    TResult? Function(TonConnectUiEventSignData value)? signData,
  }) {
    return sendTransaction?.call(this);
  }

  @override
  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>({
    TResult Function(TonConnectUiEventError value)? error,
    TResult Function(TonConnectUiEventConnect value)? connect,
    TResult Function(TonConnectUiEventSendTransaction value)? sendTransaction,
    TResult Function(TonConnectUiEventSignData value)? signData,
    required TResult orElse(),
  }) {
    if (sendTransaction != null) {
      return sendTransaction(this);
    }
    return orElse();
  }
}

abstract class TonConnectUiEventSendTransaction implements TonConnectUiEvent {
  factory TonConnectUiEventSendTransaction(
          {required final TonAppConnection connection,
          required final TransactionPayload payload,
          required final Completer<SignedMessage?> completer}) =
      _$TonConnectUiEventSendTransactionImpl;

  TonAppConnection get connection;
  TransactionPayload get payload;
  Completer<SignedMessage?> get completer;

  /// Create a copy of TonConnectUiEvent
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$TonConnectUiEventSendTransactionImplCopyWith<
          _$TonConnectUiEventSendTransactionImpl>
      get copyWith => throw _privateConstructorUsedError;
}

/// @nodoc
abstract class _$$TonConnectUiEventSignDataImplCopyWith<$Res> {
  factory _$$TonConnectUiEventSignDataImplCopyWith(
          _$TonConnectUiEventSignDataImpl value,
          $Res Function(_$TonConnectUiEventSignDataImpl) then) =
      __$$TonConnectUiEventSignDataImplCopyWithImpl<$Res>;
  @useResult
  $Res call(
      {TonAppConnection connection,
      SignDataPayload payload,
      Completer<SignDataResult?> completer});

  $TonAppConnectionCopyWith<$Res> get connection;
  $SignDataPayloadCopyWith<$Res> get payload;
}

/// @nodoc
class __$$TonConnectUiEventSignDataImplCopyWithImpl<$Res>
    extends _$TonConnectUiEventCopyWithImpl<$Res,
        _$TonConnectUiEventSignDataImpl>
    implements _$$TonConnectUiEventSignDataImplCopyWith<$Res> {
  __$$TonConnectUiEventSignDataImplCopyWithImpl(
      _$TonConnectUiEventSignDataImpl _value,
      $Res Function(_$TonConnectUiEventSignDataImpl) _then)
      : super(_value, _then);

  /// Create a copy of TonConnectUiEvent
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? connection = null,
    Object? payload = null,
    Object? completer = null,
  }) {
    return _then(_$TonConnectUiEventSignDataImpl(
      connection: null == connection
          ? _value.connection
          : connection // ignore: cast_nullable_to_non_nullable
              as TonAppConnection,
      payload: null == payload
          ? _value.payload
          : payload // ignore: cast_nullable_to_non_nullable
              as SignDataPayload,
      completer: null == completer
          ? _value.completer
          : completer // ignore: cast_nullable_to_non_nullable
              as Completer<SignDataResult?>,
    ));
  }

  /// Create a copy of TonConnectUiEvent
  /// with the given fields replaced by the non-null parameter values.
  @override
  @pragma('vm:prefer-inline')
  $TonAppConnectionCopyWith<$Res> get connection {
    return $TonAppConnectionCopyWith<$Res>(_value.connection, (value) {
      return _then(_value.copyWith(connection: value));
    });
  }

  /// Create a copy of TonConnectUiEvent
  /// with the given fields replaced by the non-null parameter values.
  @override
  @pragma('vm:prefer-inline')
  $SignDataPayloadCopyWith<$Res> get payload {
    return $SignDataPayloadCopyWith<$Res>(_value.payload, (value) {
      return _then(_value.copyWith(payload: value));
    });
  }
}

/// @nodoc

class _$TonConnectUiEventSignDataImpl implements TonConnectUiEventSignData {
  _$TonConnectUiEventSignDataImpl(
      {required this.connection,
      required this.payload,
      required this.completer});

  @override
  final TonAppConnection connection;
  @override
  final SignDataPayload payload;
  @override
  final Completer<SignDataResult?> completer;

  @override
  String toString() {
    return 'TonConnectUiEvent.signData(connection: $connection, payload: $payload, completer: $completer)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$TonConnectUiEventSignDataImpl &&
            (identical(other.connection, connection) ||
                other.connection == connection) &&
            (identical(other.payload, payload) || other.payload == payload) &&
            (identical(other.completer, completer) ||
                other.completer == completer));
  }

  @override
  int get hashCode => Object.hash(runtimeType, connection, payload, completer);

  /// Create a copy of TonConnectUiEvent
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$TonConnectUiEventSignDataImplCopyWith<_$TonConnectUiEventSignDataImpl>
      get copyWith => __$$TonConnectUiEventSignDataImplCopyWithImpl<
          _$TonConnectUiEventSignDataImpl>(this, _$identity);

  @override
  @optionalTypeArgs
  TResult when<TResult extends Object?>({
    required TResult Function(String message) error,
    required TResult Function(ConnectRequest request, DappManifest manifest,
            Completer<(KeyAccount, List<ConnectItemReply>)?> completer)
        connect,
    required TResult Function(TonAppConnection connection,
            TransactionPayload payload, Completer<SignedMessage?> completer)
        sendTransaction,
    required TResult Function(TonAppConnection connection,
            SignDataPayload payload, Completer<SignDataResult?> completer)
        signData,
  }) {
    return signData(connection, payload, completer);
  }

  @override
  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>({
    TResult? Function(String message)? error,
    TResult? Function(ConnectRequest request, DappManifest manifest,
            Completer<(KeyAccount, List<ConnectItemReply>)?> completer)?
        connect,
    TResult? Function(TonAppConnection connection, TransactionPayload payload,
            Completer<SignedMessage?> completer)?
        sendTransaction,
    TResult? Function(TonAppConnection connection, SignDataPayload payload,
            Completer<SignDataResult?> completer)?
        signData,
  }) {
    return signData?.call(connection, payload, completer);
  }

  @override
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>({
    TResult Function(String message)? error,
    TResult Function(ConnectRequest request, DappManifest manifest,
            Completer<(KeyAccount, List<ConnectItemReply>)?> completer)?
        connect,
    TResult Function(TonAppConnection connection, TransactionPayload payload,
            Completer<SignedMessage?> completer)?
        sendTransaction,
    TResult Function(TonAppConnection connection, SignDataPayload payload,
            Completer<SignDataResult?> completer)?
        signData,
    required TResult orElse(),
  }) {
    if (signData != null) {
      return signData(connection, payload, completer);
    }
    return orElse();
  }

  @override
  @optionalTypeArgs
  TResult map<TResult extends Object?>({
    required TResult Function(TonConnectUiEventError value) error,
    required TResult Function(TonConnectUiEventConnect value) connect,
    required TResult Function(TonConnectUiEventSendTransaction value)
        sendTransaction,
    required TResult Function(TonConnectUiEventSignData value) signData,
  }) {
    return signData(this);
  }

  @override
  @optionalTypeArgs
  TResult? mapOrNull<TResult extends Object?>({
    TResult? Function(TonConnectUiEventError value)? error,
    TResult? Function(TonConnectUiEventConnect value)? connect,
    TResult? Function(TonConnectUiEventSendTransaction value)? sendTransaction,
    TResult? Function(TonConnectUiEventSignData value)? signData,
  }) {
    return signData?.call(this);
  }

  @override
  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>({
    TResult Function(TonConnectUiEventError value)? error,
    TResult Function(TonConnectUiEventConnect value)? connect,
    TResult Function(TonConnectUiEventSendTransaction value)? sendTransaction,
    TResult Function(TonConnectUiEventSignData value)? signData,
    required TResult orElse(),
  }) {
    if (signData != null) {
      return signData(this);
    }
    return orElse();
  }
}

abstract class TonConnectUiEventSignData implements TonConnectUiEvent {
  factory TonConnectUiEventSignData(
          {required final TonAppConnection connection,
          required final SignDataPayload payload,
          required final Completer<SignDataResult?> completer}) =
      _$TonConnectUiEventSignDataImpl;

  TonAppConnection get connection;
  SignDataPayload get payload;
  Completer<SignDataResult?> get completer;

  /// Create a copy of TonConnectUiEvent
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$TonConnectUiEventSignDataImplCopyWith<_$TonConnectUiEventSignDataImpl>
      get copyWith => throw _privateConstructorUsedError;
}
