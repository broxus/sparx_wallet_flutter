// dart format width=80
// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'current_wokchain_data.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// dart format off
T _$identity<T>(T value) => value;

/// @nodoc
mixin _$CurrentWokchainData {
  String get networkId;
  String get workchainId;

  /// Create a copy of CurrentWokchainData
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @pragma('vm:prefer-inline')
  $CurrentWokchainDataCopyWith<CurrentWokchainData> get copyWith =>
      _$CurrentWokchainDataCopyWithImpl<CurrentWokchainData>(
          this as CurrentWokchainData, _$identity);

  /// Serializes this CurrentWokchainData to a JSON map.
  Map<String, dynamic> toJson();

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is CurrentWokchainData &&
            (identical(other.networkId, networkId) ||
                other.networkId == networkId) &&
            (identical(other.workchainId, workchainId) ||
                other.workchainId == workchainId));
  }

  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  int get hashCode => Object.hash(runtimeType, networkId, workchainId);

  @override
  String toString() {
    return 'CurrentWokchainData(networkId: $networkId, workchainId: $workchainId)';
  }
}

/// @nodoc
abstract mixin class $CurrentWokchainDataCopyWith<$Res> {
  factory $CurrentWokchainDataCopyWith(
          CurrentWokchainData value, $Res Function(CurrentWokchainData) _then) =
      _$CurrentWokchainDataCopyWithImpl;
  @useResult
  $Res call({String networkId, String workchainId});
}

/// @nodoc
class _$CurrentWokchainDataCopyWithImpl<$Res>
    implements $CurrentWokchainDataCopyWith<$Res> {
  _$CurrentWokchainDataCopyWithImpl(this._self, this._then);

  final CurrentWokchainData _self;
  final $Res Function(CurrentWokchainData) _then;

  /// Create a copy of CurrentWokchainData
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? networkId = null,
    Object? workchainId = null,
  }) {
    return _then(_self.copyWith(
      networkId: null == networkId
          ? _self.networkId
          : networkId // ignore: cast_nullable_to_non_nullable
              as String,
      workchainId: null == workchainId
          ? _self.workchainId
          : workchainId // ignore: cast_nullable_to_non_nullable
              as String,
    ));
  }
}

/// @nodoc
@JsonSerializable()
class _CurrentWokchainData implements CurrentWokchainData {
  _CurrentWokchainData({required this.networkId, required this.workchainId});
  factory _CurrentWokchainData.fromJson(Map<String, dynamic> json) =>
      _$CurrentWokchainDataFromJson(json);

  @override
  final String networkId;
  @override
  final String workchainId;

  /// Create a copy of CurrentWokchainData
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  @pragma('vm:prefer-inline')
  _$CurrentWokchainDataCopyWith<_CurrentWokchainData> get copyWith =>
      __$CurrentWokchainDataCopyWithImpl<_CurrentWokchainData>(
          this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$CurrentWokchainDataToJson(
      this,
    );
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _CurrentWokchainData &&
            (identical(other.networkId, networkId) ||
                other.networkId == networkId) &&
            (identical(other.workchainId, workchainId) ||
                other.workchainId == workchainId));
  }

  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  int get hashCode => Object.hash(runtimeType, networkId, workchainId);

  @override
  String toString() {
    return 'CurrentWokchainData(networkId: $networkId, workchainId: $workchainId)';
  }
}

/// @nodoc
abstract mixin class _$CurrentWokchainDataCopyWith<$Res>
    implements $CurrentWokchainDataCopyWith<$Res> {
  factory _$CurrentWokchainDataCopyWith(_CurrentWokchainData value,
          $Res Function(_CurrentWokchainData) _then) =
      __$CurrentWokchainDataCopyWithImpl;
  @override
  @useResult
  $Res call({String networkId, String workchainId});
}

/// @nodoc
class __$CurrentWokchainDataCopyWithImpl<$Res>
    implements _$CurrentWokchainDataCopyWith<$Res> {
  __$CurrentWokchainDataCopyWithImpl(this._self, this._then);

  final _CurrentWokchainData _self;
  final $Res Function(_CurrentWokchainData) _then;

  /// Create a copy of CurrentWokchainData
  /// with the given fields replaced by the non-null parameter values.
  @override
  @pragma('vm:prefer-inline')
  $Res call({
    Object? networkId = null,
    Object? workchainId = null,
  }) {
    return _then(_CurrentWokchainData(
      networkId: null == networkId
          ? _self.networkId
          : networkId // ignore: cast_nullable_to_non_nullable
              as String,
      workchainId: null == workchainId
          ? _self.workchainId
          : workchainId // ignore: cast_nullable_to_non_nullable
              as String,
    ));
  }
}

// dart format on
