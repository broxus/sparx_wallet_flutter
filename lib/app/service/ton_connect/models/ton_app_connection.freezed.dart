// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'ton_app_connection.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
    'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#adding-getters-and-methods-to-our-models');

TonAppConnection _$TonAppConnectionFromJson(Map<String, dynamic> json) {
  switch (json['runtimeType']) {
    case 'remote':
      return TonAppConnectionRemote.fromJson(json);
    case 'injected':
      return TonAppConnectionInjected.fromJson(json);

    default:
      throw CheckedFromJsonException(json, 'runtimeType', 'TonAppConnection',
          'Invalid union type "${json['runtimeType']}"!');
  }
}

/// @nodoc
mixin _$TonAppConnection {
  List<ConnectItemReply> get replyItems => throw _privateConstructorUsedError;
  Address get walletAddress => throw _privateConstructorUsedError;
  String get manifestUrl => throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult when<TResult extends Object?>({
    required TResult Function(
            String clientId,
            SessionCrypto sessionCrypto,
            List<ConnectItemReply> replyItems,
            Address walletAddress,
            String manifestUrl)
        remote,
    required TResult Function(String origin, List<ConnectItemReply> replyItems,
            Address walletAddress, String manifestUrl)
        injected,
  }) =>
      throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>({
    TResult? Function(
            String clientId,
            SessionCrypto sessionCrypto,
            List<ConnectItemReply> replyItems,
            Address walletAddress,
            String manifestUrl)?
        remote,
    TResult? Function(String origin, List<ConnectItemReply> replyItems,
            Address walletAddress, String manifestUrl)?
        injected,
  }) =>
      throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>({
    TResult Function(
            String clientId,
            SessionCrypto sessionCrypto,
            List<ConnectItemReply> replyItems,
            Address walletAddress,
            String manifestUrl)?
        remote,
    TResult Function(String origin, List<ConnectItemReply> replyItems,
            Address walletAddress, String manifestUrl)?
        injected,
    required TResult orElse(),
  }) =>
      throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult map<TResult extends Object?>({
    required TResult Function(TonAppConnectionRemote value) remote,
    required TResult Function(TonAppConnectionInjected value) injected,
  }) =>
      throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult? mapOrNull<TResult extends Object?>({
    TResult? Function(TonAppConnectionRemote value)? remote,
    TResult? Function(TonAppConnectionInjected value)? injected,
  }) =>
      throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>({
    TResult Function(TonAppConnectionRemote value)? remote,
    TResult Function(TonAppConnectionInjected value)? injected,
    required TResult orElse(),
  }) =>
      throw _privateConstructorUsedError;

  /// Serializes this TonAppConnection to a JSON map.
  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;

  /// Create a copy of TonAppConnection
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  $TonAppConnectionCopyWith<TonAppConnection> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $TonAppConnectionCopyWith<$Res> {
  factory $TonAppConnectionCopyWith(
          TonAppConnection value, $Res Function(TonAppConnection) then) =
      _$TonAppConnectionCopyWithImpl<$Res, TonAppConnection>;
  @useResult
  $Res call(
      {List<ConnectItemReply> replyItems,
      Address walletAddress,
      String manifestUrl});

  $AddressCopyWith<$Res> get walletAddress;
}

/// @nodoc
class _$TonAppConnectionCopyWithImpl<$Res, $Val extends TonAppConnection>
    implements $TonAppConnectionCopyWith<$Res> {
  _$TonAppConnectionCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  /// Create a copy of TonAppConnection
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? replyItems = null,
    Object? walletAddress = null,
    Object? manifestUrl = null,
  }) {
    return _then(_value.copyWith(
      replyItems: null == replyItems
          ? _value.replyItems
          : replyItems // ignore: cast_nullable_to_non_nullable
              as List<ConnectItemReply>,
      walletAddress: null == walletAddress
          ? _value.walletAddress
          : walletAddress // ignore: cast_nullable_to_non_nullable
              as Address,
      manifestUrl: null == manifestUrl
          ? _value.manifestUrl
          : manifestUrl // ignore: cast_nullable_to_non_nullable
              as String,
    ) as $Val);
  }

  /// Create a copy of TonAppConnection
  /// with the given fields replaced by the non-null parameter values.
  @override
  @pragma('vm:prefer-inline')
  $AddressCopyWith<$Res> get walletAddress {
    return $AddressCopyWith<$Res>(_value.walletAddress, (value) {
      return _then(_value.copyWith(walletAddress: value) as $Val);
    });
  }
}

/// @nodoc
abstract class _$$TonAppConnectionRemoteImplCopyWith<$Res>
    implements $TonAppConnectionCopyWith<$Res> {
  factory _$$TonAppConnectionRemoteImplCopyWith(
          _$TonAppConnectionRemoteImpl value,
          $Res Function(_$TonAppConnectionRemoteImpl) then) =
      __$$TonAppConnectionRemoteImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call(
      {String clientId,
      SessionCrypto sessionCrypto,
      List<ConnectItemReply> replyItems,
      Address walletAddress,
      String manifestUrl});

  @override
  $AddressCopyWith<$Res> get walletAddress;
}

/// @nodoc
class __$$TonAppConnectionRemoteImplCopyWithImpl<$Res>
    extends _$TonAppConnectionCopyWithImpl<$Res, _$TonAppConnectionRemoteImpl>
    implements _$$TonAppConnectionRemoteImplCopyWith<$Res> {
  __$$TonAppConnectionRemoteImplCopyWithImpl(
      _$TonAppConnectionRemoteImpl _value,
      $Res Function(_$TonAppConnectionRemoteImpl) _then)
      : super(_value, _then);

  /// Create a copy of TonAppConnection
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? clientId = null,
    Object? sessionCrypto = null,
    Object? replyItems = null,
    Object? walletAddress = null,
    Object? manifestUrl = null,
  }) {
    return _then(_$TonAppConnectionRemoteImpl(
      clientId: null == clientId
          ? _value.clientId
          : clientId // ignore: cast_nullable_to_non_nullable
              as String,
      sessionCrypto: null == sessionCrypto
          ? _value.sessionCrypto
          : sessionCrypto // ignore: cast_nullable_to_non_nullable
              as SessionCrypto,
      replyItems: null == replyItems
          ? _value._replyItems
          : replyItems // ignore: cast_nullable_to_non_nullable
              as List<ConnectItemReply>,
      walletAddress: null == walletAddress
          ? _value.walletAddress
          : walletAddress // ignore: cast_nullable_to_non_nullable
              as Address,
      manifestUrl: null == manifestUrl
          ? _value.manifestUrl
          : manifestUrl // ignore: cast_nullable_to_non_nullable
              as String,
    ));
  }
}

/// @nodoc
@JsonSerializable()
class _$TonAppConnectionRemoteImpl extends TonAppConnectionRemote {
  const _$TonAppConnectionRemoteImpl(
      {required this.clientId,
      required this.sessionCrypto,
      required final List<ConnectItemReply> replyItems,
      required this.walletAddress,
      required this.manifestUrl,
      final String? $type})
      : _replyItems = replyItems,
        $type = $type ?? 'remote',
        super._();

  factory _$TonAppConnectionRemoteImpl.fromJson(Map<String, dynamic> json) =>
      _$$TonAppConnectionRemoteImplFromJson(json);

  @override
  final String clientId;
  @override
  final SessionCrypto sessionCrypto;
  final List<ConnectItemReply> _replyItems;
  @override
  List<ConnectItemReply> get replyItems {
    if (_replyItems is EqualUnmodifiableListView) return _replyItems;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableListView(_replyItems);
  }

  @override
  final Address walletAddress;
  @override
  final String manifestUrl;

  @JsonKey(name: 'runtimeType')
  final String $type;

  @override
  String toString() {
    return 'TonAppConnection.remote(clientId: $clientId, sessionCrypto: $sessionCrypto, replyItems: $replyItems, walletAddress: $walletAddress, manifestUrl: $manifestUrl)';
  }

  /// Create a copy of TonAppConnection
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$TonAppConnectionRemoteImplCopyWith<_$TonAppConnectionRemoteImpl>
      get copyWith => __$$TonAppConnectionRemoteImplCopyWithImpl<
          _$TonAppConnectionRemoteImpl>(this, _$identity);

  @override
  @optionalTypeArgs
  TResult when<TResult extends Object?>({
    required TResult Function(
            String clientId,
            SessionCrypto sessionCrypto,
            List<ConnectItemReply> replyItems,
            Address walletAddress,
            String manifestUrl)
        remote,
    required TResult Function(String origin, List<ConnectItemReply> replyItems,
            Address walletAddress, String manifestUrl)
        injected,
  }) {
    return remote(
        clientId, sessionCrypto, replyItems, walletAddress, manifestUrl);
  }

  @override
  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>({
    TResult? Function(
            String clientId,
            SessionCrypto sessionCrypto,
            List<ConnectItemReply> replyItems,
            Address walletAddress,
            String manifestUrl)?
        remote,
    TResult? Function(String origin, List<ConnectItemReply> replyItems,
            Address walletAddress, String manifestUrl)?
        injected,
  }) {
    return remote?.call(
        clientId, sessionCrypto, replyItems, walletAddress, manifestUrl);
  }

  @override
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>({
    TResult Function(
            String clientId,
            SessionCrypto sessionCrypto,
            List<ConnectItemReply> replyItems,
            Address walletAddress,
            String manifestUrl)?
        remote,
    TResult Function(String origin, List<ConnectItemReply> replyItems,
            Address walletAddress, String manifestUrl)?
        injected,
    required TResult orElse(),
  }) {
    if (remote != null) {
      return remote(
          clientId, sessionCrypto, replyItems, walletAddress, manifestUrl);
    }
    return orElse();
  }

  @override
  @optionalTypeArgs
  TResult map<TResult extends Object?>({
    required TResult Function(TonAppConnectionRemote value) remote,
    required TResult Function(TonAppConnectionInjected value) injected,
  }) {
    return remote(this);
  }

  @override
  @optionalTypeArgs
  TResult? mapOrNull<TResult extends Object?>({
    TResult? Function(TonAppConnectionRemote value)? remote,
    TResult? Function(TonAppConnectionInjected value)? injected,
  }) {
    return remote?.call(this);
  }

  @override
  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>({
    TResult Function(TonAppConnectionRemote value)? remote,
    TResult Function(TonAppConnectionInjected value)? injected,
    required TResult orElse(),
  }) {
    if (remote != null) {
      return remote(this);
    }
    return orElse();
  }

  @override
  Map<String, dynamic> toJson() {
    return _$$TonAppConnectionRemoteImplToJson(
      this,
    );
  }
}

abstract class TonAppConnectionRemote extends TonAppConnection {
  const factory TonAppConnectionRemote(
      {required final String clientId,
      required final SessionCrypto sessionCrypto,
      required final List<ConnectItemReply> replyItems,
      required final Address walletAddress,
      required final String manifestUrl}) = _$TonAppConnectionRemoteImpl;
  const TonAppConnectionRemote._() : super._();

  factory TonAppConnectionRemote.fromJson(Map<String, dynamic> json) =
      _$TonAppConnectionRemoteImpl.fromJson;

  String get clientId;
  SessionCrypto get sessionCrypto;
  @override
  List<ConnectItemReply> get replyItems;
  @override
  Address get walletAddress;
  @override
  String get manifestUrl;

  /// Create a copy of TonAppConnection
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$TonAppConnectionRemoteImplCopyWith<_$TonAppConnectionRemoteImpl>
      get copyWith => throw _privateConstructorUsedError;
}

/// @nodoc
abstract class _$$TonAppConnectionInjectedImplCopyWith<$Res>
    implements $TonAppConnectionCopyWith<$Res> {
  factory _$$TonAppConnectionInjectedImplCopyWith(
          _$TonAppConnectionInjectedImpl value,
          $Res Function(_$TonAppConnectionInjectedImpl) then) =
      __$$TonAppConnectionInjectedImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call(
      {String origin,
      List<ConnectItemReply> replyItems,
      Address walletAddress,
      String manifestUrl});

  @override
  $AddressCopyWith<$Res> get walletAddress;
}

/// @nodoc
class __$$TonAppConnectionInjectedImplCopyWithImpl<$Res>
    extends _$TonAppConnectionCopyWithImpl<$Res, _$TonAppConnectionInjectedImpl>
    implements _$$TonAppConnectionInjectedImplCopyWith<$Res> {
  __$$TonAppConnectionInjectedImplCopyWithImpl(
      _$TonAppConnectionInjectedImpl _value,
      $Res Function(_$TonAppConnectionInjectedImpl) _then)
      : super(_value, _then);

  /// Create a copy of TonAppConnection
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? origin = null,
    Object? replyItems = null,
    Object? walletAddress = null,
    Object? manifestUrl = null,
  }) {
    return _then(_$TonAppConnectionInjectedImpl(
      origin: null == origin
          ? _value.origin
          : origin // ignore: cast_nullable_to_non_nullable
              as String,
      replyItems: null == replyItems
          ? _value._replyItems
          : replyItems // ignore: cast_nullable_to_non_nullable
              as List<ConnectItemReply>,
      walletAddress: null == walletAddress
          ? _value.walletAddress
          : walletAddress // ignore: cast_nullable_to_non_nullable
              as Address,
      manifestUrl: null == manifestUrl
          ? _value.manifestUrl
          : manifestUrl // ignore: cast_nullable_to_non_nullable
              as String,
    ));
  }
}

/// @nodoc
@JsonSerializable()
class _$TonAppConnectionInjectedImpl extends TonAppConnectionInjected {
  const _$TonAppConnectionInjectedImpl(
      {required this.origin,
      required final List<ConnectItemReply> replyItems,
      required this.walletAddress,
      required this.manifestUrl,
      final String? $type})
      : _replyItems = replyItems,
        $type = $type ?? 'injected',
        super._();

  factory _$TonAppConnectionInjectedImpl.fromJson(Map<String, dynamic> json) =>
      _$$TonAppConnectionInjectedImplFromJson(json);

  @override
  final String origin;
  final List<ConnectItemReply> _replyItems;
  @override
  List<ConnectItemReply> get replyItems {
    if (_replyItems is EqualUnmodifiableListView) return _replyItems;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableListView(_replyItems);
  }

  @override
  final Address walletAddress;
  @override
  final String manifestUrl;

  @JsonKey(name: 'runtimeType')
  final String $type;

  @override
  String toString() {
    return 'TonAppConnection.injected(origin: $origin, replyItems: $replyItems, walletAddress: $walletAddress, manifestUrl: $manifestUrl)';
  }

  /// Create a copy of TonAppConnection
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$TonAppConnectionInjectedImplCopyWith<_$TonAppConnectionInjectedImpl>
      get copyWith => __$$TonAppConnectionInjectedImplCopyWithImpl<
          _$TonAppConnectionInjectedImpl>(this, _$identity);

  @override
  @optionalTypeArgs
  TResult when<TResult extends Object?>({
    required TResult Function(
            String clientId,
            SessionCrypto sessionCrypto,
            List<ConnectItemReply> replyItems,
            Address walletAddress,
            String manifestUrl)
        remote,
    required TResult Function(String origin, List<ConnectItemReply> replyItems,
            Address walletAddress, String manifestUrl)
        injected,
  }) {
    return injected(origin, replyItems, walletAddress, manifestUrl);
  }

  @override
  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>({
    TResult? Function(
            String clientId,
            SessionCrypto sessionCrypto,
            List<ConnectItemReply> replyItems,
            Address walletAddress,
            String manifestUrl)?
        remote,
    TResult? Function(String origin, List<ConnectItemReply> replyItems,
            Address walletAddress, String manifestUrl)?
        injected,
  }) {
    return injected?.call(origin, replyItems, walletAddress, manifestUrl);
  }

  @override
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>({
    TResult Function(
            String clientId,
            SessionCrypto sessionCrypto,
            List<ConnectItemReply> replyItems,
            Address walletAddress,
            String manifestUrl)?
        remote,
    TResult Function(String origin, List<ConnectItemReply> replyItems,
            Address walletAddress, String manifestUrl)?
        injected,
    required TResult orElse(),
  }) {
    if (injected != null) {
      return injected(origin, replyItems, walletAddress, manifestUrl);
    }
    return orElse();
  }

  @override
  @optionalTypeArgs
  TResult map<TResult extends Object?>({
    required TResult Function(TonAppConnectionRemote value) remote,
    required TResult Function(TonAppConnectionInjected value) injected,
  }) {
    return injected(this);
  }

  @override
  @optionalTypeArgs
  TResult? mapOrNull<TResult extends Object?>({
    TResult? Function(TonAppConnectionRemote value)? remote,
    TResult? Function(TonAppConnectionInjected value)? injected,
  }) {
    return injected?.call(this);
  }

  @override
  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>({
    TResult Function(TonAppConnectionRemote value)? remote,
    TResult Function(TonAppConnectionInjected value)? injected,
    required TResult orElse(),
  }) {
    if (injected != null) {
      return injected(this);
    }
    return orElse();
  }

  @override
  Map<String, dynamic> toJson() {
    return _$$TonAppConnectionInjectedImplToJson(
      this,
    );
  }
}

abstract class TonAppConnectionInjected extends TonAppConnection {
  const factory TonAppConnectionInjected(
      {required final String origin,
      required final List<ConnectItemReply> replyItems,
      required final Address walletAddress,
      required final String manifestUrl}) = _$TonAppConnectionInjectedImpl;
  const TonAppConnectionInjected._() : super._();

  factory TonAppConnectionInjected.fromJson(Map<String, dynamic> json) =
      _$TonAppConnectionInjectedImpl.fromJson;

  String get origin;
  @override
  List<ConnectItemReply> get replyItems;
  @override
  Address get walletAddress;
  @override
  String get manifestUrl;

  /// Create a copy of TonAppConnection
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$TonAppConnectionInjectedImplCopyWith<_$TonAppConnectionInjectedImpl>
      get copyWith => throw _privateConstructorUsedError;
}
