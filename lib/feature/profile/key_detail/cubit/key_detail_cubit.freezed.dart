// dart format width=80
// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'key_detail_cubit.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// dart format off
T _$identity<T>(T value) => value;

/// @nodoc
mixin _$KeyDetailState {
  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType && other is KeyDetailState);
  }

  @override
  int get hashCode => runtimeType.hashCode;

  @override
  String toString() {
    return 'KeyDetailState()';
  }
}

/// @nodoc
class $KeyDetailStateCopyWith<$Res> {
  $KeyDetailStateCopyWith(KeyDetailState _, $Res Function(KeyDetailState) __);
}

/// @nodoc

class KeyDetailStateInitial implements KeyDetailState {
  const KeyDetailStateInitial();

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType && other is KeyDetailStateInitial);
  }

  @override
  int get hashCode => runtimeType.hashCode;

  @override
  String toString() {
    return 'KeyDetailState.initial()';
  }
}

/// @nodoc

class KeyDetailStateEmpty implements KeyDetailState {
  const KeyDetailStateEmpty();

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType && other is KeyDetailStateEmpty);
  }

  @override
  int get hashCode => runtimeType.hashCode;

  @override
  String toString() {
    return 'KeyDetailState.empty()';
  }
}

/// @nodoc

class KeyDetailStateData implements KeyDetailState {
  const KeyDetailStateData(this.key, this.ownerSeedName, this.accountsTab);

  final SeedKey key;
  final String ownerSeedName;
  final KeyDetailAccountsTab accountsTab;

  /// Create a copy of KeyDetailState
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @pragma('vm:prefer-inline')
  $KeyDetailStateDataCopyWith<KeyDetailStateData> get copyWith =>
      _$KeyDetailStateDataCopyWithImpl<KeyDetailStateData>(this, _$identity);

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is KeyDetailStateData &&
            (identical(other.key, key) || other.key == key) &&
            (identical(other.ownerSeedName, ownerSeedName) ||
                other.ownerSeedName == ownerSeedName) &&
            (identical(other.accountsTab, accountsTab) ||
                other.accountsTab == accountsTab));
  }

  @override
  int get hashCode => Object.hash(runtimeType, key, ownerSeedName, accountsTab);

  @override
  String toString() {
    return 'KeyDetailState.data(key: $key, ownerSeedName: $ownerSeedName, accountsTab: $accountsTab)';
  }
}

/// @nodoc
abstract mixin class $KeyDetailStateDataCopyWith<$Res>
    implements $KeyDetailStateCopyWith<$Res> {
  factory $KeyDetailStateDataCopyWith(
          KeyDetailStateData value, $Res Function(KeyDetailStateData) _then) =
      _$KeyDetailStateDataCopyWithImpl;
  @useResult
  $Res call(
      {SeedKey key, String ownerSeedName, KeyDetailAccountsTab accountsTab});
}

/// @nodoc
class _$KeyDetailStateDataCopyWithImpl<$Res>
    implements $KeyDetailStateDataCopyWith<$Res> {
  _$KeyDetailStateDataCopyWithImpl(this._self, this._then);

  final KeyDetailStateData _self;
  final $Res Function(KeyDetailStateData) _then;

  /// Create a copy of KeyDetailState
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  $Res call({
    Object? key = null,
    Object? ownerSeedName = null,
    Object? accountsTab = null,
  }) {
    return _then(KeyDetailStateData(
      null == key
          ? _self.key
          : key // ignore: cast_nullable_to_non_nullable
              as SeedKey,
      null == ownerSeedName
          ? _self.ownerSeedName
          : ownerSeedName // ignore: cast_nullable_to_non_nullable
              as String,
      null == accountsTab
          ? _self.accountsTab
          : accountsTab // ignore: cast_nullable_to_non_nullable
              as KeyDetailAccountsTab,
    ));
  }
}

// dart format on
