// dart format width=80
// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'select_new_asset_cubit.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// dart format off
T _$identity<T>(T value) => value;

/// @nodoc
mixin _$SelectNewAssetState {
  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType && other is SelectNewAssetState);
  }

  @override
  int get hashCode => runtimeType.hashCode;

  @override
  String toString() {
    return 'SelectNewAssetState()';
  }
}

/// @nodoc
class $SelectNewAssetStateCopyWith<$Res> {
  $SelectNewAssetStateCopyWith(
      SelectNewAssetState _, $Res Function(SelectNewAssetState) __);
}

/// @nodoc

class SelectNewAssetStateCompleted implements SelectNewAssetState {
  const SelectNewAssetStateCompleted();

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is SelectNewAssetStateCompleted);
  }

  @override
  int get hashCode => runtimeType.hashCode;

  @override
  String toString() {
    return 'SelectNewAssetState.completed()';
  }
}

/// @nodoc

class SelectNewAssetStateData implements SelectNewAssetState {
  const SelectNewAssetStateData(
      {required this.tab,
      required this.isLoading,
      required this.showButton,
      this.account,
      final List<(TokenContractAsset, bool)>? contracts})
      : _contracts = contracts;

  final SelectNewAssetTabs tab;
// loading blocks actions
  final bool isLoading;
  final bool showButton;
  final KeyAccount? account;
  final List<(TokenContractAsset, bool)>? _contracts;
  List<(TokenContractAsset, bool)>? get contracts {
    final value = _contracts;
    if (value == null) return null;
    if (_contracts is EqualUnmodifiableListView) return _contracts;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableListView(value);
  }

  /// Create a copy of SelectNewAssetState
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @pragma('vm:prefer-inline')
  $SelectNewAssetStateDataCopyWith<SelectNewAssetStateData> get copyWith =>
      _$SelectNewAssetStateDataCopyWithImpl<SelectNewAssetStateData>(
          this, _$identity);

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is SelectNewAssetStateData &&
            (identical(other.tab, tab) || other.tab == tab) &&
            (identical(other.isLoading, isLoading) ||
                other.isLoading == isLoading) &&
            (identical(other.showButton, showButton) ||
                other.showButton == showButton) &&
            (identical(other.account, account) || other.account == account) &&
            const DeepCollectionEquality()
                .equals(other._contracts, _contracts));
  }

  @override
  int get hashCode => Object.hash(runtimeType, tab, isLoading, showButton,
      account, const DeepCollectionEquality().hash(_contracts));

  @override
  String toString() {
    return 'SelectNewAssetState.data(tab: $tab, isLoading: $isLoading, showButton: $showButton, account: $account, contracts: $contracts)';
  }
}

/// @nodoc
abstract mixin class $SelectNewAssetStateDataCopyWith<$Res>
    implements $SelectNewAssetStateCopyWith<$Res> {
  factory $SelectNewAssetStateDataCopyWith(SelectNewAssetStateData value,
          $Res Function(SelectNewAssetStateData) _then) =
      _$SelectNewAssetStateDataCopyWithImpl;
  @useResult
  $Res call(
      {SelectNewAssetTabs tab,
      bool isLoading,
      bool showButton,
      KeyAccount? account,
      List<(TokenContractAsset, bool)>? contracts});
}

/// @nodoc
class _$SelectNewAssetStateDataCopyWithImpl<$Res>
    implements $SelectNewAssetStateDataCopyWith<$Res> {
  _$SelectNewAssetStateDataCopyWithImpl(this._self, this._then);

  final SelectNewAssetStateData _self;
  final $Res Function(SelectNewAssetStateData) _then;

  /// Create a copy of SelectNewAssetState
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  $Res call({
    Object? tab = null,
    Object? isLoading = null,
    Object? showButton = null,
    Object? account = freezed,
    Object? contracts = freezed,
  }) {
    return _then(SelectNewAssetStateData(
      tab: null == tab
          ? _self.tab
          : tab // ignore: cast_nullable_to_non_nullable
              as SelectNewAssetTabs,
      isLoading: null == isLoading
          ? _self.isLoading
          : isLoading // ignore: cast_nullable_to_non_nullable
              as bool,
      showButton: null == showButton
          ? _self.showButton
          : showButton // ignore: cast_nullable_to_non_nullable
              as bool,
      account: freezed == account
          ? _self.account
          : account // ignore: cast_nullable_to_non_nullable
              as KeyAccount?,
      contracts: freezed == contracts
          ? _self._contracts
          : contracts // ignore: cast_nullable_to_non_nullable
              as List<(TokenContractAsset, bool)>?,
    ));
  }
}

// dart format on
