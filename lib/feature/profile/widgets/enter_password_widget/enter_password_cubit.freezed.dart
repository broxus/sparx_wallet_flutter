// dart format width=80
// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'enter_password_cubit.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// dart format off
T _$identity<T>(T value) => value;

/// @nodoc
mixin _$EnterPasswordState {
  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType && other is EnterPasswordState);
  }

  @override
  int get hashCode => runtimeType.hashCode;

  @override
  String toString() {
    return 'EnterPasswordState()';
  }
}

/// @nodoc
class $EnterPasswordStateCopyWith<$Res> {
  $EnterPasswordStateCopyWith(
      EnterPasswordState _, $Res Function(EnterPasswordState) __);
}

/// @nodoc

class EnterPasswordStateInitial implements EnterPasswordState {
  const EnterPasswordStateInitial();

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is EnterPasswordStateInitial);
  }

  @override
  int get hashCode => runtimeType.hashCode;

  @override
  String toString() {
    return 'EnterPasswordState.initial()';
  }
}

/// @nodoc

class EnterPasswordStateBiometry implements EnterPasswordState {
  const EnterPasswordStateBiometry({required this.isFace});

  final bool isFace;

  /// Create a copy of EnterPasswordState
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @pragma('vm:prefer-inline')
  $EnterPasswordStateBiometryCopyWith<EnterPasswordStateBiometry>
      get copyWith =>
          _$EnterPasswordStateBiometryCopyWithImpl<EnterPasswordStateBiometry>(
              this, _$identity);

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is EnterPasswordStateBiometry &&
            (identical(other.isFace, isFace) || other.isFace == isFace));
  }

  @override
  int get hashCode => Object.hash(runtimeType, isFace);

  @override
  String toString() {
    return 'EnterPasswordState.biometry(isFace: $isFace)';
  }
}

/// @nodoc
abstract mixin class $EnterPasswordStateBiometryCopyWith<$Res>
    implements $EnterPasswordStateCopyWith<$Res> {
  factory $EnterPasswordStateBiometryCopyWith(EnterPasswordStateBiometry value,
          $Res Function(EnterPasswordStateBiometry) _then) =
      _$EnterPasswordStateBiometryCopyWithImpl;
  @useResult
  $Res call({bool isFace});
}

/// @nodoc
class _$EnterPasswordStateBiometryCopyWithImpl<$Res>
    implements $EnterPasswordStateBiometryCopyWith<$Res> {
  _$EnterPasswordStateBiometryCopyWithImpl(this._self, this._then);

  final EnterPasswordStateBiometry _self;
  final $Res Function(EnterPasswordStateBiometry) _then;

  /// Create a copy of EnterPasswordState
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  $Res call({
    Object? isFace = null,
  }) {
    return _then(EnterPasswordStateBiometry(
      isFace: null == isFace
          ? _self.isFace
          : isFace // ignore: cast_nullable_to_non_nullable
              as bool,
    ));
  }
}

/// @nodoc

class EnterPasswordStatePassword implements EnterPasswordState {
  const EnterPasswordStatePassword();

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is EnterPasswordStatePassword);
  }

  @override
  int get hashCode => runtimeType.hashCode;

  @override
  String toString() {
    return 'EnterPasswordState.password()';
  }
}

/// @nodoc

class EnterPasswordStateEntered implements EnterPasswordState {
  const EnterPasswordStateEntered(
      {required this.password,
      required this.fromBiometry,
      required this.isFaceBiometry});

  final String password;
  final bool fromBiometry;
  final bool isFaceBiometry;

  /// Create a copy of EnterPasswordState
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @pragma('vm:prefer-inline')
  $EnterPasswordStateEnteredCopyWith<EnterPasswordStateEntered> get copyWith =>
      _$EnterPasswordStateEnteredCopyWithImpl<EnterPasswordStateEntered>(
          this, _$identity);

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is EnterPasswordStateEntered &&
            (identical(other.password, password) ||
                other.password == password) &&
            (identical(other.fromBiometry, fromBiometry) ||
                other.fromBiometry == fromBiometry) &&
            (identical(other.isFaceBiometry, isFaceBiometry) ||
                other.isFaceBiometry == isFaceBiometry));
  }

  @override
  int get hashCode =>
      Object.hash(runtimeType, password, fromBiometry, isFaceBiometry);

  @override
  String toString() {
    return 'EnterPasswordState.entered(password: $password, fromBiometry: $fromBiometry, isFaceBiometry: $isFaceBiometry)';
  }
}

/// @nodoc
abstract mixin class $EnterPasswordStateEnteredCopyWith<$Res>
    implements $EnterPasswordStateCopyWith<$Res> {
  factory $EnterPasswordStateEnteredCopyWith(EnterPasswordStateEntered value,
          $Res Function(EnterPasswordStateEntered) _then) =
      _$EnterPasswordStateEnteredCopyWithImpl;
  @useResult
  $Res call({String password, bool fromBiometry, bool isFaceBiometry});
}

/// @nodoc
class _$EnterPasswordStateEnteredCopyWithImpl<$Res>
    implements $EnterPasswordStateEnteredCopyWith<$Res> {
  _$EnterPasswordStateEnteredCopyWithImpl(this._self, this._then);

  final EnterPasswordStateEntered _self;
  final $Res Function(EnterPasswordStateEntered) _then;

  /// Create a copy of EnterPasswordState
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  $Res call({
    Object? password = null,
    Object? fromBiometry = null,
    Object? isFaceBiometry = null,
  }) {
    return _then(EnterPasswordStateEntered(
      password: null == password
          ? _self.password
          : password // ignore: cast_nullable_to_non_nullable
              as String,
      fromBiometry: null == fromBiometry
          ? _self.fromBiometry
          : fromBiometry // ignore: cast_nullable_to_non_nullable
              as bool,
      isFaceBiometry: null == isFaceBiometry
          ? _self.isFaceBiometry
          : isFaceBiometry // ignore: cast_nullable_to_non_nullable
              as bool,
    ));
  }
}

// dart format on
