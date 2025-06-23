// dart format width=80
// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'qr_scan_result.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// dart format off
T _$identity<T>(T value) => value;

/// @nodoc
mixin _$QrScanResult {
  Object get value;

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is QrScanResult &&
            const DeepCollectionEquality().equals(other.value, value));
  }

  @override
  int get hashCode =>
      Object.hash(runtimeType, const DeepCollectionEquality().hash(value));

  @override
  String toString() {
    return 'QrScanResult(value: $value)';
  }
}

/// @nodoc
class $QrScanResultCopyWith<$Res> {
  $QrScanResultCopyWith(QrScanResult _, $Res Function(QrScanResult) __);
}

/// @nodoc

class QrScanResultAddress implements QrScanResult {
  const QrScanResultAddress(this.value);

  @override
  final Address value;

  /// Create a copy of QrScanResult
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @pragma('vm:prefer-inline')
  $QrScanResultAddressCopyWith<QrScanResultAddress> get copyWith =>
      _$QrScanResultAddressCopyWithImpl<QrScanResultAddress>(this, _$identity);

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is QrScanResultAddress &&
            (identical(other.value, value) || other.value == value));
  }

  @override
  int get hashCode => Object.hash(runtimeType, value);

  @override
  String toString() {
    return 'QrScanResult.address(value: $value)';
  }
}

/// @nodoc
abstract mixin class $QrScanResultAddressCopyWith<$Res>
    implements $QrScanResultCopyWith<$Res> {
  factory $QrScanResultAddressCopyWith(
          QrScanResultAddress value, $Res Function(QrScanResultAddress) _then) =
      _$QrScanResultAddressCopyWithImpl;
  @useResult
  $Res call({Address value});

  $AddressCopyWith<$Res> get value;
}

/// @nodoc
class _$QrScanResultAddressCopyWithImpl<$Res>
    implements $QrScanResultAddressCopyWith<$Res> {
  _$QrScanResultAddressCopyWithImpl(this._self, this._then);

  final QrScanResultAddress _self;
  final $Res Function(QrScanResultAddress) _then;

  /// Create a copy of QrScanResult
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  $Res call({
    Object? value = null,
  }) {
    return _then(QrScanResultAddress(
      null == value
          ? _self.value
          : value // ignore: cast_nullable_to_non_nullable
              as Address,
    ));
  }

  /// Create a copy of QrScanResult
  /// with the given fields replaced by the non-null parameter values.
  @override
  @pragma('vm:prefer-inline')
  $AddressCopyWith<$Res> get value {
    return $AddressCopyWith<$Res>(_self.value, (value) {
      return _then(_self.copyWith(value: value));
    });
  }
}

/// @nodoc

class QrScanResultUri implements QrScanResult {
  const QrScanResultUri(this.value);

  @override
  final Uri value;

  /// Create a copy of QrScanResult
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @pragma('vm:prefer-inline')
  $QrScanResultUriCopyWith<QrScanResultUri> get copyWith =>
      _$QrScanResultUriCopyWithImpl<QrScanResultUri>(this, _$identity);

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is QrScanResultUri &&
            (identical(other.value, value) || other.value == value));
  }

  @override
  int get hashCode => Object.hash(runtimeType, value);

  @override
  String toString() {
    return 'QrScanResult.uri(value: $value)';
  }
}

/// @nodoc
abstract mixin class $QrScanResultUriCopyWith<$Res>
    implements $QrScanResultCopyWith<$Res> {
  factory $QrScanResultUriCopyWith(
          QrScanResultUri value, $Res Function(QrScanResultUri) _then) =
      _$QrScanResultUriCopyWithImpl;
  @useResult
  $Res call({Uri value});
}

/// @nodoc
class _$QrScanResultUriCopyWithImpl<$Res>
    implements $QrScanResultUriCopyWith<$Res> {
  _$QrScanResultUriCopyWithImpl(this._self, this._then);

  final QrScanResultUri _self;
  final $Res Function(QrScanResultUri) _then;

  /// Create a copy of QrScanResult
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  $Res call({
    Object? value = null,
  }) {
    return _then(QrScanResultUri(
      null == value
          ? _self.value
          : value // ignore: cast_nullable_to_non_nullable
              as Uri,
    ));
  }
}

// dart format on
