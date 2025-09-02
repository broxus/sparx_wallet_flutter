// GENERATED CODE - DO NOT MODIFY BY HAND
// coverage:ignore-file
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'nft_prepare_transfer_data.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// dart format off
T _$identity<T>(T value) => value;

/// @nodoc
mixin _$NftPrepareTransferData {
  KeyAccount get account;
  PublicKey get custodian;
  NftItem get item;
  NftCollection get collection;
  List<PublicKey>? get localCustodians;

  /// Create a copy of NftPrepareTransferData
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @pragma('vm:prefer-inline')
  $NftPrepareTransferDataCopyWith<NftPrepareTransferData> get copyWith =>
      _$NftPrepareTransferDataCopyWithImpl<NftPrepareTransferData>(
          this as NftPrepareTransferData, _$identity);

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is NftPrepareTransferData &&
            (identical(other.account, account) || other.account == account) &&
            (identical(other.custodian, custodian) ||
                other.custodian == custodian) &&
            (identical(other.item, item) || other.item == item) &&
            (identical(other.collection, collection) ||
                other.collection == collection) &&
            const DeepCollectionEquality()
                .equals(other.localCustodians, localCustodians));
  }

  @override
  int get hashCode => Object.hash(runtimeType, account, custodian, item,
      collection, const DeepCollectionEquality().hash(localCustodians));

  @override
  String toString() {
    return 'NftPrepareTransferData(account: $account, custodian: $custodian, item: $item, collection: $collection, localCustodians: $localCustodians)';
  }
}

/// @nodoc
abstract mixin class $NftPrepareTransferDataCopyWith<$Res> {
  factory $NftPrepareTransferDataCopyWith(NftPrepareTransferData value,
          $Res Function(NftPrepareTransferData) _then) =
      _$NftPrepareTransferDataCopyWithImpl;
  @useResult
  $Res call(
      {KeyAccount account,
      PublicKey custodian,
      NftItem item,
      NftCollection collection,
      List<PublicKey>? localCustodians});

  $PublicKeyCopyWith<$Res> get custodian;
  $NftItemCopyWith<$Res> get item;
  $NftCollectionCopyWith<$Res> get collection;
}

/// @nodoc
class _$NftPrepareTransferDataCopyWithImpl<$Res>
    implements $NftPrepareTransferDataCopyWith<$Res> {
  _$NftPrepareTransferDataCopyWithImpl(this._self, this._then);

  final NftPrepareTransferData _self;
  final $Res Function(NftPrepareTransferData) _then;

  /// Create a copy of NftPrepareTransferData
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? account = null,
    Object? custodian = null,
    Object? item = null,
    Object? collection = null,
    Object? localCustodians = freezed,
  }) {
    return _then(_self.copyWith(
      account: null == account
          ? _self.account
          : account // ignore: cast_nullable_to_non_nullable
              as KeyAccount,
      custodian: null == custodian
          ? _self.custodian
          : custodian // ignore: cast_nullable_to_non_nullable
              as PublicKey,
      item: null == item
          ? _self.item
          : item // ignore: cast_nullable_to_non_nullable
              as NftItem,
      collection: null == collection
          ? _self.collection
          : collection // ignore: cast_nullable_to_non_nullable
              as NftCollection,
      localCustodians: freezed == localCustodians
          ? _self.localCustodians
          : localCustodians // ignore: cast_nullable_to_non_nullable
              as List<PublicKey>?,
    ));
  }

  /// Create a copy of NftPrepareTransferData
  /// with the given fields replaced by the non-null parameter values.
  @override
  @pragma('vm:prefer-inline')
  $PublicKeyCopyWith<$Res> get custodian {
    return $PublicKeyCopyWith<$Res>(_self.custodian, (value) {
      return _then(_self.copyWith(custodian: value));
    });
  }

  /// Create a copy of NftPrepareTransferData
  /// with the given fields replaced by the non-null parameter values.
  @override
  @pragma('vm:prefer-inline')
  $NftItemCopyWith<$Res> get item {
    return $NftItemCopyWith<$Res>(_self.item, (value) {
      return _then(_self.copyWith(item: value));
    });
  }

  /// Create a copy of NftPrepareTransferData
  /// with the given fields replaced by the non-null parameter values.
  @override
  @pragma('vm:prefer-inline')
  $NftCollectionCopyWith<$Res> get collection {
    return $NftCollectionCopyWith<$Res>(_self.collection, (value) {
      return _then(_self.copyWith(collection: value));
    });
  }
}

/// Adds pattern-matching-related methods to [NftPrepareTransferData].
extension NftPrepareTransferDataPatterns on NftPrepareTransferData {
  /// A variant of `map` that fallback to returning `orElse`.
  ///
  /// It is equivalent to doing:
  /// ```dart
  /// switch (sealedClass) {
  ///   case final Subclass value:
  ///     return ...;
  ///   case _:
  ///     return orElse();
  /// }
  /// ```

  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>(
    TResult Function(_NftPrepareTransferData value)? $default, {
    required TResult orElse(),
  }) {
    final _that = this;
    switch (_that) {
      case _NftPrepareTransferData() when $default != null:
        return $default(_that);
      case _:
        return orElse();
    }
  }

  /// A `switch`-like method, using callbacks.
  ///
  /// Callbacks receives the raw object, upcasted.
  /// It is equivalent to doing:
  /// ```dart
  /// switch (sealedClass) {
  ///   case final Subclass value:
  ///     return ...;
  ///   case final Subclass2 value:
  ///     return ...;
  /// }
  /// ```

  @optionalTypeArgs
  TResult map<TResult extends Object?>(
    TResult Function(_NftPrepareTransferData value) $default,
  ) {
    final _that = this;
    switch (_that) {
      case _NftPrepareTransferData():
        return $default(_that);
      case _:
        throw StateError('Unexpected subclass');
    }
  }

  /// A variant of `map` that fallback to returning `null`.
  ///
  /// It is equivalent to doing:
  /// ```dart
  /// switch (sealedClass) {
  ///   case final Subclass value:
  ///     return ...;
  ///   case _:
  ///     return null;
  /// }
  /// ```

  @optionalTypeArgs
  TResult? mapOrNull<TResult extends Object?>(
    TResult? Function(_NftPrepareTransferData value)? $default,
  ) {
    final _that = this;
    switch (_that) {
      case _NftPrepareTransferData() when $default != null:
        return $default(_that);
      case _:
        return null;
    }
  }

  /// A variant of `when` that fallback to an `orElse` callback.
  ///
  /// It is equivalent to doing:
  /// ```dart
  /// switch (sealedClass) {
  ///   case Subclass(:final field):
  ///     return ...;
  ///   case _:
  ///     return orElse();
  /// }
  /// ```

  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>(
    TResult Function(KeyAccount account, PublicKey custodian, NftItem item,
            NftCollection collection, List<PublicKey>? localCustodians)?
        $default, {
    required TResult orElse(),
  }) {
    final _that = this;
    switch (_that) {
      case _NftPrepareTransferData() when $default != null:
        return $default(_that.account, _that.custodian, _that.item,
            _that.collection, _that.localCustodians);
      case _:
        return orElse();
    }
  }

  /// A `switch`-like method, using callbacks.
  ///
  /// As opposed to `map`, this offers destructuring.
  /// It is equivalent to doing:
  /// ```dart
  /// switch (sealedClass) {
  ///   case Subclass(:final field):
  ///     return ...;
  ///   case Subclass2(:final field2):
  ///     return ...;
  /// }
  /// ```

  @optionalTypeArgs
  TResult when<TResult extends Object?>(
    TResult Function(KeyAccount account, PublicKey custodian, NftItem item,
            NftCollection collection, List<PublicKey>? localCustodians)
        $default,
  ) {
    final _that = this;
    switch (_that) {
      case _NftPrepareTransferData():
        return $default(_that.account, _that.custodian, _that.item,
            _that.collection, _that.localCustodians);
      case _:
        throw StateError('Unexpected subclass');
    }
  }

  /// A variant of `when` that fallback to returning `null`
  ///
  /// It is equivalent to doing:
  /// ```dart
  /// switch (sealedClass) {
  ///   case Subclass(:final field):
  ///     return ...;
  ///   case _:
  ///     return null;
  /// }
  /// ```

  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>(
    TResult? Function(KeyAccount account, PublicKey custodian, NftItem item,
            NftCollection collection, List<PublicKey>? localCustodians)?
        $default,
  ) {
    final _that = this;
    switch (_that) {
      case _NftPrepareTransferData() when $default != null:
        return $default(_that.account, _that.custodian, _that.item,
            _that.collection, _that.localCustodians);
      case _:
        return null;
    }
  }
}

/// @nodoc

class _NftPrepareTransferData implements NftPrepareTransferData {
  const _NftPrepareTransferData(
      {required this.account,
      required this.custodian,
      required this.item,
      required this.collection,
      required final List<PublicKey>? localCustodians})
      : _localCustodians = localCustodians;

  @override
  final KeyAccount account;
  @override
  final PublicKey custodian;
  @override
  final NftItem item;
  @override
  final NftCollection collection;
  final List<PublicKey>? _localCustodians;
  @override
  List<PublicKey>? get localCustodians {
    final value = _localCustodians;
    if (value == null) return null;
    if (_localCustodians is EqualUnmodifiableListView) return _localCustodians;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableListView(value);
  }

  /// Create a copy of NftPrepareTransferData
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  @pragma('vm:prefer-inline')
  _$NftPrepareTransferDataCopyWith<_NftPrepareTransferData> get copyWith =>
      __$NftPrepareTransferDataCopyWithImpl<_NftPrepareTransferData>(
          this, _$identity);

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _NftPrepareTransferData &&
            (identical(other.account, account) || other.account == account) &&
            (identical(other.custodian, custodian) ||
                other.custodian == custodian) &&
            (identical(other.item, item) || other.item == item) &&
            (identical(other.collection, collection) ||
                other.collection == collection) &&
            const DeepCollectionEquality()
                .equals(other._localCustodians, _localCustodians));
  }

  @override
  int get hashCode => Object.hash(runtimeType, account, custodian, item,
      collection, const DeepCollectionEquality().hash(_localCustodians));

  @override
  String toString() {
    return 'NftPrepareTransferData(account: $account, custodian: $custodian, item: $item, collection: $collection, localCustodians: $localCustodians)';
  }
}

/// @nodoc
abstract mixin class _$NftPrepareTransferDataCopyWith<$Res>
    implements $NftPrepareTransferDataCopyWith<$Res> {
  factory _$NftPrepareTransferDataCopyWith(_NftPrepareTransferData value,
          $Res Function(_NftPrepareTransferData) _then) =
      __$NftPrepareTransferDataCopyWithImpl;
  @override
  @useResult
  $Res call(
      {KeyAccount account,
      PublicKey custodian,
      NftItem item,
      NftCollection collection,
      List<PublicKey>? localCustodians});

  @override
  $PublicKeyCopyWith<$Res> get custodian;
  @override
  $NftItemCopyWith<$Res> get item;
  @override
  $NftCollectionCopyWith<$Res> get collection;
}

/// @nodoc
class __$NftPrepareTransferDataCopyWithImpl<$Res>
    implements _$NftPrepareTransferDataCopyWith<$Res> {
  __$NftPrepareTransferDataCopyWithImpl(this._self, this._then);

  final _NftPrepareTransferData _self;
  final $Res Function(_NftPrepareTransferData) _then;

  /// Create a copy of NftPrepareTransferData
  /// with the given fields replaced by the non-null parameter values.
  @override
  @pragma('vm:prefer-inline')
  $Res call({
    Object? account = null,
    Object? custodian = null,
    Object? item = null,
    Object? collection = null,
    Object? localCustodians = freezed,
  }) {
    return _then(_NftPrepareTransferData(
      account: null == account
          ? _self.account
          : account // ignore: cast_nullable_to_non_nullable
              as KeyAccount,
      custodian: null == custodian
          ? _self.custodian
          : custodian // ignore: cast_nullable_to_non_nullable
              as PublicKey,
      item: null == item
          ? _self.item
          : item // ignore: cast_nullable_to_non_nullable
              as NftItem,
      collection: null == collection
          ? _self.collection
          : collection // ignore: cast_nullable_to_non_nullable
              as NftCollection,
      localCustodians: freezed == localCustodians
          ? _self._localCustodians
          : localCustodians // ignore: cast_nullable_to_non_nullable
              as List<PublicKey>?,
    ));
  }

  /// Create a copy of NftPrepareTransferData
  /// with the given fields replaced by the non-null parameter values.
  @override
  @pragma('vm:prefer-inline')
  $PublicKeyCopyWith<$Res> get custodian {
    return $PublicKeyCopyWith<$Res>(_self.custodian, (value) {
      return _then(_self.copyWith(custodian: value));
    });
  }

  /// Create a copy of NftPrepareTransferData
  /// with the given fields replaced by the non-null parameter values.
  @override
  @pragma('vm:prefer-inline')
  $NftItemCopyWith<$Res> get item {
    return $NftItemCopyWith<$Res>(_self.item, (value) {
      return _then(_self.copyWith(item: value));
    });
  }

  /// Create a copy of NftPrepareTransferData
  /// with the given fields replaced by the non-null parameter values.
  @override
  @pragma('vm:prefer-inline')
  $NftCollectionCopyWith<$Res> get collection {
    return $NftCollectionCopyWith<$Res>(_self.collection, (value) {
      return _then(_self.copyWith(collection: value));
    });
  }
}

// dart format on
