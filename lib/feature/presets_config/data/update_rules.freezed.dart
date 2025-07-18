// dart format width=80
// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'update_rules.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// dart format off
T _$identity<T>(T value) => value;

/// @nodoc
mixin _$UpdateRules {
  /// Minimum version required - users below this version cannot use the app.
  String get blockingVersion;

  /// Version that triggers warning - users below this should update but can
  /// continue.
  String get warningVersion;

  /// Maximum number of times to show the warning notification.
  int get warningShowTimes;

  /// Delay in seconds between showing warning notifications.
  int get warningShowDelayS;

  /// Create a copy of UpdateRules
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @pragma('vm:prefer-inline')
  $UpdateRulesCopyWith<UpdateRules> get copyWith =>
      _$UpdateRulesCopyWithImpl<UpdateRules>(this as UpdateRules, _$identity);

  /// Serializes this UpdateRules to a JSON map.
  Map<String, dynamic> toJson();

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is UpdateRules &&
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

  @override
  String toString() {
    return 'UpdateRules(blockingVersion: $blockingVersion, warningVersion: $warningVersion, warningShowTimes: $warningShowTimes, warningShowDelayS: $warningShowDelayS)';
  }
}

/// @nodoc
abstract mixin class $UpdateRulesCopyWith<$Res> {
  factory $UpdateRulesCopyWith(
          UpdateRules value, $Res Function(UpdateRules) _then) =
      _$UpdateRulesCopyWithImpl;
  @useResult
  $Res call(
      {String blockingVersion,
      String warningVersion,
      int warningShowTimes,
      int warningShowDelayS});
}

/// @nodoc
class _$UpdateRulesCopyWithImpl<$Res> implements $UpdateRulesCopyWith<$Res> {
  _$UpdateRulesCopyWithImpl(this._self, this._then);

  final UpdateRules _self;
  final $Res Function(UpdateRules) _then;

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
    return _then(_self.copyWith(
      blockingVersion: null == blockingVersion
          ? _self.blockingVersion
          : blockingVersion // ignore: cast_nullable_to_non_nullable
              as String,
      warningVersion: null == warningVersion
          ? _self.warningVersion
          : warningVersion // ignore: cast_nullable_to_non_nullable
              as String,
      warningShowTimes: null == warningShowTimes
          ? _self.warningShowTimes
          : warningShowTimes // ignore: cast_nullable_to_non_nullable
              as int,
      warningShowDelayS: null == warningShowDelayS
          ? _self.warningShowDelayS
          : warningShowDelayS // ignore: cast_nullable_to_non_nullable
              as int,
    ));
  }
}

/// @nodoc
@JsonSerializable()
class _UpdateRules implements UpdateRules {
  const _UpdateRules(
      {required this.blockingVersion,
      required this.warningVersion,
      required this.warningShowTimes,
      required this.warningShowDelayS});
  factory _UpdateRules.fromJson(Map<String, dynamic> json) =>
      _$UpdateRulesFromJson(json);

  /// Minimum version required - users below this version cannot use the app.
  @override
  final String blockingVersion;

  /// Version that triggers warning - users below this should update but can
  /// continue.
  @override
  final String warningVersion;

  /// Maximum number of times to show the warning notification.
  @override
  final int warningShowTimes;

  /// Delay in seconds between showing warning notifications.
  @override
  final int warningShowDelayS;

  /// Create a copy of UpdateRules
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  @pragma('vm:prefer-inline')
  _$UpdateRulesCopyWith<_UpdateRules> get copyWith =>
      __$UpdateRulesCopyWithImpl<_UpdateRules>(this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$UpdateRulesToJson(
      this,
    );
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _UpdateRules &&
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

  @override
  String toString() {
    return 'UpdateRules(blockingVersion: $blockingVersion, warningVersion: $warningVersion, warningShowTimes: $warningShowTimes, warningShowDelayS: $warningShowDelayS)';
  }
}

/// @nodoc
abstract mixin class _$UpdateRulesCopyWith<$Res>
    implements $UpdateRulesCopyWith<$Res> {
  factory _$UpdateRulesCopyWith(
          _UpdateRules value, $Res Function(_UpdateRules) _then) =
      __$UpdateRulesCopyWithImpl;
  @override
  @useResult
  $Res call(
      {String blockingVersion,
      String warningVersion,
      int warningShowTimes,
      int warningShowDelayS});
}

/// @nodoc
class __$UpdateRulesCopyWithImpl<$Res> implements _$UpdateRulesCopyWith<$Res> {
  __$UpdateRulesCopyWithImpl(this._self, this._then);

  final _UpdateRules _self;
  final $Res Function(_UpdateRules) _then;

  /// Create a copy of UpdateRules
  /// with the given fields replaced by the non-null parameter values.
  @override
  @pragma('vm:prefer-inline')
  $Res call({
    Object? blockingVersion = null,
    Object? warningVersion = null,
    Object? warningShowTimes = null,
    Object? warningShowDelayS = null,
  }) {
    return _then(_UpdateRules(
      blockingVersion: null == blockingVersion
          ? _self.blockingVersion
          : blockingVersion // ignore: cast_nullable_to_non_nullable
              as String,
      warningVersion: null == warningVersion
          ? _self.warningVersion
          : warningVersion // ignore: cast_nullable_to_non_nullable
              as String,
      warningShowTimes: null == warningShowTimes
          ? _self.warningShowTimes
          : warningShowTimes // ignore: cast_nullable_to_non_nullable
              as int,
      warningShowDelayS: null == warningShowDelayS
          ? _self.warningShowDelayS
          : warningShowDelayS // ignore: cast_nullable_to_non_nullable
              as int,
    ));
  }
}

// dart format on
