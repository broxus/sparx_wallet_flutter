// dart format width=80
// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'change_seed_password_cubit.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// dart format off
T _$identity<T>(T value) => value;

/// @nodoc
mixin _$ChangeSeedPasswordState {
  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType && other is ChangeSeedPasswordState);
  }

  @override
  int get hashCode => runtimeType.hashCode;

  @override
  String toString() {
    return 'ChangeSeedPasswordState()';
  }
}

/// @nodoc
class $ChangeSeedPasswordStateCopyWith<$Res> {
  $ChangeSeedPasswordStateCopyWith(
      ChangeSeedPasswordState _, $Res Function(ChangeSeedPasswordState) __);
}

/// @nodoc

class ChangeSeedPasswordStateInitial implements ChangeSeedPasswordState {
  const ChangeSeedPasswordStateInitial();

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is ChangeSeedPasswordStateInitial);
  }

  @override
  int get hashCode => runtimeType.hashCode;

  @override
  String toString() {
    return 'ChangeSeedPasswordState.initial()';
  }
}

/// @nodoc

class ChangeSeedPasswordStateError implements ChangeSeedPasswordState {
  const ChangeSeedPasswordStateError(this.errorCode);

  final String errorCode;

  /// Create a copy of ChangeSeedPasswordState
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @pragma('vm:prefer-inline')
  $ChangeSeedPasswordStateErrorCopyWith<ChangeSeedPasswordStateError>
      get copyWith => _$ChangeSeedPasswordStateErrorCopyWithImpl<
          ChangeSeedPasswordStateError>(this, _$identity);

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is ChangeSeedPasswordStateError &&
            (identical(other.errorCode, errorCode) ||
                other.errorCode == errorCode));
  }

  @override
  int get hashCode => Object.hash(runtimeType, errorCode);

  @override
  String toString() {
    return 'ChangeSeedPasswordState.error(errorCode: $errorCode)';
  }
}

/// @nodoc
abstract mixin class $ChangeSeedPasswordStateErrorCopyWith<$Res>
    implements $ChangeSeedPasswordStateCopyWith<$Res> {
  factory $ChangeSeedPasswordStateErrorCopyWith(
          ChangeSeedPasswordStateError value,
          $Res Function(ChangeSeedPasswordStateError) _then) =
      _$ChangeSeedPasswordStateErrorCopyWithImpl;
  @useResult
  $Res call({String errorCode});
}

/// @nodoc
class _$ChangeSeedPasswordStateErrorCopyWithImpl<$Res>
    implements $ChangeSeedPasswordStateErrorCopyWith<$Res> {
  _$ChangeSeedPasswordStateErrorCopyWithImpl(this._self, this._then);

  final ChangeSeedPasswordStateError _self;
  final $Res Function(ChangeSeedPasswordStateError) _then;

  /// Create a copy of ChangeSeedPasswordState
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  $Res call({
    Object? errorCode = null,
  }) {
    return _then(ChangeSeedPasswordStateError(
      null == errorCode
          ? _self.errorCode
          : errorCode // ignore: cast_nullable_to_non_nullable
              as String,
    ));
  }
}

/// @nodoc

class ChangeSeedPasswordStateCompleted implements ChangeSeedPasswordState {
  const ChangeSeedPasswordStateCompleted();

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is ChangeSeedPasswordStateCompleted);
  }

  @override
  int get hashCode => runtimeType.hashCode;

  @override
  String toString() {
    return 'ChangeSeedPasswordState.completed()';
  }
}

// dart format on
