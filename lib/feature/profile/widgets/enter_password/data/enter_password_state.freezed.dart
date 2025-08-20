// dart format width=80
// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'enter_password_state.dart';

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

class EnterPasswordStateLedger implements EnterPasswordState {
  const EnterPasswordStateLedger();

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType && other is EnterPasswordStateLedger);
  }

  @override
  int get hashCode => runtimeType.hashCode;

  @override
  String toString() {
    return 'EnterPasswordState.ledger()';
  }
}

// dart format on
