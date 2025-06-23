// dart format width=80
// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'ton_app_connection.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// dart format off
T _$identity<T>(T value) => value;
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
  List<ConnectItemReply> get replyItems;
  Address get walletAddress;
  DappManifest get manifest;

  /// Create a copy of TonAppConnection
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @pragma('vm:prefer-inline')
  $TonAppConnectionCopyWith<TonAppConnection> get copyWith =>
      _$TonAppConnectionCopyWithImpl<TonAppConnection>(
          this as TonAppConnection, _$identity);

  /// Serializes this TonAppConnection to a JSON map.
  Map<String, dynamic> toJson();

  @override
  String toString() {
    return 'TonAppConnection(replyItems: $replyItems, walletAddress: $walletAddress, manifest: $manifest)';
  }
}

/// @nodoc
abstract mixin class $TonAppConnectionCopyWith<$Res> {
  factory $TonAppConnectionCopyWith(
          TonAppConnection value, $Res Function(TonAppConnection) _then) =
      _$TonAppConnectionCopyWithImpl;
  @useResult
  $Res call(
      {List<ConnectItemReply> replyItems,
      Address walletAddress,
      DappManifest manifest});

  $AddressCopyWith<$Res> get walletAddress;
  $DappManifestCopyWith<$Res> get manifest;
}

/// @nodoc
class _$TonAppConnectionCopyWithImpl<$Res>
    implements $TonAppConnectionCopyWith<$Res> {
  _$TonAppConnectionCopyWithImpl(this._self, this._then);

  final TonAppConnection _self;
  final $Res Function(TonAppConnection) _then;

  /// Create a copy of TonAppConnection
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? replyItems = null,
    Object? walletAddress = null,
    Object? manifest = null,
  }) {
    return _then(_self.copyWith(
      replyItems: null == replyItems
          ? _self.replyItems
          : replyItems // ignore: cast_nullable_to_non_nullable
              as List<ConnectItemReply>,
      walletAddress: null == walletAddress
          ? _self.walletAddress
          : walletAddress // ignore: cast_nullable_to_non_nullable
              as Address,
      manifest: null == manifest
          ? _self.manifest
          : manifest // ignore: cast_nullable_to_non_nullable
              as DappManifest,
    ));
  }

  /// Create a copy of TonAppConnection
  /// with the given fields replaced by the non-null parameter values.
  @override
  @pragma('vm:prefer-inline')
  $AddressCopyWith<$Res> get walletAddress {
    return $AddressCopyWith<$Res>(_self.walletAddress, (value) {
      return _then(_self.copyWith(walletAddress: value));
    });
  }

  /// Create a copy of TonAppConnection
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
@JsonSerializable()
class TonAppConnectionRemote extends TonAppConnection {
  const TonAppConnectionRemote(
      {required this.clientId,
      required this.sessionCrypto,
      required final List<ConnectItemReply> replyItems,
      required this.walletAddress,
      required this.manifest,
      final String? $type})
      : _replyItems = replyItems,
        $type = $type ?? 'remote',
        super._();
  factory TonAppConnectionRemote.fromJson(Map<String, dynamic> json) =>
      _$TonAppConnectionRemoteFromJson(json);

  final String clientId;
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
  final DappManifest manifest;

  @JsonKey(name: 'runtimeType')
  final String $type;

  /// Create a copy of TonAppConnection
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  @pragma('vm:prefer-inline')
  $TonAppConnectionRemoteCopyWith<TonAppConnectionRemote> get copyWith =>
      _$TonAppConnectionRemoteCopyWithImpl<TonAppConnectionRemote>(
          this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$TonAppConnectionRemoteToJson(
      this,
    );
  }

  @override
  String toString() {
    return 'TonAppConnection.remote(clientId: $clientId, sessionCrypto: $sessionCrypto, replyItems: $replyItems, walletAddress: $walletAddress, manifest: $manifest)';
  }
}

/// @nodoc
abstract mixin class $TonAppConnectionRemoteCopyWith<$Res>
    implements $TonAppConnectionCopyWith<$Res> {
  factory $TonAppConnectionRemoteCopyWith(TonAppConnectionRemote value,
          $Res Function(TonAppConnectionRemote) _then) =
      _$TonAppConnectionRemoteCopyWithImpl;
  @override
  @useResult
  $Res call(
      {String clientId,
      SessionCrypto sessionCrypto,
      List<ConnectItemReply> replyItems,
      Address walletAddress,
      DappManifest manifest});

  @override
  $AddressCopyWith<$Res> get walletAddress;
  @override
  $DappManifestCopyWith<$Res> get manifest;
}

/// @nodoc
class _$TonAppConnectionRemoteCopyWithImpl<$Res>
    implements $TonAppConnectionRemoteCopyWith<$Res> {
  _$TonAppConnectionRemoteCopyWithImpl(this._self, this._then);

  final TonAppConnectionRemote _self;
  final $Res Function(TonAppConnectionRemote) _then;

  /// Create a copy of TonAppConnection
  /// with the given fields replaced by the non-null parameter values.
  @override
  @pragma('vm:prefer-inline')
  $Res call({
    Object? clientId = null,
    Object? sessionCrypto = null,
    Object? replyItems = null,
    Object? walletAddress = null,
    Object? manifest = null,
  }) {
    return _then(TonAppConnectionRemote(
      clientId: null == clientId
          ? _self.clientId
          : clientId // ignore: cast_nullable_to_non_nullable
              as String,
      sessionCrypto: null == sessionCrypto
          ? _self.sessionCrypto
          : sessionCrypto // ignore: cast_nullable_to_non_nullable
              as SessionCrypto,
      replyItems: null == replyItems
          ? _self._replyItems
          : replyItems // ignore: cast_nullable_to_non_nullable
              as List<ConnectItemReply>,
      walletAddress: null == walletAddress
          ? _self.walletAddress
          : walletAddress // ignore: cast_nullable_to_non_nullable
              as Address,
      manifest: null == manifest
          ? _self.manifest
          : manifest // ignore: cast_nullable_to_non_nullable
              as DappManifest,
    ));
  }

  /// Create a copy of TonAppConnection
  /// with the given fields replaced by the non-null parameter values.
  @override
  @pragma('vm:prefer-inline')
  $AddressCopyWith<$Res> get walletAddress {
    return $AddressCopyWith<$Res>(_self.walletAddress, (value) {
      return _then(_self.copyWith(walletAddress: value));
    });
  }

  /// Create a copy of TonAppConnection
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
@JsonSerializable()
class TonAppConnectionInjected extends TonAppConnection {
  const TonAppConnectionInjected(
      {required this.origin,
      required final List<ConnectItemReply> replyItems,
      required this.walletAddress,
      required this.manifest,
      final String? $type})
      : _replyItems = replyItems,
        $type = $type ?? 'injected',
        super._();
  factory TonAppConnectionInjected.fromJson(Map<String, dynamic> json) =>
      _$TonAppConnectionInjectedFromJson(json);

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
  final DappManifest manifest;

  @JsonKey(name: 'runtimeType')
  final String $type;

  /// Create a copy of TonAppConnection
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  @pragma('vm:prefer-inline')
  $TonAppConnectionInjectedCopyWith<TonAppConnectionInjected> get copyWith =>
      _$TonAppConnectionInjectedCopyWithImpl<TonAppConnectionInjected>(
          this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$TonAppConnectionInjectedToJson(
      this,
    );
  }

  @override
  String toString() {
    return 'TonAppConnection.injected(origin: $origin, replyItems: $replyItems, walletAddress: $walletAddress, manifest: $manifest)';
  }
}

/// @nodoc
abstract mixin class $TonAppConnectionInjectedCopyWith<$Res>
    implements $TonAppConnectionCopyWith<$Res> {
  factory $TonAppConnectionInjectedCopyWith(TonAppConnectionInjected value,
          $Res Function(TonAppConnectionInjected) _then) =
      _$TonAppConnectionInjectedCopyWithImpl;
  @override
  @useResult
  $Res call(
      {String origin,
      List<ConnectItemReply> replyItems,
      Address walletAddress,
      DappManifest manifest});

  @override
  $AddressCopyWith<$Res> get walletAddress;
  @override
  $DappManifestCopyWith<$Res> get manifest;
}

/// @nodoc
class _$TonAppConnectionInjectedCopyWithImpl<$Res>
    implements $TonAppConnectionInjectedCopyWith<$Res> {
  _$TonAppConnectionInjectedCopyWithImpl(this._self, this._then);

  final TonAppConnectionInjected _self;
  final $Res Function(TonAppConnectionInjected) _then;

  /// Create a copy of TonAppConnection
  /// with the given fields replaced by the non-null parameter values.
  @override
  @pragma('vm:prefer-inline')
  $Res call({
    Object? origin = null,
    Object? replyItems = null,
    Object? walletAddress = null,
    Object? manifest = null,
  }) {
    return _then(TonAppConnectionInjected(
      origin: null == origin
          ? _self.origin
          : origin // ignore: cast_nullable_to_non_nullable
              as String,
      replyItems: null == replyItems
          ? _self._replyItems
          : replyItems // ignore: cast_nullable_to_non_nullable
              as List<ConnectItemReply>,
      walletAddress: null == walletAddress
          ? _self.walletAddress
          : walletAddress // ignore: cast_nullable_to_non_nullable
              as Address,
      manifest: null == manifest
          ? _self.manifest
          : manifest // ignore: cast_nullable_to_non_nullable
              as DappManifest,
    ));
  }

  /// Create a copy of TonAppConnection
  /// with the given fields replaced by the non-null parameter values.
  @override
  @pragma('vm:prefer-inline')
  $AddressCopyWith<$Res> get walletAddress {
    return $AddressCopyWith<$Res>(_self.walletAddress, (value) {
      return _then(_self.copyWith(walletAddress: value));
    });
  }

  /// Create a copy of TonAppConnection
  /// with the given fields replaced by the non-null parameter values.
  @override
  @pragma('vm:prefer-inline')
  $DappManifestCopyWith<$Res> get manifest {
    return $DappManifestCopyWith<$Res>(_self.manifest, (value) {
      return _then(_self.copyWith(manifest: value));
    });
  }
}

// dart format on
