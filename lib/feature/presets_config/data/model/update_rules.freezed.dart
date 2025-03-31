// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'update_rules.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
    'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#adding-getters-and-methods-to-our-models');

UpdateRules _$UpdateRulesFromJson(Map<String, dynamic> json) {
  return _UpdateRules.fromJson(json);
}

/// @nodoc
mixin _$UpdateRules {
  String get blockingVersion => throw _privateConstructorUsedError;
  String get warningVersion => throw _privateConstructorUsedError;
  int get warningShowTimes => throw _privateConstructorUsedError;
  int get warningShowDelayS => throw _privateConstructorUsedError;

  /// Serializes this UpdateRules to a JSON map.
  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;

  /// Create a copy of UpdateRules
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  $UpdateRulesCopyWith<UpdateRules> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $UpdateRulesCopyWith<$Res> {
  factory $UpdateRulesCopyWith(
          UpdateRules value, $Res Function(UpdateRules) then) =
      _$UpdateRulesCopyWithImpl<$Res, UpdateRules>;
  @useResult
  $Res call(
      {String blockingVersion,
      String warningVersion,
      int warningShowTimes,
      int warningShowDelayS});
}

/// @nodoc
class _$UpdateRulesCopyWithImpl<$Res, $Val extends UpdateRules>
    implements $UpdateRulesCopyWith<$Res> {
  _$UpdateRulesCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  /// Create a copy of UpdateRules
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? blockingVersion = null,
    Object? warningVersion = null,
    Object? warningShowTimes = null,
    Object? warningShowDelayS = null,
  }) {
    return _then(_value.copyWith(
      blockingVersion: null == blockingVersion
          ? _value.blockingVersion
          : blockingVersion // ignore: cast_nullable_to_non_nullable
              as String,
      warningVersion: null == warningVersion
          ? _value.warningVersion
          : warningVersion // ignore: cast_nullable_to_non_nullable
              as String,
      warningShowTimes: null == warningShowTimes
          ? _value.warningShowTimes
          : warningShowTimes // ignore: cast_nullable_to_non_nullable
              as int,
      warningShowDelayS: null == warningShowDelayS
          ? _value.warningShowDelayS
          : warningShowDelayS // ignore: cast_nullable_to_non_nullable
              as int,
    ) as $Val);
  }
}

/// @nodoc
abstract class _$$UpdateRulesImplCopyWith<$Res>
    implements $UpdateRulesCopyWith<$Res> {
  factory _$$UpdateRulesImplCopyWith(
          _$UpdateRulesImpl value, $Res Function(_$UpdateRulesImpl) then) =
      __$$UpdateRulesImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call(
      {String blockingVersion,
      String warningVersion,
      int warningShowTimes,
      int warningShowDelayS});
}

/// @nodoc
class __$$UpdateRulesImplCopyWithImpl<$Res>
    extends _$UpdateRulesCopyWithImpl<$Res, _$UpdateRulesImpl>
    implements _$$UpdateRulesImplCopyWith<$Res> {
  __$$UpdateRulesImplCopyWithImpl(
      _$UpdateRulesImpl _value, $Res Function(_$UpdateRulesImpl) _then)
      : super(_value, _then);

  /// Create a copy of UpdateRules
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? blockingVersion = null,
    Object? warningVersion = null,
    Object? warningShowTimes = null,
    Object? warningShowDelayS = null,
  }) {
    return _then(_$UpdateRulesImpl(
      blockingVersion: null == blockingVersion
          ? _value.blockingVersion
          : blockingVersion // ignore: cast_nullable_to_non_nullable
              as String,
      warningVersion: null == warningVersion
          ? _value.warningVersion
          : warningVersion // ignore: cast_nullable_to_non_nullable
              as String,
      warningShowTimes: null == warningShowTimes
          ? _value.warningShowTimes
          : warningShowTimes // ignore: cast_nullable_to_non_nullable
              as int,
      warningShowDelayS: null == warningShowDelayS
          ? _value.warningShowDelayS
          : warningShowDelayS // ignore: cast_nullable_to_non_nullable
              as int,
    ));
  }
}

/// @nodoc
@JsonSerializable()
class _$UpdateRulesImpl implements _UpdateRules {
  const _$UpdateRulesImpl(
      {required this.blockingVersion,
      required this.warningVersion,
      required this.warningShowTimes,
      required this.warningShowDelayS});

  factory _$UpdateRulesImpl.fromJson(Map<String, dynamic> json) =>
      _$$UpdateRulesImplFromJson(json);

  @override
  final String blockingVersion;
  @override
  final String warningVersion;
  @override
  final int warningShowTimes;
  @override
  final int warningShowDelayS;

  @override
  String toString() {
    return 'UpdateRules(blockingVersion: $blockingVersion, warningVersion: $warningVersion, warningShowTimes: $warningShowTimes, warningShowDelayS: $warningShowDelayS)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$UpdateRulesImpl &&
            (identical(other.blockingVersion, blockingVersion) ||
                other.blockingVersion == blockingVersion) &&
            (identical(other.warningVersion, warningVersion) ||
                other.warningVersion == warningVersion) &&
            (identical(other.warningShowTimes, warningShowTimes) ||
                other.warningShowTimes == warningShowTimes) &&
            (identical(other.warningShowDelayS, warningShowDelayS) ||
                other.warningShowDelayS == warningShowDelayS));
  }

  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  int get hashCode => Object.hash(runtimeType, blockingVersion, warningVersion,
      warningShowTimes, warningShowDelayS);

  /// Create a copy of UpdateRules
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$UpdateRulesImplCopyWith<_$UpdateRulesImpl> get copyWith =>
      __$$UpdateRulesImplCopyWithImpl<_$UpdateRulesImpl>(this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$UpdateRulesImplToJson(
      this,
    );
  }
}

abstract class _UpdateRules implements UpdateRules {
  const factory _UpdateRules(
      {required final String blockingVersion,
      required final String warningVersion,
      required final int warningShowTimes,
      required final int warningShowDelayS}) = _$UpdateRulesImpl;

  factory _UpdateRules.fromJson(Map<String, dynamic> json) =
      _$UpdateRulesImpl.fromJson;

  @override
  String get blockingVersion;
  @override
  String get warningVersion;
  @override
  int get warningShowTimes;
  @override
  int get warningShowDelayS;

  /// Create a copy of UpdateRules
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$UpdateRulesImplCopyWith<_$UpdateRulesImpl> get copyWith =>
      throw _privateConstructorUsedError;
}
