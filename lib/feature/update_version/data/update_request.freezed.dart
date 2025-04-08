// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'update_request.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
    'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#adding-getters-and-methods-to-our-models');

/// @nodoc
mixin _$UpdateRequest {
  /// The status of the update (blocking, warning, none)
  UpdateStatus get status => throw _privateConstructorUsedError;

  /// The target version to update to
  String? get targetVersion => throw _privateConstructorUsedError;

  /// Optional release notes for the target version
  ReleaseNote? get releaseNote => throw _privateConstructorUsedError;

  /// Create a copy of UpdateRequest
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  $UpdateRequestCopyWith<UpdateRequest> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $UpdateRequestCopyWith<$Res> {
  factory $UpdateRequestCopyWith(
          UpdateRequest value, $Res Function(UpdateRequest) then) =
      _$UpdateRequestCopyWithImpl<$Res, UpdateRequest>;
  @useResult
  $Res call(
      {UpdateStatus status, String? targetVersion, ReleaseNote? releaseNote});

  $ReleaseNoteCopyWith<$Res>? get releaseNote;
}

/// @nodoc
class _$UpdateRequestCopyWithImpl<$Res, $Val extends UpdateRequest>
    implements $UpdateRequestCopyWith<$Res> {
  _$UpdateRequestCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  /// Create a copy of UpdateRequest
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? status = null,
    Object? targetVersion = freezed,
    Object? releaseNote = freezed,
  }) {
    return _then(_value.copyWith(
      status: null == status
          ? _value.status
          : status // ignore: cast_nullable_to_non_nullable
              as UpdateStatus,
      targetVersion: freezed == targetVersion
          ? _value.targetVersion
          : targetVersion // ignore: cast_nullable_to_non_nullable
              as String?,
      releaseNote: freezed == releaseNote
          ? _value.releaseNote
          : releaseNote // ignore: cast_nullable_to_non_nullable
              as ReleaseNote?,
    ) as $Val);
  }

  /// Create a copy of UpdateRequest
  /// with the given fields replaced by the non-null parameter values.
  @override
  @pragma('vm:prefer-inline')
  $ReleaseNoteCopyWith<$Res>? get releaseNote {
    if (_value.releaseNote == null) {
      return null;
    }

    return $ReleaseNoteCopyWith<$Res>(_value.releaseNote!, (value) {
      return _then(_value.copyWith(releaseNote: value) as $Val);
    });
  }
}

/// @nodoc
abstract class _$$UpdateRequestImplCopyWith<$Res>
    implements $UpdateRequestCopyWith<$Res> {
  factory _$$UpdateRequestImplCopyWith(
          _$UpdateRequestImpl value, $Res Function(_$UpdateRequestImpl) then) =
      __$$UpdateRequestImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call(
      {UpdateStatus status, String? targetVersion, ReleaseNote? releaseNote});

  @override
  $ReleaseNoteCopyWith<$Res>? get releaseNote;
}

/// @nodoc
class __$$UpdateRequestImplCopyWithImpl<$Res>
    extends _$UpdateRequestCopyWithImpl<$Res, _$UpdateRequestImpl>
    implements _$$UpdateRequestImplCopyWith<$Res> {
  __$$UpdateRequestImplCopyWithImpl(
      _$UpdateRequestImpl _value, $Res Function(_$UpdateRequestImpl) _then)
      : super(_value, _then);

  /// Create a copy of UpdateRequest
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? status = null,
    Object? targetVersion = freezed,
    Object? releaseNote = freezed,
  }) {
    return _then(_$UpdateRequestImpl(
      status: null == status
          ? _value.status
          : status // ignore: cast_nullable_to_non_nullable
              as UpdateStatus,
      targetVersion: freezed == targetVersion
          ? _value.targetVersion
          : targetVersion // ignore: cast_nullable_to_non_nullable
              as String?,
      releaseNote: freezed == releaseNote
          ? _value.releaseNote
          : releaseNote // ignore: cast_nullable_to_non_nullable
              as ReleaseNote?,
    ));
  }
}

/// @nodoc

class _$UpdateRequestImpl implements _UpdateRequest {
  const _$UpdateRequestImpl(
      {required this.status, this.targetVersion, this.releaseNote});

  /// The status of the update (blocking, warning, none)
  @override
  final UpdateStatus status;

  /// The target version to update to
  @override
  final String? targetVersion;

  /// Optional release notes for the target version
  @override
  final ReleaseNote? releaseNote;

  @override
  String toString() {
    return 'UpdateRequest(status: $status, targetVersion: $targetVersion, releaseNote: $releaseNote)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$UpdateRequestImpl &&
            (identical(other.status, status) || other.status == status) &&
            (identical(other.targetVersion, targetVersion) ||
                other.targetVersion == targetVersion) &&
            (identical(other.releaseNote, releaseNote) ||
                other.releaseNote == releaseNote));
  }

  @override
  int get hashCode =>
      Object.hash(runtimeType, status, targetVersion, releaseNote);

  /// Create a copy of UpdateRequest
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$UpdateRequestImplCopyWith<_$UpdateRequestImpl> get copyWith =>
      __$$UpdateRequestImplCopyWithImpl<_$UpdateRequestImpl>(this, _$identity);
}

abstract class _UpdateRequest implements UpdateRequest {
  const factory _UpdateRequest(
      {required final UpdateStatus status,
      final String? targetVersion,
      final ReleaseNote? releaseNote}) = _$UpdateRequestImpl;

  /// The status of the update (blocking, warning, none)
  @override
  UpdateStatus get status;

  /// The target version to update to
  @override
  String? get targetVersion;

  /// Optional release notes for the target version
  @override
  ReleaseNote? get releaseNote;

  /// Create a copy of UpdateRequest
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$UpdateRequestImplCopyWith<_$UpdateRequestImpl> get copyWith =>
      throw _privateConstructorUsedError;
}
