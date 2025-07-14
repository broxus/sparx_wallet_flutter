// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'qr_scan_result.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
    'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#adding-getters-and-methods-to-our-models');

/// @nodoc
mixin _$QrScanResult {
  Object get value => throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult when<TResult extends Object?>({
    required TResult Function(Address value) address,
    required TResult Function(Uri value) uri,
  }) =>
      throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>({
    TResult? Function(Address value)? address,
    TResult? Function(Uri value)? uri,
  }) =>
      throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>({
    TResult Function(Address value)? address,
    TResult Function(Uri value)? uri,
    required TResult orElse(),
  }) =>
      throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult map<TResult extends Object?>({
    required TResult Function(QrScanResultAddress value) address,
    required TResult Function(QrScanResultUri value) uri,
  }) =>
      throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult? mapOrNull<TResult extends Object?>({
    TResult? Function(QrScanResultAddress value)? address,
    TResult? Function(QrScanResultUri value)? uri,
  }) =>
      throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>({
    TResult Function(QrScanResultAddress value)? address,
    TResult Function(QrScanResultUri value)? uri,
    required TResult orElse(),
  }) =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $QrScanResultCopyWith<$Res> {
  factory $QrScanResultCopyWith(
          QrScanResult value, $Res Function(QrScanResult) then) =
      _$QrScanResultCopyWithImpl<$Res, QrScanResult>;
}

/// @nodoc
class _$QrScanResultCopyWithImpl<$Res, $Val extends QrScanResult>
    implements $QrScanResultCopyWith<$Res> {
  _$QrScanResultCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  /// Create a copy of QrScanResult
  /// with the given fields replaced by the non-null parameter values.
}

/// @nodoc
abstract class _$$QrScanResultAddressImplCopyWith<$Res> {
  factory _$$QrScanResultAddressImplCopyWith(_$QrScanResultAddressImpl value,
          $Res Function(_$QrScanResultAddressImpl) then) =
      __$$QrScanResultAddressImplCopyWithImpl<$Res>;
  @useResult
  $Res call({Address value});

  $AddressCopyWith<$Res> get value;
}

/// @nodoc
class __$$QrScanResultAddressImplCopyWithImpl<$Res>
    extends _$QrScanResultCopyWithImpl<$Res, _$QrScanResultAddressImpl>
    implements _$$QrScanResultAddressImplCopyWith<$Res> {
  __$$QrScanResultAddressImplCopyWithImpl(_$QrScanResultAddressImpl _value,
      $Res Function(_$QrScanResultAddressImpl) _then)
      : super(_value, _then);

  /// Create a copy of QrScanResult
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? value = null,
  }) {
    return _then(_$QrScanResultAddressImpl(
      null == value
          ? _value.value
          : value // ignore: cast_nullable_to_non_nullable
              as Address,
    ));
  }

  /// Create a copy of QrScanResult
  /// with the given fields replaced by the non-null parameter values.
  @override
  @pragma('vm:prefer-inline')
  $AddressCopyWith<$Res> get value {
    return $AddressCopyWith<$Res>(_value.value, (value) {
      return _then(_value.copyWith(value: value));
    });
  }
}

/// @nodoc

class _$QrScanResultAddressImpl implements QrScanResultAddress {
  const _$QrScanResultAddressImpl(this.value);

  @override
  final Address value;

  @override
  String toString() {
    return 'QrScanResult.address(value: $value)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$QrScanResultAddressImpl &&
            (identical(other.value, value) || other.value == value));
  }

  @override
  int get hashCode => Object.hash(runtimeType, value);

  /// Create a copy of QrScanResult
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$QrScanResultAddressImplCopyWith<_$QrScanResultAddressImpl> get copyWith =>
      __$$QrScanResultAddressImplCopyWithImpl<_$QrScanResultAddressImpl>(
          this, _$identity);

  @override
  @optionalTypeArgs
  TResult when<TResult extends Object?>({
    required TResult Function(Address value) address,
    required TResult Function(Uri value) uri,
  }) {
    return address(value);
  }

  @override
  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>({
    TResult? Function(Address value)? address,
    TResult? Function(Uri value)? uri,
  }) {
    return address?.call(value);
  }

  @override
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>({
    TResult Function(Address value)? address,
    TResult Function(Uri value)? uri,
    required TResult orElse(),
  }) {
    if (address != null) {
      return address(value);
    }
    return orElse();
  }

  @override
  @optionalTypeArgs
  TResult map<TResult extends Object?>({
    required TResult Function(QrScanResultAddress value) address,
    required TResult Function(QrScanResultUri value) uri,
  }) {
    return address(this);
  }

  @override
  @optionalTypeArgs
  TResult? mapOrNull<TResult extends Object?>({
    TResult? Function(QrScanResultAddress value)? address,
    TResult? Function(QrScanResultUri value)? uri,
  }) {
    return address?.call(this);
  }

  @override
  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>({
    TResult Function(QrScanResultAddress value)? address,
    TResult Function(QrScanResultUri value)? uri,
    required TResult orElse(),
  }) {
    if (address != null) {
      return address(this);
    }
    return orElse();
  }
}

abstract class QrScanResultAddress implements QrScanResult {
  const factory QrScanResultAddress(final Address value) =
      _$QrScanResultAddressImpl;

  @override
  Address get value;

  /// Create a copy of QrScanResult
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$QrScanResultAddressImplCopyWith<_$QrScanResultAddressImpl> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class _$$QrScanResultUriImplCopyWith<$Res> {
  factory _$$QrScanResultUriImplCopyWith(_$QrScanResultUriImpl value,
          $Res Function(_$QrScanResultUriImpl) then) =
      __$$QrScanResultUriImplCopyWithImpl<$Res>;
  @useResult
  $Res call({Uri value});
}

/// @nodoc
class __$$QrScanResultUriImplCopyWithImpl<$Res>
    extends _$QrScanResultCopyWithImpl<$Res, _$QrScanResultUriImpl>
    implements _$$QrScanResultUriImplCopyWith<$Res> {
  __$$QrScanResultUriImplCopyWithImpl(
      _$QrScanResultUriImpl _value, $Res Function(_$QrScanResultUriImpl) _then)
      : super(_value, _then);

  /// Create a copy of QrScanResult
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? value = null,
  }) {
    return _then(_$QrScanResultUriImpl(
      null == value
          ? _value.value
          : value // ignore: cast_nullable_to_non_nullable
              as Uri,
    ));
  }
}

/// @nodoc

class _$QrScanResultUriImpl implements QrScanResultUri {
  const _$QrScanResultUriImpl(this.value);

  @override
  final Uri value;

  @override
  String toString() {
    return 'QrScanResult.uri(value: $value)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$QrScanResultUriImpl &&
            (identical(other.value, value) || other.value == value));
  }

  @override
  int get hashCode => Object.hash(runtimeType, value);

  /// Create a copy of QrScanResult
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$QrScanResultUriImplCopyWith<_$QrScanResultUriImpl> get copyWith =>
      __$$QrScanResultUriImplCopyWithImpl<_$QrScanResultUriImpl>(
          this, _$identity);

  @override
  @optionalTypeArgs
  TResult when<TResult extends Object?>({
    required TResult Function(Address value) address,
    required TResult Function(Uri value) uri,
  }) {
    return uri(value);
  }

  @override
  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>({
    TResult? Function(Address value)? address,
    TResult? Function(Uri value)? uri,
  }) {
    return uri?.call(value);
  }

  @override
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>({
    TResult Function(Address value)? address,
    TResult Function(Uri value)? uri,
    required TResult orElse(),
  }) {
    if (uri != null) {
      return uri(value);
    }
    return orElse();
  }

  @override
  @optionalTypeArgs
  TResult map<TResult extends Object?>({
    required TResult Function(QrScanResultAddress value) address,
    required TResult Function(QrScanResultUri value) uri,
  }) {
    return uri(this);
  }

  @override
  @optionalTypeArgs
  TResult? mapOrNull<TResult extends Object?>({
    TResult? Function(QrScanResultAddress value)? address,
    TResult? Function(QrScanResultUri value)? uri,
  }) {
    return uri?.call(this);
  }

  @override
  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>({
    TResult Function(QrScanResultAddress value)? address,
    TResult Function(QrScanResultUri value)? uri,
    required TResult orElse(),
  }) {
    if (uri != null) {
      return uri(this);
    }
    return orElse();
  }
}

abstract class QrScanResultUri implements QrScanResult {
  const factory QrScanResultUri(final Uri value) = _$QrScanResultUriImpl;

  @override
  Uri get value;

  /// Create a copy of QrScanResult
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$QrScanResultUriImplCopyWith<_$QrScanResultUriImpl> get copyWith =>
      throw _privateConstructorUsedError;
}
