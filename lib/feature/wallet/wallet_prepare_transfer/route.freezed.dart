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
mixin _$WalletPrepareTransferRouteData {
  /// Address of wallet for transfer
  Address get address => throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult when<TResult extends Object?>({
    required TResult Function(Address address, Address? destination) basic,
    required TResult Function(
            Address address, Address rootTokenContract, String tokenSymbol)
        specified,
  }) =>
      throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>({
    TResult? Function(Address address, Address? destination)? basic,
    TResult? Function(
            Address address, Address rootTokenContract, String tokenSymbol)?
        specified,
  }) =>
      throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>({
    TResult Function(Address address, Address? destination)? basic,
    TResult Function(
            Address address, Address rootTokenContract, String tokenSymbol)?
        specified,
    required TResult orElse(),
  }) =>
      throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult map<TResult extends Object?>({
    required TResult Function(_BasicWalletPrepareTransferRouteData value) basic,
    required TResult Function(_SpecifiedWalletPrepareTransferRouteData value)
        specified,
  }) =>
      throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult? mapOrNull<TResult extends Object?>({
    TResult? Function(_BasicWalletPrepareTransferRouteData value)? basic,
    TResult? Function(_SpecifiedWalletPrepareTransferRouteData value)?
        specified,
  }) =>
      throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>({
    TResult Function(_BasicWalletPrepareTransferRouteData value)? basic,
    TResult Function(_SpecifiedWalletPrepareTransferRouteData value)? specified,
    required TResult orElse(),
  }) =>
      throw _privateConstructorUsedError;

  /// Create a copy of WalletPrepareTransferRouteData
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  $WalletPrepareTransferRouteDataCopyWith<WalletPrepareTransferRouteData>
      get copyWith => throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $WalletPrepareTransferRouteDataCopyWith<$Res> {
  factory $WalletPrepareTransferRouteDataCopyWith(
          WalletPrepareTransferRouteData value,
          $Res Function(WalletPrepareTransferRouteData) then) =
      _$WalletPrepareTransferRouteDataCopyWithImpl<$Res,
          WalletPrepareTransferRouteData>;
  @useResult
  $Res call({Address address});

  $AddressCopyWith<$Res> get address;
}

/// @nodoc
class _$WalletPrepareTransferRouteDataCopyWithImpl<$Res,
        $Val extends WalletPrepareTransferRouteData>
    implements $WalletPrepareTransferRouteDataCopyWith<$Res> {
  _$WalletPrepareTransferRouteDataCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  /// Create a copy of WalletPrepareTransferRouteData
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? address = null,
  }) {
    return _then(_value.copyWith(
      address: null == address
          ? _value.address
          : address // ignore: cast_nullable_to_non_nullable
              as Address,
    ) as $Val);
  }

  /// Create a copy of WalletPrepareTransferRouteData
  /// with the given fields replaced by the non-null parameter values.
  @override
  @pragma('vm:prefer-inline')
  $AddressCopyWith<$Res> get address {
    return $AddressCopyWith<$Res>(_value.address, (value) {
      return _then(_value.copyWith(address: value) as $Val);
    });
  }
}

/// @nodoc
abstract class _$$BasicWalletPrepareTransferRouteDataImplCopyWith<$Res>
    implements $WalletPrepareTransferRouteDataCopyWith<$Res> {
  factory _$$BasicWalletPrepareTransferRouteDataImplCopyWith(
          _$BasicWalletPrepareTransferRouteDataImpl value,
          $Res Function(_$BasicWalletPrepareTransferRouteDataImpl) then) =
      __$$BasicWalletPrepareTransferRouteDataImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call({Address address, Address? destination});

  @override
  $AddressCopyWith<$Res> get address;
  $AddressCopyWith<$Res>? get destination;
}

/// @nodoc
class __$$BasicWalletPrepareTransferRouteDataImplCopyWithImpl<$Res>
    extends _$WalletPrepareTransferRouteDataCopyWithImpl<$Res,
        _$BasicWalletPrepareTransferRouteDataImpl>
    implements _$$BasicWalletPrepareTransferRouteDataImplCopyWith<$Res> {
  __$$BasicWalletPrepareTransferRouteDataImplCopyWithImpl(
      _$BasicWalletPrepareTransferRouteDataImpl _value,
      $Res Function(_$BasicWalletPrepareTransferRouteDataImpl) _then)
      : super(_value, _then);

  /// Create a copy of WalletPrepareTransferRouteData
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? address = null,
    Object? destination = freezed,
  }) {
    return _then(_$BasicWalletPrepareTransferRouteDataImpl(
      address: null == address
          ? _value.address
          : address // ignore: cast_nullable_to_non_nullable
              as Address,
      destination: freezed == destination
          ? _value.destination
          : destination // ignore: cast_nullable_to_non_nullable
              as Address?,
    ));
  }

  /// Create a copy of WalletPrepareTransferRouteData
  /// with the given fields replaced by the non-null parameter values.
  @override
  @pragma('vm:prefer-inline')
  $AddressCopyWith<$Res>? get destination {
    if (_value.destination == null) {
      return null;
    }

    return $AddressCopyWith<$Res>(_value.destination!, (value) {
      return _then(_value.copyWith(destination: value));
    });
  }
}

/// @nodoc

class _$BasicWalletPrepareTransferRouteDataImpl
    extends _BasicWalletPrepareTransferRouteData {
  const _$BasicWalletPrepareTransferRouteDataImpl(
      {required this.address, this.destination})
      : super._();

  /// Address of wallet for transfer
  @override
  final Address address;

  /// Optional destination address
  @override
  final Address? destination;

  @override
  String toString() {
    return 'WalletPrepareTransferRouteData.basic(address: $address, destination: $destination)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$BasicWalletPrepareTransferRouteDataImpl &&
            (identical(other.address, address) || other.address == address) &&
            (identical(other.destination, destination) ||
                other.destination == destination));
  }

  @override
  int get hashCode => Object.hash(runtimeType, address, destination);

  /// Create a copy of WalletPrepareTransferRouteData
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$BasicWalletPrepareTransferRouteDataImplCopyWith<
          _$BasicWalletPrepareTransferRouteDataImpl>
      get copyWith => __$$BasicWalletPrepareTransferRouteDataImplCopyWithImpl<
          _$BasicWalletPrepareTransferRouteDataImpl>(this, _$identity);

  @override
  @optionalTypeArgs
  TResult when<TResult extends Object?>({
    required TResult Function(Address address, Address? destination) basic,
    required TResult Function(
            Address address, Address rootTokenContract, String tokenSymbol)
        specified,
  }) {
    return basic(address, destination);
  }

  @override
  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>({
    TResult? Function(Address address, Address? destination)? basic,
    TResult? Function(
            Address address, Address rootTokenContract, String tokenSymbol)?
        specified,
  }) {
    return basic?.call(address, destination);
  }

  @override
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>({
    TResult Function(Address address, Address? destination)? basic,
    TResult Function(
            Address address, Address rootTokenContract, String tokenSymbol)?
        specified,
    required TResult orElse(),
  }) {
    if (basic != null) {
      return basic(address, destination);
    }
    return orElse();
  }

  @override
  @optionalTypeArgs
  TResult map<TResult extends Object?>({
    required TResult Function(_BasicWalletPrepareTransferRouteData value) basic,
    required TResult Function(_SpecifiedWalletPrepareTransferRouteData value)
        specified,
  }) {
    return basic(this);
  }

  @override
  @optionalTypeArgs
  TResult? mapOrNull<TResult extends Object?>({
    TResult? Function(_BasicWalletPrepareTransferRouteData value)? basic,
    TResult? Function(_SpecifiedWalletPrepareTransferRouteData value)?
        specified,
  }) {
    return basic?.call(this);
  }

  @override
  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>({
    TResult Function(_BasicWalletPrepareTransferRouteData value)? basic,
    TResult Function(_SpecifiedWalletPrepareTransferRouteData value)? specified,
    required TResult orElse(),
  }) {
    if (basic != null) {
      return basic(this);
    }
    return orElse();
  }
}

abstract class _BasicWalletPrepareTransferRouteData
    extends WalletPrepareTransferRouteData {
  const factory _BasicWalletPrepareTransferRouteData(
      {required final Address address,
      final Address? destination}) = _$BasicWalletPrepareTransferRouteDataImpl;
  const _BasicWalletPrepareTransferRouteData._() : super._();

  /// Address of wallet for transfer
  @override
  Address get address;

  /// Optional destination address
  Address? get destination;

  /// Create a copy of WalletPrepareTransferRouteData
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$BasicWalletPrepareTransferRouteDataImplCopyWith<
          _$BasicWalletPrepareTransferRouteDataImpl>
      get copyWith => throw _privateConstructorUsedError;
}

/// @nodoc
abstract class _$$SpecifiedWalletPrepareTransferRouteDataImplCopyWith<$Res>
    implements $WalletPrepareTransferRouteDataCopyWith<$Res> {
  factory _$$SpecifiedWalletPrepareTransferRouteDataImplCopyWith(
          _$SpecifiedWalletPrepareTransferRouteDataImpl value,
          $Res Function(_$SpecifiedWalletPrepareTransferRouteDataImpl) then) =
      __$$SpecifiedWalletPrepareTransferRouteDataImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call({Address address, Address rootTokenContract, String tokenSymbol});

  @override
  $AddressCopyWith<$Res> get address;
  $AddressCopyWith<$Res> get rootTokenContract;
}

/// @nodoc
class __$$SpecifiedWalletPrepareTransferRouteDataImplCopyWithImpl<$Res>
    extends _$WalletPrepareTransferRouteDataCopyWithImpl<$Res,
        _$SpecifiedWalletPrepareTransferRouteDataImpl>
    implements _$$SpecifiedWalletPrepareTransferRouteDataImplCopyWith<$Res> {
  __$$SpecifiedWalletPrepareTransferRouteDataImplCopyWithImpl(
      _$SpecifiedWalletPrepareTransferRouteDataImpl _value,
      $Res Function(_$SpecifiedWalletPrepareTransferRouteDataImpl) _then)
      : super(_value, _then);

  /// Create a copy of WalletPrepareTransferRouteData
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? address = null,
    Object? rootTokenContract = null,
    Object? tokenSymbol = null,
  }) {
    return _then(_$SpecifiedWalletPrepareTransferRouteDataImpl(
      address: null == address
          ? _value.address
          : address // ignore: cast_nullable_to_non_nullable
              as Address,
      rootTokenContract: null == rootTokenContract
          ? _value.rootTokenContract
          : rootTokenContract // ignore: cast_nullable_to_non_nullable
              as Address,
      tokenSymbol: null == tokenSymbol
          ? _value.tokenSymbol
          : tokenSymbol // ignore: cast_nullable_to_non_nullable
              as String,
    ));
  }

  /// Create a copy of WalletPrepareTransferRouteData
  /// with the given fields replaced by the non-null parameter values.
  @override
  @pragma('vm:prefer-inline')
  $AddressCopyWith<$Res> get rootTokenContract {
    return $AddressCopyWith<$Res>(_value.rootTokenContract, (value) {
      return _then(_value.copyWith(rootTokenContract: value));
    });
  }
}

/// @nodoc

class _$SpecifiedWalletPrepareTransferRouteDataImpl
    extends _SpecifiedWalletPrepareTransferRouteData {
  const _$SpecifiedWalletPrepareTransferRouteDataImpl(
      {required this.address,
      required this.rootTokenContract,
      required this.tokenSymbol})
      : super._();

  /// Address of wallet for transfer
  @override
  final Address address;

  /// Root token contract address
  @override
  final Address rootTokenContract;

  /// Token symbol
  @override
  final String tokenSymbol;

  @override
  String toString() {
    return 'WalletPrepareTransferRouteData.specified(address: $address, rootTokenContract: $rootTokenContract, tokenSymbol: $tokenSymbol)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$SpecifiedWalletPrepareTransferRouteDataImpl &&
            (identical(other.address, address) || other.address == address) &&
            (identical(other.rootTokenContract, rootTokenContract) ||
                other.rootTokenContract == rootTokenContract) &&
            (identical(other.tokenSymbol, tokenSymbol) ||
                other.tokenSymbol == tokenSymbol));
  }

  @override
  int get hashCode =>
      Object.hash(runtimeType, address, rootTokenContract, tokenSymbol);

  /// Create a copy of WalletPrepareTransferRouteData
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$SpecifiedWalletPrepareTransferRouteDataImplCopyWith<
          _$SpecifiedWalletPrepareTransferRouteDataImpl>
      get copyWith =>
          __$$SpecifiedWalletPrepareTransferRouteDataImplCopyWithImpl<
              _$SpecifiedWalletPrepareTransferRouteDataImpl>(this, _$identity);

  @override
  @optionalTypeArgs
  TResult when<TResult extends Object?>({
    required TResult Function(Address address, Address? destination) basic,
    required TResult Function(
            Address address, Address rootTokenContract, String tokenSymbol)
        specified,
  }) {
    return specified(address, rootTokenContract, tokenSymbol);
  }

  @override
  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>({
    TResult? Function(Address address, Address? destination)? basic,
    TResult? Function(
            Address address, Address rootTokenContract, String tokenSymbol)?
        specified,
  }) {
    return specified?.call(address, rootTokenContract, tokenSymbol);
  }

  @override
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>({
    TResult Function(Address address, Address? destination)? basic,
    TResult Function(
            Address address, Address rootTokenContract, String tokenSymbol)?
        specified,
    required TResult orElse(),
  }) {
    if (specified != null) {
      return specified(address, rootTokenContract, tokenSymbol);
    }
    return orElse();
  }

  @override
  @optionalTypeArgs
  TResult map<TResult extends Object?>({
    required TResult Function(_BasicWalletPrepareTransferRouteData value) basic,
    required TResult Function(_SpecifiedWalletPrepareTransferRouteData value)
        specified,
  }) {
    return specified(this);
  }

  @override
  @optionalTypeArgs
  TResult? mapOrNull<TResult extends Object?>({
    TResult? Function(_BasicWalletPrepareTransferRouteData value)? basic,
    TResult? Function(_SpecifiedWalletPrepareTransferRouteData value)?
        specified,
  }) {
    return specified?.call(this);
  }

  @override
  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>({
    TResult Function(_BasicWalletPrepareTransferRouteData value)? basic,
    TResult Function(_SpecifiedWalletPrepareTransferRouteData value)? specified,
    required TResult orElse(),
  }) {
    if (specified != null) {
      return specified(this);
    }
    return orElse();
  }
}

abstract class _SpecifiedWalletPrepareTransferRouteData
    extends WalletPrepareTransferRouteData {
  const factory _SpecifiedWalletPrepareTransferRouteData(
          {required final Address address,
          required final Address rootTokenContract,
          required final String tokenSymbol}) =
      _$SpecifiedWalletPrepareTransferRouteDataImpl;
  const _SpecifiedWalletPrepareTransferRouteData._() : super._();

  /// Address of wallet for transfer
  @override
  Address get address;

  /// Root token contract address
  Address get rootTokenContract;

  /// Token symbol
  String get tokenSymbol;

  /// Create a copy of WalletPrepareTransferRouteData
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$SpecifiedWalletPrepareTransferRouteDataImplCopyWith<
          _$SpecifiedWalletPrepareTransferRouteDataImpl>
      get copyWith => throw _privateConstructorUsedError;
}
