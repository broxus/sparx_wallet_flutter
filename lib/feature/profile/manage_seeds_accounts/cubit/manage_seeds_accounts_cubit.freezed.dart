// dart format width=80
// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'manage_seeds_accounts_cubit.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// dart format off
T _$identity<T>(T value) => value;

/// @nodoc
mixin _$ManageSeedsAccountsState {
  Seed? get currentSeed;
  List<Seed> get seeds;

  /// Create a copy of ManageSeedsAccountsState
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @pragma('vm:prefer-inline')
  $ManageSeedsAccountsStateCopyWith<ManageSeedsAccountsState> get copyWith =>
      _$ManageSeedsAccountsStateCopyWithImpl<ManageSeedsAccountsState>(
          this as ManageSeedsAccountsState, _$identity);

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is ManageSeedsAccountsState &&
            (identical(other.currentSeed, currentSeed) ||
                other.currentSeed == currentSeed) &&
            const DeepCollectionEquality().equals(other.seeds, seeds));
  }

  @override
  int get hashCode => Object.hash(
      runtimeType, currentSeed, const DeepCollectionEquality().hash(seeds));

  @override
  String toString() {
    return 'ManageSeedsAccountsState(currentSeed: $currentSeed, seeds: $seeds)';
  }
}

/// @nodoc
abstract mixin class $ManageSeedsAccountsStateCopyWith<$Res> {
  factory $ManageSeedsAccountsStateCopyWith(ManageSeedsAccountsState value,
          $Res Function(ManageSeedsAccountsState) _then) =
      _$ManageSeedsAccountsStateCopyWithImpl;
  @useResult
  $Res call({Seed? currentSeed, List<Seed> seeds});
}

/// @nodoc
class _$ManageSeedsAccountsStateCopyWithImpl<$Res>
    implements $ManageSeedsAccountsStateCopyWith<$Res> {
  _$ManageSeedsAccountsStateCopyWithImpl(this._self, this._then);

  final ManageSeedsAccountsState _self;
  final $Res Function(ManageSeedsAccountsState) _then;

  /// Create a copy of ManageSeedsAccountsState
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? currentSeed = freezed,
    Object? seeds = null,
  }) {
    return _then(_self.copyWith(
      currentSeed: freezed == currentSeed
          ? _self.currentSeed
          : currentSeed // ignore: cast_nullable_to_non_nullable
              as Seed?,
      seeds: null == seeds
          ? _self.seeds
          : seeds // ignore: cast_nullable_to_non_nullable
              as List<Seed>,
    ));
  }
}

/// @nodoc

class _Data implements ManageSeedsAccountsState {
  const _Data({required this.currentSeed, required final List<Seed> seeds})
      : _seeds = seeds;

  @override
  final Seed? currentSeed;
  final List<Seed> _seeds;
  @override
  List<Seed> get seeds {
    if (_seeds is EqualUnmodifiableListView) return _seeds;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableListView(_seeds);
  }

  /// Create a copy of ManageSeedsAccountsState
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  @pragma('vm:prefer-inline')
  _$DataCopyWith<_Data> get copyWith =>
      __$DataCopyWithImpl<_Data>(this, _$identity);

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _Data &&
            (identical(other.currentSeed, currentSeed) ||
                other.currentSeed == currentSeed) &&
            const DeepCollectionEquality().equals(other._seeds, _seeds));
  }

  @override
  int get hashCode => Object.hash(
      runtimeType, currentSeed, const DeepCollectionEquality().hash(_seeds));

  @override
  String toString() {
    return 'ManageSeedsAccountsState.data(currentSeed: $currentSeed, seeds: $seeds)';
  }
}

/// @nodoc
abstract mixin class _$DataCopyWith<$Res>
    implements $ManageSeedsAccountsStateCopyWith<$Res> {
  factory _$DataCopyWith(_Data value, $Res Function(_Data) _then) =
      __$DataCopyWithImpl;
  @override
  @useResult
  $Res call({Seed? currentSeed, List<Seed> seeds});
}

/// @nodoc
class __$DataCopyWithImpl<$Res> implements _$DataCopyWith<$Res> {
  __$DataCopyWithImpl(this._self, this._then);

  final _Data _self;
  final $Res Function(_Data) _then;

  /// Create a copy of ManageSeedsAccountsState
  /// with the given fields replaced by the non-null parameter values.
  @override
  @pragma('vm:prefer-inline')
  $Res call({
    Object? currentSeed = freezed,
    Object? seeds = null,
  }) {
    return _then(_Data(
      currentSeed: freezed == currentSeed
          ? _self.currentSeed
          : currentSeed // ignore: cast_nullable_to_non_nullable
              as Seed?,
      seeds: null == seeds
          ? _self._seeds
          : seeds // ignore: cast_nullable_to_non_nullable
              as List<Seed>,
    ));
  }
}

// dart format on
