// dart format width=80
// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'connection_default_settings.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// dart format off
T _$identity<T>(T value) => value;

/// @nodoc
mixin _$ConnectionDefaultSettings {
  WalletDefaultAccountNames get walletAccountNames;

  /// Create a copy of ConnectionDefaultSettings
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @pragma('vm:prefer-inline')
  $ConnectionDefaultSettingsCopyWith<ConnectionDefaultSettings> get copyWith =>
      _$ConnectionDefaultSettingsCopyWithImpl<ConnectionDefaultSettings>(
          this as ConnectionDefaultSettings, _$identity);

  /// Serializes this ConnectionDefaultSettings to a JSON map.
  Map<String, dynamic> toJson();

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is ConnectionDefaultSettings &&
            (identical(other.walletAccountNames, walletAccountNames) ||
                other.walletAccountNames == walletAccountNames));
  }

  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  int get hashCode => Object.hash(runtimeType, walletAccountNames);

  @override
  String toString() {
    return 'ConnectionDefaultSettings(walletAccountNames: $walletAccountNames)';
  }
}

/// @nodoc
abstract mixin class $ConnectionDefaultSettingsCopyWith<$Res> {
  factory $ConnectionDefaultSettingsCopyWith(ConnectionDefaultSettings value,
          $Res Function(ConnectionDefaultSettings) _then) =
      _$ConnectionDefaultSettingsCopyWithImpl;
  @useResult
  $Res call({WalletDefaultAccountNames walletAccountNames});

  $WalletDefaultAccountNamesCopyWith<$Res> get walletAccountNames;
}

/// @nodoc
class _$ConnectionDefaultSettingsCopyWithImpl<$Res>
    implements $ConnectionDefaultSettingsCopyWith<$Res> {
  _$ConnectionDefaultSettingsCopyWithImpl(this._self, this._then);

  final ConnectionDefaultSettings _self;
  final $Res Function(ConnectionDefaultSettings) _then;

  /// Create a copy of ConnectionDefaultSettings
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? walletAccountNames = null,
  }) {
    return _then(_self.copyWith(
      walletAccountNames: null == walletAccountNames
          ? _self.walletAccountNames
          : walletAccountNames // ignore: cast_nullable_to_non_nullable
              as WalletDefaultAccountNames,
    ));
  }

  /// Create a copy of ConnectionDefaultSettings
  /// with the given fields replaced by the non-null parameter values.
  @override
  @pragma('vm:prefer-inline')
  $WalletDefaultAccountNamesCopyWith<$Res> get walletAccountNames {
    return $WalletDefaultAccountNamesCopyWith<$Res>(_self.walletAccountNames,
        (value) {
      return _then(_self.copyWith(walletAccountNames: value));
    });
  }
}

/// @nodoc
@JsonSerializable()
class _ConnectionDefaultSettings implements ConnectionDefaultSettings {
  _ConnectionDefaultSettings({required this.walletAccountNames});
  factory _ConnectionDefaultSettings.fromJson(Map<String, dynamic> json) =>
      _$ConnectionDefaultSettingsFromJson(json);

  @override
  final WalletDefaultAccountNames walletAccountNames;

  /// Create a copy of ConnectionDefaultSettings
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  @pragma('vm:prefer-inline')
  _$ConnectionDefaultSettingsCopyWith<_ConnectionDefaultSettings>
      get copyWith =>
          __$ConnectionDefaultSettingsCopyWithImpl<_ConnectionDefaultSettings>(
              this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$ConnectionDefaultSettingsToJson(
      this,
    );
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _ConnectionDefaultSettings &&
            (identical(other.walletAccountNames, walletAccountNames) ||
                other.walletAccountNames == walletAccountNames));
  }

  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  int get hashCode => Object.hash(runtimeType, walletAccountNames);

  @override
  String toString() {
    return 'ConnectionDefaultSettings(walletAccountNames: $walletAccountNames)';
  }
}

/// @nodoc
abstract mixin class _$ConnectionDefaultSettingsCopyWith<$Res>
    implements $ConnectionDefaultSettingsCopyWith<$Res> {
  factory _$ConnectionDefaultSettingsCopyWith(_ConnectionDefaultSettings value,
          $Res Function(_ConnectionDefaultSettings) _then) =
      __$ConnectionDefaultSettingsCopyWithImpl;
  @override
  @useResult
  $Res call({WalletDefaultAccountNames walletAccountNames});

  @override
  $WalletDefaultAccountNamesCopyWith<$Res> get walletAccountNames;
}

/// @nodoc
class __$ConnectionDefaultSettingsCopyWithImpl<$Res>
    implements _$ConnectionDefaultSettingsCopyWith<$Res> {
  __$ConnectionDefaultSettingsCopyWithImpl(this._self, this._then);

  final _ConnectionDefaultSettings _self;
  final $Res Function(_ConnectionDefaultSettings) _then;

  /// Create a copy of ConnectionDefaultSettings
  /// with the given fields replaced by the non-null parameter values.
  @override
  @pragma('vm:prefer-inline')
  $Res call({
    Object? walletAccountNames = null,
  }) {
    return _then(_ConnectionDefaultSettings(
      walletAccountNames: null == walletAccountNames
          ? _self.walletAccountNames
          : walletAccountNames // ignore: cast_nullable_to_non_nullable
              as WalletDefaultAccountNames,
    ));
  }

  /// Create a copy of ConnectionDefaultSettings
  /// with the given fields replaced by the non-null parameter values.
  @override
  @pragma('vm:prefer-inline')
  $WalletDefaultAccountNamesCopyWith<$Res> get walletAccountNames {
    return $WalletDefaultAccountNamesCopyWith<$Res>(_self.walletAccountNames,
        (value) {
      return _then(_self.copyWith(walletAccountNames: value));
    });
  }
}

// dart format on
