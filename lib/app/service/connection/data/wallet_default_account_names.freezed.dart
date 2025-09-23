// dart format width=80
// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'wallet_default_account_names.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// dart format off
T _$identity<T>(T value) => value;

/// @nodoc
mixin _$WalletDefaultAccountNames {
  @MultisigTypeConverter()
  Map<MultisigType, String> get multisig;
  String get walletV3;
  String get highloadWalletV2;
  String get everWallet;
  String get walletV3R1;
  String get walletV3R2;
  String get walletV4R1;
  String get walletV4R2;
  String get walletV5R1;

  /// Create a copy of WalletDefaultAccountNames
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @pragma('vm:prefer-inline')
  $WalletDefaultAccountNamesCopyWith<WalletDefaultAccountNames> get copyWith =>
      _$WalletDefaultAccountNamesCopyWithImpl<WalletDefaultAccountNames>(
          this as WalletDefaultAccountNames, _$identity);

  /// Serializes this WalletDefaultAccountNames to a JSON map.
  Map<String, dynamic> toJson();

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is WalletDefaultAccountNames &&
            const DeepCollectionEquality().equals(other.multisig, multisig) &&
            (identical(other.walletV3, walletV3) ||
                other.walletV3 == walletV3) &&
            (identical(other.highloadWalletV2, highloadWalletV2) ||
                other.highloadWalletV2 == highloadWalletV2) &&
            (identical(other.everWallet, everWallet) ||
                other.everWallet == everWallet) &&
            (identical(other.walletV3R1, walletV3R1) ||
                other.walletV3R1 == walletV3R1) &&
            (identical(other.walletV3R2, walletV3R2) ||
                other.walletV3R2 == walletV3R2) &&
            (identical(other.walletV4R1, walletV4R1) ||
                other.walletV4R1 == walletV4R1) &&
            (identical(other.walletV4R2, walletV4R2) ||
                other.walletV4R2 == walletV4R2) &&
            (identical(other.walletV5R1, walletV5R1) ||
                other.walletV5R1 == walletV5R1));
  }

  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  int get hashCode => Object.hash(
      runtimeType,
      const DeepCollectionEquality().hash(multisig),
      walletV3,
      highloadWalletV2,
      everWallet,
      walletV3R1,
      walletV3R2,
      walletV4R1,
      walletV4R2,
      walletV5R1);

  @override
  String toString() {
    return 'WalletDefaultAccountNames(multisig: $multisig, walletV3: $walletV3, highloadWalletV2: $highloadWalletV2, everWallet: $everWallet, walletV3R1: $walletV3R1, walletV3R2: $walletV3R2, walletV4R1: $walletV4R1, walletV4R2: $walletV4R2, walletV5R1: $walletV5R1)';
  }
}

/// @nodoc
abstract mixin class $WalletDefaultAccountNamesCopyWith<$Res> {
  factory $WalletDefaultAccountNamesCopyWith(WalletDefaultAccountNames value,
          $Res Function(WalletDefaultAccountNames) _then) =
      _$WalletDefaultAccountNamesCopyWithImpl;
  @useResult
  $Res call(
      {@MultisigTypeConverter() Map<MultisigType, String> multisig,
      String walletV3,
      String highloadWalletV2,
      String everWallet,
      String walletV3R1,
      String walletV3R2,
      String walletV4R1,
      String walletV4R2,
      String walletV5R1});
}

/// @nodoc
class _$WalletDefaultAccountNamesCopyWithImpl<$Res>
    implements $WalletDefaultAccountNamesCopyWith<$Res> {
  _$WalletDefaultAccountNamesCopyWithImpl(this._self, this._then);

  final WalletDefaultAccountNames _self;
  final $Res Function(WalletDefaultAccountNames) _then;

  /// Create a copy of WalletDefaultAccountNames
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? multisig = null,
    Object? walletV3 = null,
    Object? highloadWalletV2 = null,
    Object? everWallet = null,
    Object? walletV3R1 = null,
    Object? walletV3R2 = null,
    Object? walletV4R1 = null,
    Object? walletV4R2 = null,
    Object? walletV5R1 = null,
  }) {
    return _then(_self.copyWith(
      multisig: null == multisig
          ? _self.multisig
          : multisig // ignore: cast_nullable_to_non_nullable
              as Map<MultisigType, String>,
      walletV3: null == walletV3
          ? _self.walletV3
          : walletV3 // ignore: cast_nullable_to_non_nullable
              as String,
      highloadWalletV2: null == highloadWalletV2
          ? _self.highloadWalletV2
          : highloadWalletV2 // ignore: cast_nullable_to_non_nullable
              as String,
      everWallet: null == everWallet
          ? _self.everWallet
          : everWallet // ignore: cast_nullable_to_non_nullable
              as String,
      walletV3R1: null == walletV3R1
          ? _self.walletV3R1
          : walletV3R1 // ignore: cast_nullable_to_non_nullable
              as String,
      walletV3R2: null == walletV3R2
          ? _self.walletV3R2
          : walletV3R2 // ignore: cast_nullable_to_non_nullable
              as String,
      walletV4R1: null == walletV4R1
          ? _self.walletV4R1
          : walletV4R1 // ignore: cast_nullable_to_non_nullable
              as String,
      walletV4R2: null == walletV4R2
          ? _self.walletV4R2
          : walletV4R2 // ignore: cast_nullable_to_non_nullable
              as String,
      walletV5R1: null == walletV5R1
          ? _self.walletV5R1
          : walletV5R1 // ignore: cast_nullable_to_non_nullable
              as String,
    ));
  }
}

/// @nodoc
@JsonSerializable()
class _WalletDefaultAccountNames implements WalletDefaultAccountNames {
  _WalletDefaultAccountNames(
      {@MultisigTypeConverter()
      final Map<MultisigType, String> multisig = defaultMultisigNames,
      this.walletV3 = 'WalletV3',
      this.highloadWalletV2 = 'Highload WalletV2',
      this.everWallet = 'Ever Wallet',
      this.walletV3R1 = 'WalletV3R1',
      this.walletV3R2 = 'WalletV3R2',
      this.walletV4R1 = 'WalletV4R1',
      this.walletV4R2 = 'WalletV4R2',
      this.walletV5R1 = 'WalletV5R1'})
      : _multisig = multisig;
  factory _WalletDefaultAccountNames.fromJson(Map<String, dynamic> json) =>
      _$WalletDefaultAccountNamesFromJson(json);

  final Map<MultisigType, String> _multisig;
  @override
  @JsonKey()
  @MultisigTypeConverter()
  Map<MultisigType, String> get multisig {
    if (_multisig is EqualUnmodifiableMapView) return _multisig;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableMapView(_multisig);
  }

  @override
  @JsonKey()
  final String walletV3;
  @override
  @JsonKey()
  final String highloadWalletV2;
  @override
  @JsonKey()
  final String everWallet;
  @override
  @JsonKey()
  final String walletV3R1;
  @override
  @JsonKey()
  final String walletV3R2;
  @override
  @JsonKey()
  final String walletV4R1;
  @override
  @JsonKey()
  final String walletV4R2;
  @override
  @JsonKey()
  final String walletV5R1;

  /// Create a copy of WalletDefaultAccountNames
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  @pragma('vm:prefer-inline')
  _$WalletDefaultAccountNamesCopyWith<_WalletDefaultAccountNames>
      get copyWith =>
          __$WalletDefaultAccountNamesCopyWithImpl<_WalletDefaultAccountNames>(
              this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$WalletDefaultAccountNamesToJson(
      this,
    );
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _WalletDefaultAccountNames &&
            const DeepCollectionEquality().equals(other._multisig, _multisig) &&
            (identical(other.walletV3, walletV3) ||
                other.walletV3 == walletV3) &&
            (identical(other.highloadWalletV2, highloadWalletV2) ||
                other.highloadWalletV2 == highloadWalletV2) &&
            (identical(other.everWallet, everWallet) ||
                other.everWallet == everWallet) &&
            (identical(other.walletV3R1, walletV3R1) ||
                other.walletV3R1 == walletV3R1) &&
            (identical(other.walletV3R2, walletV3R2) ||
                other.walletV3R2 == walletV3R2) &&
            (identical(other.walletV4R1, walletV4R1) ||
                other.walletV4R1 == walletV4R1) &&
            (identical(other.walletV4R2, walletV4R2) ||
                other.walletV4R2 == walletV4R2) &&
            (identical(other.walletV5R1, walletV5R1) ||
                other.walletV5R1 == walletV5R1));
  }

  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  int get hashCode => Object.hash(
      runtimeType,
      const DeepCollectionEquality().hash(_multisig),
      walletV3,
      highloadWalletV2,
      everWallet,
      walletV3R1,
      walletV3R2,
      walletV4R1,
      walletV4R2,
      walletV5R1);

  @override
  String toString() {
    return 'WalletDefaultAccountNames(multisig: $multisig, walletV3: $walletV3, highloadWalletV2: $highloadWalletV2, everWallet: $everWallet, walletV3R1: $walletV3R1, walletV3R2: $walletV3R2, walletV4R1: $walletV4R1, walletV4R2: $walletV4R2, walletV5R1: $walletV5R1)';
  }
}

/// @nodoc
abstract mixin class _$WalletDefaultAccountNamesCopyWith<$Res>
    implements $WalletDefaultAccountNamesCopyWith<$Res> {
  factory _$WalletDefaultAccountNamesCopyWith(_WalletDefaultAccountNames value,
          $Res Function(_WalletDefaultAccountNames) _then) =
      __$WalletDefaultAccountNamesCopyWithImpl;
  @override
  @useResult
  $Res call(
      {@MultisigTypeConverter() Map<MultisigType, String> multisig,
      String walletV3,
      String highloadWalletV2,
      String everWallet,
      String walletV3R1,
      String walletV3R2,
      String walletV4R1,
      String walletV4R2,
      String walletV5R1});
}

/// @nodoc
class __$WalletDefaultAccountNamesCopyWithImpl<$Res>
    implements _$WalletDefaultAccountNamesCopyWith<$Res> {
  __$WalletDefaultAccountNamesCopyWithImpl(this._self, this._then);

  final _WalletDefaultAccountNames _self;
  final $Res Function(_WalletDefaultAccountNames) _then;

  /// Create a copy of WalletDefaultAccountNames
  /// with the given fields replaced by the non-null parameter values.
  @override
  @pragma('vm:prefer-inline')
  $Res call({
    Object? multisig = null,
    Object? walletV3 = null,
    Object? highloadWalletV2 = null,
    Object? everWallet = null,
    Object? walletV3R1 = null,
    Object? walletV3R2 = null,
    Object? walletV4R1 = null,
    Object? walletV4R2 = null,
    Object? walletV5R1 = null,
  }) {
    return _then(_WalletDefaultAccountNames(
      multisig: null == multisig
          ? _self._multisig
          : multisig // ignore: cast_nullable_to_non_nullable
              as Map<MultisigType, String>,
      walletV3: null == walletV3
          ? _self.walletV3
          : walletV3 // ignore: cast_nullable_to_non_nullable
              as String,
      highloadWalletV2: null == highloadWalletV2
          ? _self.highloadWalletV2
          : highloadWalletV2 // ignore: cast_nullable_to_non_nullable
              as String,
      everWallet: null == everWallet
          ? _self.everWallet
          : everWallet // ignore: cast_nullable_to_non_nullable
              as String,
      walletV3R1: null == walletV3R1
          ? _self.walletV3R1
          : walletV3R1 // ignore: cast_nullable_to_non_nullable
              as String,
      walletV3R2: null == walletV3R2
          ? _self.walletV3R2
          : walletV3R2 // ignore: cast_nullable_to_non_nullable
              as String,
      walletV4R1: null == walletV4R1
          ? _self.walletV4R1
          : walletV4R1 // ignore: cast_nullable_to_non_nullable
              as String,
      walletV4R2: null == walletV4R2
          ? _self.walletV4R2
          : walletV4R2 // ignore: cast_nullable_to_non_nullable
              as String,
      walletV5R1: null == walletV5R1
          ? _self.walletV5R1
          : walletV5R1 // ignore: cast_nullable_to_non_nullable
              as String,
    ));
  }
}

// dart format on
