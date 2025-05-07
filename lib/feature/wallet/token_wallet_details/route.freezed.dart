// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'route.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
    'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#adding-getters-and-methods-to-our-models');

/// @nodoc
mixin _$TokenWalletDetailsRouteData {
  /// Owner of token wallet
  Address get owner => throw _privateConstructorUsedError;

  /// Root token contract address
  Address get rootTokenContract => throw _privateConstructorUsedError;

  /// Create a copy of TokenWalletDetailsRouteData
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  $TokenWalletDetailsRouteDataCopyWith<TokenWalletDetailsRouteData>
      get copyWith => throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $TokenWalletDetailsRouteDataCopyWith<$Res> {
  factory $TokenWalletDetailsRouteDataCopyWith(
          TokenWalletDetailsRouteData value,
          $Res Function(TokenWalletDetailsRouteData) then) =
      _$TokenWalletDetailsRouteDataCopyWithImpl<$Res,
          TokenWalletDetailsRouteData>;
  @useResult
  $Res call({Address owner, Address rootTokenContract});

  $AddressCopyWith<$Res> get owner;
  $AddressCopyWith<$Res> get rootTokenContract;
}

/// @nodoc
class _$TokenWalletDetailsRouteDataCopyWithImpl<$Res,
        $Val extends TokenWalletDetailsRouteData>
    implements $TokenWalletDetailsRouteDataCopyWith<$Res> {
  _$TokenWalletDetailsRouteDataCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  /// Create a copy of TokenWalletDetailsRouteData
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? owner = null,
    Object? rootTokenContract = null,
  }) {
    return _then(_value.copyWith(
      owner: null == owner
          ? _value.owner
          : owner // ignore: cast_nullable_to_non_nullable
              as Address,
      rootTokenContract: null == rootTokenContract
          ? _value.rootTokenContract
          : rootTokenContract // ignore: cast_nullable_to_non_nullable
              as Address,
    ) as $Val);
  }

  /// Create a copy of TokenWalletDetailsRouteData
  /// with the given fields replaced by the non-null parameter values.
  @override
  @pragma('vm:prefer-inline')
  $AddressCopyWith<$Res> get owner {
    return $AddressCopyWith<$Res>(_value.owner, (value) {
      return _then(_value.copyWith(owner: value) as $Val);
    });
  }

  /// Create a copy of TokenWalletDetailsRouteData
  /// with the given fields replaced by the non-null parameter values.
  @override
  @pragma('vm:prefer-inline')
  $AddressCopyWith<$Res> get rootTokenContract {
    return $AddressCopyWith<$Res>(_value.rootTokenContract, (value) {
      return _then(_value.copyWith(rootTokenContract: value) as $Val);
    });
  }
}

/// @nodoc
abstract class _$$TokenWalletDetailsRouteDataImplCopyWith<$Res>
    implements $TokenWalletDetailsRouteDataCopyWith<$Res> {
  factory _$$TokenWalletDetailsRouteDataImplCopyWith(
          _$TokenWalletDetailsRouteDataImpl value,
          $Res Function(_$TokenWalletDetailsRouteDataImpl) then) =
      __$$TokenWalletDetailsRouteDataImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call({Address owner, Address rootTokenContract});

  @override
  $AddressCopyWith<$Res> get owner;
  @override
  $AddressCopyWith<$Res> get rootTokenContract;
}

/// @nodoc
class __$$TokenWalletDetailsRouteDataImplCopyWithImpl<$Res>
    extends _$TokenWalletDetailsRouteDataCopyWithImpl<$Res,
        _$TokenWalletDetailsRouteDataImpl>
    implements _$$TokenWalletDetailsRouteDataImplCopyWith<$Res> {
  __$$TokenWalletDetailsRouteDataImplCopyWithImpl(
      _$TokenWalletDetailsRouteDataImpl _value,
      $Res Function(_$TokenWalletDetailsRouteDataImpl) _then)
      : super(_value, _then);

  /// Create a copy of TokenWalletDetailsRouteData
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? owner = null,
    Object? rootTokenContract = null,
  }) {
    return _then(_$TokenWalletDetailsRouteDataImpl(
      owner: null == owner
          ? _value.owner
          : owner // ignore: cast_nullable_to_non_nullable
              as Address,
      rootTokenContract: null == rootTokenContract
          ? _value.rootTokenContract
          : rootTokenContract // ignore: cast_nullable_to_non_nullable
              as Address,
    ));
  }
}

/// @nodoc

class _$TokenWalletDetailsRouteDataImpl extends _TokenWalletDetailsRouteData {
  const _$TokenWalletDetailsRouteDataImpl(
      {required this.owner, required this.rootTokenContract})
      : super._();

  /// Owner of token wallet
  @override
  final Address owner;

  /// Root token contract address
  @override
  final Address rootTokenContract;

  @override
  String toString() {
    return 'TokenWalletDetailsRouteData(owner: $owner, rootTokenContract: $rootTokenContract)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$TokenWalletDetailsRouteDataImpl &&
            (identical(other.owner, owner) || other.owner == owner) &&
            (identical(other.rootTokenContract, rootTokenContract) ||
                other.rootTokenContract == rootTokenContract));
  }

  @override
  int get hashCode => Object.hash(runtimeType, owner, rootTokenContract);

  /// Create a copy of TokenWalletDetailsRouteData
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$TokenWalletDetailsRouteDataImplCopyWith<_$TokenWalletDetailsRouteDataImpl>
      get copyWith => __$$TokenWalletDetailsRouteDataImplCopyWithImpl<
          _$TokenWalletDetailsRouteDataImpl>(this, _$identity);
}

abstract class _TokenWalletDetailsRouteData
    extends TokenWalletDetailsRouteData {
  const factory _TokenWalletDetailsRouteData(
          {required final Address owner,
          required final Address rootTokenContract}) =
      _$TokenWalletDetailsRouteDataImpl;
  const _TokenWalletDetailsRouteData._() : super._();

  /// Owner of token wallet
  @override
  Address get owner;

  /// Root token contract address
  @override
  Address get rootTokenContract;

  /// Create a copy of TokenWalletDetailsRouteData
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$TokenWalletDetailsRouteDataImplCopyWith<_$TokenWalletDetailsRouteDataImpl>
      get copyWith => throw _privateConstructorUsedError;
}
