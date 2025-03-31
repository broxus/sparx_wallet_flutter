// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'release_notes.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
    'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#adding-getters-and-methods-to-our-models');

ReleaseNotes _$ReleaseNotesFromJson(Map<String, dynamic> json) {
  return _ReleaseNotes.fromJson(json);
}

/// @nodoc
mixin _$ReleaseNotes {
  Map<String, ReleaseNote> get notes => throw _privateConstructorUsedError;

  /// Serializes this ReleaseNotes to a JSON map.
  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;

  /// Create a copy of ReleaseNotes
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  $ReleaseNotesCopyWith<ReleaseNotes> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $ReleaseNotesCopyWith<$Res> {
  factory $ReleaseNotesCopyWith(
          ReleaseNotes value, $Res Function(ReleaseNotes) then) =
      _$ReleaseNotesCopyWithImpl<$Res, ReleaseNotes>;
  @useResult
  $Res call({Map<String, ReleaseNote> notes});
}

/// @nodoc
class _$ReleaseNotesCopyWithImpl<$Res, $Val extends ReleaseNotes>
    implements $ReleaseNotesCopyWith<$Res> {
  _$ReleaseNotesCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  /// Create a copy of ReleaseNotes
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? notes = null,
  }) {
    return _then(_value.copyWith(
      notes: null == notes
          ? _value.notes
          : notes // ignore: cast_nullable_to_non_nullable
              as Map<String, ReleaseNote>,
    ) as $Val);
  }
}

/// @nodoc
abstract class _$$ReleaseNotesImplCopyWith<$Res>
    implements $ReleaseNotesCopyWith<$Res> {
  factory _$$ReleaseNotesImplCopyWith(
          _$ReleaseNotesImpl value, $Res Function(_$ReleaseNotesImpl) then) =
      __$$ReleaseNotesImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call({Map<String, ReleaseNote> notes});
}

/// @nodoc
class __$$ReleaseNotesImplCopyWithImpl<$Res>
    extends _$ReleaseNotesCopyWithImpl<$Res, _$ReleaseNotesImpl>
    implements _$$ReleaseNotesImplCopyWith<$Res> {
  __$$ReleaseNotesImplCopyWithImpl(
      _$ReleaseNotesImpl _value, $Res Function(_$ReleaseNotesImpl) _then)
      : super(_value, _then);

  /// Create a copy of ReleaseNotes
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? notes = null,
  }) {
    return _then(_$ReleaseNotesImpl(
      notes: null == notes
          ? _value._notes
          : notes // ignore: cast_nullable_to_non_nullable
              as Map<String, ReleaseNote>,
    ));
  }
}

/// @nodoc
@JsonSerializable()
class _$ReleaseNotesImpl implements _ReleaseNotes {
  const _$ReleaseNotesImpl({required final Map<String, ReleaseNote> notes})
      : _notes = notes;

  factory _$ReleaseNotesImpl.fromJson(Map<String, dynamic> json) =>
      _$$ReleaseNotesImplFromJson(json);

  final Map<String, ReleaseNote> _notes;
  @override
  Map<String, ReleaseNote> get notes {
    if (_notes is EqualUnmodifiableMapView) return _notes;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableMapView(_notes);
  }

  @override
  String toString() {
    return 'ReleaseNotes(notes: $notes)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$ReleaseNotesImpl &&
            const DeepCollectionEquality().equals(other._notes, _notes));
  }

  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  int get hashCode =>
      Object.hash(runtimeType, const DeepCollectionEquality().hash(_notes));

  /// Create a copy of ReleaseNotes
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$ReleaseNotesImplCopyWith<_$ReleaseNotesImpl> get copyWith =>
      __$$ReleaseNotesImplCopyWithImpl<_$ReleaseNotesImpl>(this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$ReleaseNotesImplToJson(
      this,
    );
  }
}

abstract class _ReleaseNotes implements ReleaseNotes {
  const factory _ReleaseNotes({required final Map<String, ReleaseNote> notes}) =
      _$ReleaseNotesImpl;

  factory _ReleaseNotes.fromJson(Map<String, dynamic> json) =
      _$ReleaseNotesImpl.fromJson;

  @override
  Map<String, ReleaseNote> get notes;

  /// Create a copy of ReleaseNotes
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$ReleaseNotesImplCopyWith<_$ReleaseNotesImpl> get copyWith =>
      throw _privateConstructorUsedError;
}
