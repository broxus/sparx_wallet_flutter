// dart format width=80
// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'export_seed_cubit.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// dart format off
T _$identity<T>(T value) => value;

/// @nodoc
mixin _$ExportSeedState {
  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType && other is ExportSeedState);
  }

  @override
  int get hashCode => runtimeType.hashCode;

  @override
  String toString() {
    return 'ExportSeedState()';
  }
}

/// @nodoc
class $ExportSeedStateCopyWith<$Res> {
  $ExportSeedStateCopyWith(
      ExportSeedState _, $Res Function(ExportSeedState) __);
}

/// @nodoc

class ExportSeedStateInitial implements ExportSeedState {
  const ExportSeedStateInitial();

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType && other is ExportSeedStateInitial);
  }

  @override
  int get hashCode => runtimeType.hashCode;

  @override
  String toString() {
    return 'ExportSeedState.initial()';
  }
}

/// @nodoc

class ExportSeedStateError implements ExportSeedState {
  const ExportSeedStateError(this.error);

  final String error;

  /// Create a copy of ExportSeedState
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @pragma('vm:prefer-inline')
  $ExportSeedStateErrorCopyWith<ExportSeedStateError> get copyWith =>
      _$ExportSeedStateErrorCopyWithImpl<ExportSeedStateError>(
          this, _$identity);

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is ExportSeedStateError &&
            (identical(other.error, error) || other.error == error));
  }

  @override
  int get hashCode => Object.hash(runtimeType, error);

  @override
  String toString() {
    return 'ExportSeedState.error(error: $error)';
  }
}

/// @nodoc
abstract mixin class $ExportSeedStateErrorCopyWith<$Res>
    implements $ExportSeedStateCopyWith<$Res> {
  factory $ExportSeedStateErrorCopyWith(ExportSeedStateError value,
          $Res Function(ExportSeedStateError) _then) =
      _$ExportSeedStateErrorCopyWithImpl;
  @useResult
  $Res call({String error});
}

/// @nodoc
class _$ExportSeedStateErrorCopyWithImpl<$Res>
    implements $ExportSeedStateErrorCopyWith<$Res> {
  _$ExportSeedStateErrorCopyWithImpl(this._self, this._then);

  final ExportSeedStateError _self;
  final $Res Function(ExportSeedStateError) _then;

  /// Create a copy of ExportSeedState
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  $Res call({
    Object? error = null,
  }) {
    return _then(ExportSeedStateError(
      null == error
          ? _self.error
          : error // ignore: cast_nullable_to_non_nullable
              as String,
    ));
  }
}

/// @nodoc

class ExportSeedStateSuccess implements ExportSeedState {
  const ExportSeedStateSuccess(final List<String> phrase) : _phrase = phrase;

  final List<String> _phrase;
  List<String> get phrase {
    if (_phrase is EqualUnmodifiableListView) return _phrase;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableListView(_phrase);
  }

  /// Create a copy of ExportSeedState
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @pragma('vm:prefer-inline')
  $ExportSeedStateSuccessCopyWith<ExportSeedStateSuccess> get copyWith =>
      _$ExportSeedStateSuccessCopyWithImpl<ExportSeedStateSuccess>(
          this, _$identity);

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is ExportSeedStateSuccess &&
            const DeepCollectionEquality().equals(other._phrase, _phrase));
  }

  @override
  int get hashCode =>
      Object.hash(runtimeType, const DeepCollectionEquality().hash(_phrase));

  @override
  String toString() {
    return 'ExportSeedState.success(phrase: $phrase)';
  }
}

/// @nodoc
abstract mixin class $ExportSeedStateSuccessCopyWith<$Res>
    implements $ExportSeedStateCopyWith<$Res> {
  factory $ExportSeedStateSuccessCopyWith(ExportSeedStateSuccess value,
          $Res Function(ExportSeedStateSuccess) _then) =
      _$ExportSeedStateSuccessCopyWithImpl;
  @useResult
  $Res call({List<String> phrase});
}

/// @nodoc
class _$ExportSeedStateSuccessCopyWithImpl<$Res>
    implements $ExportSeedStateSuccessCopyWith<$Res> {
  _$ExportSeedStateSuccessCopyWithImpl(this._self, this._then);

  final ExportSeedStateSuccess _self;
  final $Res Function(ExportSeedStateSuccess) _then;

  /// Create a copy of ExportSeedState
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  $Res call({
    Object? phrase = null,
  }) {
    return _then(ExportSeedStateSuccess(
      null == phrase
          ? _self._phrase
          : phrase // ignore: cast_nullable_to_non_nullable
              as List<String>,
    ));
  }
}

// dart format on
