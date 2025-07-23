// dart format width=80
// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'derive_keys_cubit.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// dart format off
T _$identity<T>(T value) => value;

/// @nodoc
mixin _$DeriveKeysState {
  @override
  String toString() {
    return 'DeriveKeysState()';
  }
}

/// @nodoc
class $DeriveKeysStateCopyWith<$Res> {
  $DeriveKeysStateCopyWith(
      DeriveKeysState _, $Res Function(DeriveKeysState) __);
}

/// @nodoc

class DeriveKeysStateInitial implements DeriveKeysState {
  const DeriveKeysStateInitial();

  @override
  String toString() {
    return 'DeriveKeysState.initial()';
  }
}

/// @nodoc

class DeriveKeysStateData implements DeriveKeysState {
  const DeriveKeysStateData(
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

  final bool canPrevPage;
  final bool canNextPage;
  final int currentPageIndex;
  final int pageCount;
  final List<DerivedKeyWithIndex> _displayDerivedKeys;
  List<DerivedKeyWithIndex> get displayDerivedKeys {
    if (_displayDerivedKeys is EqualUnmodifiableListView)
      return _displayDerivedKeys;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableListView(_displayDerivedKeys);
  }

  final Set<PublicKey> _selectedKeys;
  Set<PublicKey> get selectedKeys {
    if (_selectedKeys is EqualUnmodifiableSetView) return _selectedKeys;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableSetView(_selectedKeys);
  }

  final Map<PublicKey, String> _keyNames;
  Map<PublicKey, String> get keyNames {
    if (_keyNames is EqualUnmodifiableMapView) return _keyNames;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableMapView(_keyNames);
  }

  final bool isLoading;
  final bool isCompleted;

  /// Create a copy of DeriveKeysState
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @pragma('vm:prefer-inline')
  $DeriveKeysStateDataCopyWith<DeriveKeysStateData> get copyWith =>
      _$DeriveKeysStateDataCopyWithImpl<DeriveKeysStateData>(this, _$identity);

  @override
  String toString() {
    return 'DeriveKeysState.data(canPrevPage: $canPrevPage, canNextPage: $canNextPage, currentPageIndex: $currentPageIndex, pageCount: $pageCount, displayDerivedKeys: $displayDerivedKeys, selectedKeys: $selectedKeys, keyNames: $keyNames, isLoading: $isLoading, isCompleted: $isCompleted)';
  }
}

/// @nodoc
abstract mixin class $DeriveKeysStateDataCopyWith<$Res>
    implements $DeriveKeysStateCopyWith<$Res> {
  factory $DeriveKeysStateDataCopyWith(
          DeriveKeysStateData value, $Res Function(DeriveKeysStateData) _then) =
      _$DeriveKeysStateDataCopyWithImpl;
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
class _$DeriveKeysStateDataCopyWithImpl<$Res>
    implements $DeriveKeysStateDataCopyWith<$Res> {
  _$DeriveKeysStateDataCopyWithImpl(this._self, this._then);

  final DeriveKeysStateData _self;
  final $Res Function(DeriveKeysStateData) _then;

  /// Create a copy of DeriveKeysState
  /// with the given fields replaced by the non-null parameter values.
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
    return _then(DeriveKeysStateData(
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
