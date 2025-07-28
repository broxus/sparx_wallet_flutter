// dart format width=80
// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'biometry_cubit.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// dart format off
T _$identity<T>(T value) => value;

/// @nodoc
mixin _$BiometryState {
  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType && other is BiometryState);
  }

  @override
  int get hashCode => runtimeType.hashCode;

  @override
  String toString() {
    return 'BiometryState()';
  }
}

/// @nodoc
class $BiometryStateCopyWith<$Res> {
  $BiometryStateCopyWith(BiometryState _, $Res Function(BiometryState) __);
}

/// @nodoc

class BiometryStateInit implements BiometryState {
  const BiometryStateInit();

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType && other is BiometryStateInit);
  }

  @override
  int get hashCode => runtimeType.hashCode;

  @override
  String toString() {
    return 'BiometryState.init()';
  }
}

/// @nodoc

class BiometryStateAsk implements BiometryState {
  const BiometryStateAsk({required this.isFaceBiometry});

  final bool isFaceBiometry;

  /// Create a copy of BiometryState
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @pragma('vm:prefer-inline')
  $BiometryStateAskCopyWith<BiometryStateAsk> get copyWith =>
      _$BiometryStateAskCopyWithImpl<BiometryStateAsk>(this, _$identity);

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is BiometryStateAsk &&
            (identical(other.isFaceBiometry, isFaceBiometry) ||
                other.isFaceBiometry == isFaceBiometry));
  }

  @override
  int get hashCode => Object.hash(runtimeType, isFaceBiometry);

  @override
  String toString() {
    return 'BiometryState.ask(isFaceBiometry: $isFaceBiometry)';
  }
}

/// @nodoc
abstract mixin class $BiometryStateAskCopyWith<$Res>
    implements $BiometryStateCopyWith<$Res> {
  factory $BiometryStateAskCopyWith(
          BiometryStateAsk value, $Res Function(BiometryStateAsk) _then) =
      _$BiometryStateAskCopyWithImpl;
  @useResult
  $Res call({bool isFaceBiometry});
}

/// @nodoc
class _$BiometryStateAskCopyWithImpl<$Res>
    implements $BiometryStateAskCopyWith<$Res> {
  _$BiometryStateAskCopyWithImpl(this._self, this._then);

  final BiometryStateAsk _self;
  final $Res Function(BiometryStateAsk) _then;

  /// Create a copy of BiometryState
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  $Res call({
    Object? isFaceBiometry = null,
  }) {
    return _then(BiometryStateAsk(
      isFaceBiometry: null == isFaceBiometry
          ? _self.isFaceBiometry
          : isFaceBiometry // ignore: cast_nullable_to_non_nullable
              as bool,
    ));
  }
}

/// @nodoc

class BiometryStateCompleted implements BiometryState {
  const BiometryStateCompleted();

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType && other is BiometryStateCompleted);
  }

  @override
  int get hashCode => runtimeType.hashCode;

  @override
  String toString() {
    return 'BiometryState.completed()';
  }
}

// dart format on
