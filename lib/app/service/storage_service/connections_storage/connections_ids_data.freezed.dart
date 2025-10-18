// dart format width=80
// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'connections_ids_data.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// dart format off
T _$identity<T>(T value) => value;

/// @nodoc
mixin _$ConnectionIdsData {
  String get connectionId;
  int get workchainId;
  int get networkId;

  /// Create a copy of ConnectionIdsData
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @pragma('vm:prefer-inline')
  $ConnectionIdsDataCopyWith<ConnectionIdsData> get copyWith =>
      _$ConnectionIdsDataCopyWithImpl<ConnectionIdsData>(
          this as ConnectionIdsData, _$identity);

  /// Serializes this ConnectionIdsData to a JSON map.
  Map<String, dynamic> toJson();

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is ConnectionIdsData &&
            (identical(other.connectionId, connectionId) ||
                other.connectionId == connectionId) &&
            (identical(other.workchainId, workchainId) ||
                other.workchainId == workchainId) &&
            (identical(other.networkId, networkId) ||
                other.networkId == networkId));
  }

  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  int get hashCode =>
      Object.hash(runtimeType, connectionId, workchainId, networkId);

  @override
  String toString() {
    return 'ConnectionIdsData(connectionId: $connectionId, workchainId: $workchainId, networkId: $networkId)';
  }
}

/// @nodoc
abstract mixin class $ConnectionIdsDataCopyWith<$Res> {
  factory $ConnectionIdsDataCopyWith(
          ConnectionIdsData value, $Res Function(ConnectionIdsData) _then) =
      _$ConnectionIdsDataCopyWithImpl;
  @useResult
  $Res call({String connectionId, int workchainId, int networkId});
}

/// @nodoc
class _$ConnectionIdsDataCopyWithImpl<$Res>
    implements $ConnectionIdsDataCopyWith<$Res> {
  _$ConnectionIdsDataCopyWithImpl(this._self, this._then);

  final ConnectionIdsData _self;
  final $Res Function(ConnectionIdsData) _then;

  /// Create a copy of ConnectionIdsData
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? connectionId = null,
    Object? workchainId = null,
    Object? networkId = null,
  }) {
    return _then(_self.copyWith(
      connectionId: null == connectionId
          ? _self.connectionId
          : connectionId // ignore: cast_nullable_to_non_nullable
              as String,
      workchainId: null == workchainId
          ? _self.workchainId
          : workchainId // ignore: cast_nullable_to_non_nullable
              as int,
      networkId: null == networkId
          ? _self.networkId
          : networkId // ignore: cast_nullable_to_non_nullable
              as int,
    ));
  }
}

/// @nodoc
@JsonSerializable()
class _ConnectionIdsData implements ConnectionIdsData {
  _ConnectionIdsData(
      {required this.connectionId,
      required this.workchainId,
      required this.networkId});
  factory _ConnectionIdsData.fromJson(Map<String, dynamic> json) =>
      _$ConnectionIdsDataFromJson(json);

  @override
  final String connectionId;
  @override
  final int workchainId;
  @override
  final int networkId;

  /// Create a copy of ConnectionIdsData
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  @pragma('vm:prefer-inline')
  _$ConnectionIdsDataCopyWith<_ConnectionIdsData> get copyWith =>
      __$ConnectionIdsDataCopyWithImpl<_ConnectionIdsData>(this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$ConnectionIdsDataToJson(
      this,
    );
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _ConnectionIdsData &&
            (identical(other.connectionId, connectionId) ||
                other.connectionId == connectionId) &&
            (identical(other.workchainId, workchainId) ||
                other.workchainId == workchainId) &&
            (identical(other.networkId, networkId) ||
                other.networkId == networkId));
  }

  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  int get hashCode =>
      Object.hash(runtimeType, connectionId, workchainId, networkId);

  @override
  String toString() {
    return 'ConnectionIdsData(connectionId: $connectionId, workchainId: $workchainId, networkId: $networkId)';
  }
}

/// @nodoc
abstract mixin class _$ConnectionIdsDataCopyWith<$Res>
    implements $ConnectionIdsDataCopyWith<$Res> {
  factory _$ConnectionIdsDataCopyWith(
          _ConnectionIdsData value, $Res Function(_ConnectionIdsData) _then) =
      __$ConnectionIdsDataCopyWithImpl;
  @override
  @useResult
  $Res call({String connectionId, int workchainId, int networkId});
}

/// @nodoc
class __$ConnectionIdsDataCopyWithImpl<$Res>
    implements _$ConnectionIdsDataCopyWith<$Res> {
  __$ConnectionIdsDataCopyWithImpl(this._self, this._then);

  final _ConnectionIdsData _self;
  final $Res Function(_ConnectionIdsData) _then;

  /// Create a copy of ConnectionIdsData
  /// with the given fields replaced by the non-null parameter values.
  @override
  @pragma('vm:prefer-inline')
  $Res call({
    Object? connectionId = null,
    Object? workchainId = null,
    Object? networkId = null,
  }) {
    return _then(_ConnectionIdsData(
      connectionId: null == connectionId
          ? _self.connectionId
          : connectionId // ignore: cast_nullable_to_non_nullable
              as String,
      workchainId: null == workchainId
          ? _self.workchainId
          : workchainId // ignore: cast_nullable_to_non_nullable
              as int,
      networkId: null == networkId
          ? _self.networkId
          : networkId // ignore: cast_nullable_to_non_nullable
              as int,
    ));
  }
}

// dart format on
