// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'nft_prepare_transfer_data.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
    'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#adding-getters-and-methods-to-our-models');

/// @nodoc
mixin _$NftPrepareTransferData {
  KeyAccount get account => throw _privateConstructorUsedError;
  PublicKey get custodian => throw _privateConstructorUsedError;
  NftItem get item => throw _privateConstructorUsedError;
  NftCollection get collection => throw _privateConstructorUsedError;
  List<PublicKey>? get localCustodians => throw _privateConstructorUsedError;

  /// Create a copy of NftPrepareTransferData
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  $NftPrepareTransferDataCopyWith<NftPrepareTransferData> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $NftPrepareTransferDataCopyWith<$Res> {
  factory $NftPrepareTransferDataCopyWith(NftPrepareTransferData value,
          $Res Function(NftPrepareTransferData) then) =
      _$NftPrepareTransferDataCopyWithImpl<$Res, NftPrepareTransferData>;
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
class _$NftPrepareTransferDataCopyWithImpl<$Res,
        $Val extends NftPrepareTransferData>
    implements $NftPrepareTransferDataCopyWith<$Res> {
  _$NftPrepareTransferDataCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

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
    return _then(_value.copyWith(
      account: null == account
          ? _value.account
          : account // ignore: cast_nullable_to_non_nullable
              as KeyAccount,
      custodian: null == custodian
          ? _value.custodian
          : custodian // ignore: cast_nullable_to_non_nullable
              as PublicKey,
      item: null == item
          ? _value.item
          : item // ignore: cast_nullable_to_non_nullable
              as NftItem,
      collection: null == collection
          ? _value.collection
          : collection // ignore: cast_nullable_to_non_nullable
              as NftCollection,
      localCustodians: freezed == localCustodians
          ? _value.localCustodians
          : localCustodians // ignore: cast_nullable_to_non_nullable
              as List<PublicKey>?,
    ) as $Val);
  }

  /// Create a copy of NftPrepareTransferData
  /// with the given fields replaced by the non-null parameter values.
  @override
  @pragma('vm:prefer-inline')
  $PublicKeyCopyWith<$Res> get custodian {
    return $PublicKeyCopyWith<$Res>(_value.custodian, (value) {
      return _then(_value.copyWith(custodian: value) as $Val);
    });
  }

  /// Create a copy of NftPrepareTransferData
  /// with the given fields replaced by the non-null parameter values.
  @override
  @pragma('vm:prefer-inline')
  $NftItemCopyWith<$Res> get item {
    return $NftItemCopyWith<$Res>(_value.item, (value) {
      return _then(_value.copyWith(item: value) as $Val);
    });
  }

  /// Create a copy of NftPrepareTransferData
  /// with the given fields replaced by the non-null parameter values.
  @override
  @pragma('vm:prefer-inline')
  $NftCollectionCopyWith<$Res> get collection {
    return $NftCollectionCopyWith<$Res>(_value.collection, (value) {
      return _then(_value.copyWith(collection: value) as $Val);
    });
  }
}

/// @nodoc
abstract class _$$NftPrepareTransferDataImplCopyWith<$Res>
    implements $NftPrepareTransferDataCopyWith<$Res> {
  factory _$$NftPrepareTransferDataImplCopyWith(
          _$NftPrepareTransferDataImpl value,
          $Res Function(_$NftPrepareTransferDataImpl) then) =
      __$$NftPrepareTransferDataImplCopyWithImpl<$Res>;
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
class __$$NftPrepareTransferDataImplCopyWithImpl<$Res>
    extends _$NftPrepareTransferDataCopyWithImpl<$Res,
        _$NftPrepareTransferDataImpl>
    implements _$$NftPrepareTransferDataImplCopyWith<$Res> {
  __$$NftPrepareTransferDataImplCopyWithImpl(
      _$NftPrepareTransferDataImpl _value,
      $Res Function(_$NftPrepareTransferDataImpl) _then)
      : super(_value, _then);

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
    return _then(_$NftPrepareTransferDataImpl(
      account: null == account
          ? _value.account
          : account // ignore: cast_nullable_to_non_nullable
              as KeyAccount,
      custodian: null == custodian
          ? _value.custodian
          : custodian // ignore: cast_nullable_to_non_nullable
              as PublicKey,
      item: null == item
          ? _value.item
          : item // ignore: cast_nullable_to_non_nullable
              as NftItem,
      collection: null == collection
          ? _value.collection
          : collection // ignore: cast_nullable_to_non_nullable
              as NftCollection,
      localCustodians: freezed == localCustodians
          ? _value._localCustodians
          : localCustodians // ignore: cast_nullable_to_non_nullable
              as List<PublicKey>?,
    ));
  }
}

/// @nodoc

class _$NftPrepareTransferDataImpl implements _NftPrepareTransferData {
  const _$NftPrepareTransferDataImpl(
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

  @override
  String toString() {
    return 'NftPrepareTransferData(account: $account, custodian: $custodian, item: $item, collection: $collection, localCustodians: $localCustodians)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$NftPrepareTransferDataImpl &&
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

  /// Create a copy of NftPrepareTransferData
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$NftPrepareTransferDataImplCopyWith<_$NftPrepareTransferDataImpl>
      get copyWith => __$$NftPrepareTransferDataImplCopyWithImpl<
          _$NftPrepareTransferDataImpl>(this, _$identity);
}

abstract class _NftPrepareTransferData implements NftPrepareTransferData {
  const factory _NftPrepareTransferData(
          {required final KeyAccount account,
          required final PublicKey custodian,
          required final NftItem item,
          required final NftCollection collection,
          required final List<PublicKey>? localCustodians}) =
      _$NftPrepareTransferDataImpl;

  @override
  KeyAccount get account;
  @override
  PublicKey get custodian;
  @override
  NftItem get item;
  @override
  NftCollection get collection;
  @override
  List<PublicKey>? get localCustodians;

  /// Create a copy of NftPrepareTransferData
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$NftPrepareTransferDataImplCopyWith<_$NftPrepareTransferDataImpl>
      get copyWith => throw _privateConstructorUsedError;
}
