// dart format width=80
// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'derive_keys_state.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// dart format off
T _$identity<T>(T value) => value;

/// @nodoc
mixin _$DeriveKeysState {
  bool get canPrevPage;
  bool get canNextPage;
  int get currentPageIndex;
  int get pageCount;
  List<DerivedKeyWithIndex> get displayDerivedKeys;
  Set<PublicKey> get selectedKeys;
  Map<PublicKey, String> get keyNames;
  bool get isLoading;
  bool get isCompleted;

  /// Create a copy of DeriveKeysState
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @pragma('vm:prefer-inline')
  $DeriveKeysStateCopyWith<DeriveKeysState> get copyWith =>
      _$DeriveKeysStateCopyWithImpl<DeriveKeysState>(
          this as DeriveKeysState, _$identity);

  @override
  String toString() {
    return 'DeriveKeysState(canPrevPage: $canPrevPage, canNextPage: $canNextPage, currentPageIndex: $currentPageIndex, pageCount: $pageCount, displayDerivedKeys: $displayDerivedKeys, selectedKeys: $selectedKeys, keyNames: $keyNames, isLoading: $isLoading, isCompleted: $isCompleted)';
  }
}

/// @nodoc
abstract mixin class $DeriveKeysStateCopyWith<$Res> {
  factory $DeriveKeysStateCopyWith(
          DeriveKeysState value, $Res Function(DeriveKeysState) _then) =
      _$DeriveKeysStateCopyWithImpl;
  @useResult
  $Res call(
      {bool canPrevPage,
      bool canNextPage,
      int currentPageIndex,
      int pageCount,
      List<DerivedKeyWithIndex> displayDerivedKeys,
      Set<PublicKey> selectedKeys,
      Map<PublicKey, String> keyNames,
      bool isLoading,
      bool isCompleted});
}

/// @nodoc
class _$DeriveKeysStateCopyWithImpl<$Res>
    implements $DeriveKeysStateCopyWith<$Res> {
  _$DeriveKeysStateCopyWithImpl(this._self, this._then);

  final DeriveKeysState _self;
  final $Res Function(DeriveKeysState) _then;

  /// Create a copy of DeriveKeysState
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? canPrevPage = null,
    Object? canNextPage = null,
    Object? currentPageIndex = null,
    Object? pageCount = null,
    Object? displayDerivedKeys = null,
    Object? selectedKeys = null,
    Object? keyNames = null,
    Object? isLoading = null,
    Object? isCompleted = null,
  }) {
    return _then(_self.copyWith(
      canPrevPage: null == canPrevPage
          ? _self.canPrevPage
          : canPrevPage // ignore: cast_nullable_to_non_nullable
              as bool,
      canNextPage: null == canNextPage
          ? _self.canNextPage
          : canNextPage // ignore: cast_nullable_to_non_nullable
              as bool,
      currentPageIndex: null == currentPageIndex
          ? _self.currentPageIndex
          : currentPageIndex // ignore: cast_nullable_to_non_nullable
              as int,
      pageCount: null == pageCount
          ? _self.pageCount
          : pageCount // ignore: cast_nullable_to_non_nullable
              as int,
      displayDerivedKeys: null == displayDerivedKeys
          ? _self.displayDerivedKeys
          : displayDerivedKeys // ignore: cast_nullable_to_non_nullable
              as List<DerivedKeyWithIndex>,
      selectedKeys: null == selectedKeys
          ? _self.selectedKeys
          : selectedKeys // ignore: cast_nullable_to_non_nullable
              as Set<PublicKey>,
      keyNames: null == keyNames
          ? _self.keyNames
          : keyNames // ignore: cast_nullable_to_non_nullable
              as Map<PublicKey, String>,
      isLoading: null == isLoading
          ? _self.isLoading
          : isLoading // ignore: cast_nullable_to_non_nullable
              as bool,
      isCompleted: null == isCompleted
          ? _self.isCompleted
          : isCompleted // ignore: cast_nullable_to_non_nullable
              as bool,
    ));
  }
}

/// @nodoc

class _DeriveKeysState implements DeriveKeysState {
  const _DeriveKeysState(
      {required this.canPrevPage,
      required this.canNextPage,
      required this.currentPageIndex,
      required this.pageCount,
      required final List<DerivedKeyWithIndex> displayDerivedKeys,
      required final Set<PublicKey> selectedKeys,
      required final Map<PublicKey, String> keyNames,
      required this.isLoading,
      required this.isCompleted})
      : _displayDerivedKeys = displayDerivedKeys,
        _selectedKeys = selectedKeys,
        _keyNames = keyNames;

  @override
  final bool canPrevPage;
  @override
  final bool canNextPage;
  @override
  final int currentPageIndex;
  @override
  final int pageCount;
  final List<DerivedKeyWithIndex> _displayDerivedKeys;
  @override
  List<DerivedKeyWithIndex> get displayDerivedKeys {
    if (_displayDerivedKeys is EqualUnmodifiableListView)
      return _displayDerivedKeys;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableListView(_displayDerivedKeys);
  }

  final Set<PublicKey> _selectedKeys;
  @override
  Set<PublicKey> get selectedKeys {
    if (_selectedKeys is EqualUnmodifiableSetView) return _selectedKeys;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableSetView(_selectedKeys);
  }

  final Map<PublicKey, String> _keyNames;
  @override
  Map<PublicKey, String> get keyNames {
    if (_keyNames is EqualUnmodifiableMapView) return _keyNames;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableMapView(_keyNames);
  }

  @override
  final bool isLoading;
  @override
  final bool isCompleted;

  /// Create a copy of DeriveKeysState
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  @pragma('vm:prefer-inline')
  _$DeriveKeysStateCopyWith<_DeriveKeysState> get copyWith =>
      __$DeriveKeysStateCopyWithImpl<_DeriveKeysState>(this, _$identity);

  @override
  String toString() {
    return 'DeriveKeysState(canPrevPage: $canPrevPage, canNextPage: $canNextPage, currentPageIndex: $currentPageIndex, pageCount: $pageCount, displayDerivedKeys: $displayDerivedKeys, selectedKeys: $selectedKeys, keyNames: $keyNames, isLoading: $isLoading, isCompleted: $isCompleted)';
  }
}

/// @nodoc
abstract mixin class _$DeriveKeysStateCopyWith<$Res>
    implements $DeriveKeysStateCopyWith<$Res> {
  factory _$DeriveKeysStateCopyWith(
          _DeriveKeysState value, $Res Function(_DeriveKeysState) _then) =
      __$DeriveKeysStateCopyWithImpl;
  @override
  @useResult
  $Res call(
      {bool canPrevPage,
      bool canNextPage,
      int currentPageIndex,
      int pageCount,
      List<DerivedKeyWithIndex> displayDerivedKeys,
      Set<PublicKey> selectedKeys,
      Map<PublicKey, String> keyNames,
      bool isLoading,
      bool isCompleted});
}

/// @nodoc
class __$DeriveKeysStateCopyWithImpl<$Res>
    implements _$DeriveKeysStateCopyWith<$Res> {
  __$DeriveKeysStateCopyWithImpl(this._self, this._then);

  final _DeriveKeysState _self;
  final $Res Function(_DeriveKeysState) _then;

  /// Create a copy of DeriveKeysState
  /// with the given fields replaced by the non-null parameter values.
  @override
  @pragma('vm:prefer-inline')
  $Res call({
    Object? canPrevPage = null,
    Object? canNextPage = null,
    Object? currentPageIndex = null,
    Object? pageCount = null,
    Object? displayDerivedKeys = null,
    Object? selectedKeys = null,
    Object? keyNames = null,
    Object? isLoading = null,
    Object? isCompleted = null,
  }) {
    return _then(_DeriveKeysState(
      canPrevPage: null == canPrevPage
          ? _self.canPrevPage
          : canPrevPage // ignore: cast_nullable_to_non_nullable
              as bool,
      canNextPage: null == canNextPage
          ? _self.canNextPage
          : canNextPage // ignore: cast_nullable_to_non_nullable
              as bool,
      currentPageIndex: null == currentPageIndex
          ? _self.currentPageIndex
          : currentPageIndex // ignore: cast_nullable_to_non_nullable
              as int,
      pageCount: null == pageCount
          ? _self.pageCount
          : pageCount // ignore: cast_nullable_to_non_nullable
              as int,
      displayDerivedKeys: null == displayDerivedKeys
          ? _self._displayDerivedKeys
          : displayDerivedKeys // ignore: cast_nullable_to_non_nullable
              as List<DerivedKeyWithIndex>,
      selectedKeys: null == selectedKeys
          ? _self._selectedKeys
          : selectedKeys // ignore: cast_nullable_to_non_nullable
              as Set<PublicKey>,
      keyNames: null == keyNames
          ? _self._keyNames
          : keyNames // ignore: cast_nullable_to_non_nullable
              as Map<PublicKey, String>,
      isLoading: null == isLoading
          ? _self.isLoading
          : isLoading // ignore: cast_nullable_to_non_nullable
              as bool,
      isCompleted: null == isCompleted
          ? _self.isCompleted
          : isCompleted // ignore: cast_nullable_to_non_nullable
              as bool,
    ));
  }
}

// dart format on
