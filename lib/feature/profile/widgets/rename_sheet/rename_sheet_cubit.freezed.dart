// dart format width=80
// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'rename_sheet_cubit.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// dart format off
T _$identity<T>(T value) => value;

/// @nodoc
mixin _$RenameSheetState {
  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType && other is RenameSheetState);
  }

  @override
  int get hashCode => runtimeType.hashCode;

  @override
  String toString() {
    return 'RenameSheetState()';
  }
}

/// @nodoc
class $RenameSheetStateCopyWith<$Res> {
  $RenameSheetStateCopyWith(
      RenameSheetState _, $Res Function(RenameSheetState) __);
}

/// @nodoc

class RenameSheetStateLoading implements RenameSheetState {
  const RenameSheetStateLoading();

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType && other is RenameSheetStateLoading);
  }

  @override
  int get hashCode => runtimeType.hashCode;

  @override
  String toString() {
    return 'RenameSheetState.loading()';
  }
}

/// @nodoc

class RenameSheetStateInit implements RenameSheetState {
  const RenameSheetStateInit();

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType && other is RenameSheetStateInit);
  }

  @override
  int get hashCode => runtimeType.hashCode;

  @override
  String toString() {
    return 'RenameSheetState.init()';
  }
}

/// @nodoc

class RenameSheetStateCompleted implements RenameSheetState {
  const RenameSheetStateCompleted({required this.isSeed});

  final bool isSeed;

  /// Create a copy of RenameSheetState
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @pragma('vm:prefer-inline')
  $RenameSheetStateCompletedCopyWith<RenameSheetStateCompleted> get copyWith =>
      _$RenameSheetStateCompletedCopyWithImpl<RenameSheetStateCompleted>(
          this, _$identity);

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is RenameSheetStateCompleted &&
            (identical(other.isSeed, isSeed) || other.isSeed == isSeed));
  }

  @override
  int get hashCode => Object.hash(runtimeType, isSeed);

  @override
  String toString() {
    return 'RenameSheetState.completed(isSeed: $isSeed)';
  }
}

/// @nodoc
abstract mixin class $RenameSheetStateCompletedCopyWith<$Res>
    implements $RenameSheetStateCopyWith<$Res> {
  factory $RenameSheetStateCompletedCopyWith(RenameSheetStateCompleted value,
          $Res Function(RenameSheetStateCompleted) _then) =
      _$RenameSheetStateCompletedCopyWithImpl;
  @useResult
  $Res call({bool isSeed});
}

/// @nodoc
class _$RenameSheetStateCompletedCopyWithImpl<$Res>
    implements $RenameSheetStateCompletedCopyWith<$Res> {
  _$RenameSheetStateCompletedCopyWithImpl(this._self, this._then);

  final RenameSheetStateCompleted _self;
  final $Res Function(RenameSheetStateCompleted) _then;

  /// Create a copy of RenameSheetState
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  $Res call({
    Object? isSeed = null,
  }) {
    return _then(RenameSheetStateCompleted(
      isSeed: null == isSeed
          ? _self.isSeed
          : isSeed // ignore: cast_nullable_to_non_nullable
              as bool,
    ));
  }
}

// dart format on
