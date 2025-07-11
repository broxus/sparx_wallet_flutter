// dart format width=80
// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'rpc_request.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// dart format off
T _$identity<T>(T value) => value;
RpcRequest _$RpcRequestFromJson(Map<String, dynamic> json) {
  switch (json['method']) {
    case 'disconnect':
      return DisconnectRpcRequest.fromJson(json);
    case 'sendTransaction':
      return SendTransactionRpcRequest.fromJson(json);
    case 'signData':
      return SignDataRpcRequest.fromJson(json);

    default:
      throw CheckedFromJsonException(json, 'method', 'RpcRequest',
          'Invalid union type "${json['method']}"!');
  }
}

/// @nodoc
mixin _$RpcRequest {
  String get id;
  List<dynamic> get params;

  /// Create a copy of RpcRequest
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @pragma('vm:prefer-inline')
  $RpcRequestCopyWith<RpcRequest> get copyWith =>
      _$RpcRequestCopyWithImpl<RpcRequest>(this as RpcRequest, _$identity);

  /// Serializes this RpcRequest to a JSON map.
  Map<String, dynamic> toJson();

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is RpcRequest &&
            (identical(other.id, id) || other.id == id) &&
            const DeepCollectionEquality().equals(other.params, params));
  }

  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  int get hashCode =>
      Object.hash(runtimeType, id, const DeepCollectionEquality().hash(params));

  @override
  String toString() {
    return 'RpcRequest(id: $id, params: $params)';
  }
}

/// @nodoc
abstract mixin class $RpcRequestCopyWith<$Res> {
  factory $RpcRequestCopyWith(
          RpcRequest value, $Res Function(RpcRequest) _then) =
      _$RpcRequestCopyWithImpl;
  @useResult
  $Res call({String id});
}

/// @nodoc
class _$RpcRequestCopyWithImpl<$Res> implements $RpcRequestCopyWith<$Res> {
  _$RpcRequestCopyWithImpl(this._self, this._then);

  final RpcRequest _self;
  final $Res Function(RpcRequest) _then;

  /// Create a copy of RpcRequest
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
class DisconnectRpcRequest implements RpcRequest {
  const DisconnectRpcRequest(
      {required this.id,
      final List<dynamic> params = const [],
      final String? $type})
      : _params = params,
        $type = $type ?? 'disconnect';
  factory DisconnectRpcRequest.fromJson(Map<String, dynamic> json) =>
      _$DisconnectRpcRequestFromJson(json);

  @override
  final String id;
  final List<dynamic> _params;
  @override
  @JsonKey()
  List<dynamic> get params {
    if (_params is EqualUnmodifiableListView) return _params;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableListView(_params);
  }

  @JsonKey(name: 'method')
  final String $type;

  /// Create a copy of RpcRequest
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  @pragma('vm:prefer-inline')
  $DisconnectRpcRequestCopyWith<DisconnectRpcRequest> get copyWith =>
      _$DisconnectRpcRequestCopyWithImpl<DisconnectRpcRequest>(
          this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$DisconnectRpcRequestToJson(
      this,
    );
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is DisconnectRpcRequest &&
            (identical(other.id, id) || other.id == id) &&
            const DeepCollectionEquality().equals(other._params, _params));
  }

  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  int get hashCode => Object.hash(
      runtimeType, id, const DeepCollectionEquality().hash(_params));

  @override
  String toString() {
    return 'RpcRequest.disconnect(id: $id, params: $params)';
  }
}

/// @nodoc
abstract mixin class $DisconnectRpcRequestCopyWith<$Res>
    implements $RpcRequestCopyWith<$Res> {
  factory $DisconnectRpcRequestCopyWith(DisconnectRpcRequest value,
          $Res Function(DisconnectRpcRequest) _then) =
      _$DisconnectRpcRequestCopyWithImpl;
  @override
  @useResult
  $Res call({String id, List<dynamic> params});
}

/// @nodoc
class _$DisconnectRpcRequestCopyWithImpl<$Res>
    implements $DisconnectRpcRequestCopyWith<$Res> {
  _$DisconnectRpcRequestCopyWithImpl(this._self, this._then);

  final DisconnectRpcRequest _self;
  final $Res Function(DisconnectRpcRequest) _then;

  /// Create a copy of RpcRequest
  /// with the given fields replaced by the non-null parameter values.
  @override
  @pragma('vm:prefer-inline')
  $Res call({
    Object? id = null,
    Object? params = null,
  }) {
    return _then(DisconnectRpcRequest(
      id: null == id
          ? _self.id
          : id // ignore: cast_nullable_to_non_nullable
              as String,
      params: null == params
          ? _self._params
          : params // ignore: cast_nullable_to_non_nullable
              as List<dynamic>,
    ));
  }
}

/// @nodoc
@JsonSerializable()
class SendTransactionRpcRequest implements RpcRequest {
  const SendTransactionRpcRequest(
      {required this.id,
      required final List<String> params,
      final String? $type})
      : _params = params,
        $type = $type ?? 'sendTransaction';
  factory SendTransactionRpcRequest.fromJson(Map<String, dynamic> json) =>
      _$SendTransactionRpcRequestFromJson(json);

  @override
  final String id;
  final List<String> _params;
  @override
  List<String> get params {
    if (_params is EqualUnmodifiableListView) return _params;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableListView(_params);
  }

  @JsonKey(name: 'method')
  final String $type;

  /// Create a copy of RpcRequest
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  @pragma('vm:prefer-inline')
  $SendTransactionRpcRequestCopyWith<SendTransactionRpcRequest> get copyWith =>
      _$SendTransactionRpcRequestCopyWithImpl<SendTransactionRpcRequest>(
          this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$SendTransactionRpcRequestToJson(
      this,
    );
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is SendTransactionRpcRequest &&
            (identical(other.id, id) || other.id == id) &&
            const DeepCollectionEquality().equals(other._params, _params));
  }

  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  int get hashCode => Object.hash(
      runtimeType, id, const DeepCollectionEquality().hash(_params));

  @override
  String toString() {
    return 'RpcRequest.sendTransaction(id: $id, params: $params)';
  }
}

/// @nodoc
abstract mixin class $SendTransactionRpcRequestCopyWith<$Res>
    implements $RpcRequestCopyWith<$Res> {
  factory $SendTransactionRpcRequestCopyWith(SendTransactionRpcRequest value,
          $Res Function(SendTransactionRpcRequest) _then) =
      _$SendTransactionRpcRequestCopyWithImpl;
  @override
  @useResult
  $Res call({String id, List<String> params});
}

/// @nodoc
class _$SendTransactionRpcRequestCopyWithImpl<$Res>
    implements $SendTransactionRpcRequestCopyWith<$Res> {
  _$SendTransactionRpcRequestCopyWithImpl(this._self, this._then);

  final SendTransactionRpcRequest _self;
  final $Res Function(SendTransactionRpcRequest) _then;

  /// Create a copy of RpcRequest
  /// with the given fields replaced by the non-null parameter values.
  @override
  @pragma('vm:prefer-inline')
  $Res call({
    Object? id = null,
    Object? params = null,
  }) {
    return _then(SendTransactionRpcRequest(
      id: null == id
          ? _self.id
          : id // ignore: cast_nullable_to_non_nullable
              as String,
      params: null == params
          ? _self._params
          : params // ignore: cast_nullable_to_non_nullable
              as List<String>,
    ));
  }
}

/// @nodoc
@JsonSerializable()
class SignDataRpcRequest implements RpcRequest {
  const SignDataRpcRequest(
      {required this.id,
      required final List<String> params,
      final String? $type})
      : _params = params,
        $type = $type ?? 'signData';
  factory SignDataRpcRequest.fromJson(Map<String, dynamic> json) =>
      _$SignDataRpcRequestFromJson(json);

  @override
  final String id;
  final List<String> _params;
  @override
  List<String> get params {
    if (_params is EqualUnmodifiableListView) return _params;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableListView(_params);
  }

  @JsonKey(name: 'method')
  final String $type;

  /// Create a copy of RpcRequest
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  @pragma('vm:prefer-inline')
  $SignDataRpcRequestCopyWith<SignDataRpcRequest> get copyWith =>
      _$SignDataRpcRequestCopyWithImpl<SignDataRpcRequest>(this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$SignDataRpcRequestToJson(
      this,
    );
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is SignDataRpcRequest &&
            (identical(other.id, id) || other.id == id) &&
            const DeepCollectionEquality().equals(other._params, _params));
  }

  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  int get hashCode => Object.hash(
      runtimeType, id, const DeepCollectionEquality().hash(_params));

  @override
  String toString() {
    return 'RpcRequest.signData(id: $id, params: $params)';
  }
}

/// @nodoc
abstract mixin class $SignDataRpcRequestCopyWith<$Res>
    implements $RpcRequestCopyWith<$Res> {
  factory $SignDataRpcRequestCopyWith(
          SignDataRpcRequest value, $Res Function(SignDataRpcRequest) _then) =
      _$SignDataRpcRequestCopyWithImpl;
  @override
  @useResult
  $Res call({String id, List<String> params});
}

/// @nodoc
class _$SignDataRpcRequestCopyWithImpl<$Res>
    implements $SignDataRpcRequestCopyWith<$Res> {
  _$SignDataRpcRequestCopyWithImpl(this._self, this._then);

  final SignDataRpcRequest _self;
  final $Res Function(SignDataRpcRequest) _then;

  /// Create a copy of RpcRequest
  /// with the given fields replaced by the non-null parameter values.
  @override
  @pragma('vm:prefer-inline')
  $Res call({
    Object? id = null,
    Object? params = null,
  }) {
    return _then(SignDataRpcRequest(
      id: null == id
          ? _self.id
          : id // ignore: cast_nullable_to_non_nullable
              as String,
      params: null == params
          ? _self._params
          : params // ignore: cast_nullable_to_non_nullable
              as List<String>,
    ));
  }
}

// dart format on
