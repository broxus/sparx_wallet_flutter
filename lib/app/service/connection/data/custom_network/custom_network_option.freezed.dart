// dart format width=80
// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'custom_network_option.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// dart format off
T _$identity<T>(T value) => value;

/// @nodoc
mixin _$CustomNetworkOption {
  NetworkType get networkType;

  /// Create a copy of CustomNetworkOption
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @pragma('vm:prefer-inline')
  $CustomNetworkOptionCopyWith<CustomNetworkOption> get copyWith =>
      _$CustomNetworkOptionCopyWithImpl<CustomNetworkOption>(
          this as CustomNetworkOption, _$identity);

  /// Serializes this CustomNetworkOption to a JSON map.
  Map<String, dynamic> toJson();

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is CustomNetworkOption &&
            (identical(other.networkType, networkType) ||
                other.networkType == networkType));
  }

  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  int get hashCode => Object.hash(runtimeType, networkType);

  @override
  String toString() {
    return 'CustomNetworkOption(networkType: $networkType)';
  }
}

/// @nodoc
abstract mixin class $CustomNetworkOptionCopyWith<$Res> {
  factory $CustomNetworkOptionCopyWith(
          CustomNetworkOption value, $Res Function(CustomNetworkOption) _then) =
      _$CustomNetworkOptionCopyWithImpl;
  @useResult
  $Res call({NetworkType networkType});
}

/// @nodoc
class _$CustomNetworkOptionCopyWithImpl<$Res>
    implements $CustomNetworkOptionCopyWith<$Res> {
  _$CustomNetworkOptionCopyWithImpl(this._self, this._then);

  final CustomNetworkOption _self;
  final $Res Function(CustomNetworkOption) _then;

  /// Create a copy of CustomNetworkOption
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? networkType = null,
  }) {
    return _then(_self.copyWith(
      networkType: null == networkType
          ? _self.networkType
          : networkType // ignore: cast_nullable_to_non_nullable
              as NetworkType,
    ));
  }
}

/// @nodoc
@JsonSerializable()
class _CustomNetworkOption implements CustomNetworkOption {
  _CustomNetworkOption({required this.networkType});
  factory _CustomNetworkOption.fromJson(Map<String, dynamic> json) =>
      _$CustomNetworkOptionFromJson(json);

  @override
  final NetworkType networkType;

  /// Create a copy of CustomNetworkOption
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  @pragma('vm:prefer-inline')
  _$CustomNetworkOptionCopyWith<_CustomNetworkOption> get copyWith =>
      __$CustomNetworkOptionCopyWithImpl<_CustomNetworkOption>(
          this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$CustomNetworkOptionToJson(
      this,
    );
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _CustomNetworkOption &&
            (identical(other.networkType, networkType) ||
                other.networkType == networkType));
  }

  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  int get hashCode => Object.hash(runtimeType, networkType);

  @override
  String toString() {
    return 'CustomNetworkOption(networkType: $networkType)';
  }
}

/// @nodoc
abstract mixin class _$CustomNetworkOptionCopyWith<$Res>
    implements $CustomNetworkOptionCopyWith<$Res> {
  factory _$CustomNetworkOptionCopyWith(_CustomNetworkOption value,
          $Res Function(_CustomNetworkOption) _then) =
      __$CustomNetworkOptionCopyWithImpl;
  @override
  @useResult
  $Res call({NetworkType networkType});
}

/// @nodoc
class __$CustomNetworkOptionCopyWithImpl<$Res>
    implements _$CustomNetworkOptionCopyWith<$Res> {
  __$CustomNetworkOptionCopyWithImpl(this._self, this._then);

  final _CustomNetworkOption _self;
  final $Res Function(_CustomNetworkOption) _then;

  /// Create a copy of CustomNetworkOption
  /// with the given fields replaced by the non-null parameter values.
  @override
  @pragma('vm:prefer-inline')
  $Res call({
    Object? networkType = null,
  }) {
    return _then(_CustomNetworkOption(
      networkType: null == networkType
          ? _self.networkType
          : networkType // ignore: cast_nullable_to_non_nullable
              as NetworkType,
    ));
  }
}

// dart format on
