// dart format width=80
// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'release_notes.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// dart format off
T _$identity<T>(T value) => value;

/// @nodoc
mixin _$ReleaseNotes {
  /// Map of version identifiers to their corresponding release notes.
  /// The key is typically a version string like "1.0.0".
  Map<String, ReleaseNote> get notes;

  /// Create a copy of ReleaseNotes
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @pragma('vm:prefer-inline')
  $ReleaseNotesCopyWith<ReleaseNotes> get copyWith =>
      _$ReleaseNotesCopyWithImpl<ReleaseNotes>(
          this as ReleaseNotes, _$identity);

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is ReleaseNotes &&
            const DeepCollectionEquality().equals(other.notes, notes));
  }

  @override
  int get hashCode =>
      Object.hash(runtimeType, const DeepCollectionEquality().hash(notes));

  @override
  String toString() {
    return 'ReleaseNotes(notes: $notes)';
  }
}

/// @nodoc
abstract mixin class $ReleaseNotesCopyWith<$Res> {
  factory $ReleaseNotesCopyWith(
          ReleaseNotes value, $Res Function(ReleaseNotes) _then) =
      _$ReleaseNotesCopyWithImpl;
  @useResult
  $Res call({Map<String, ReleaseNote> notes});
}

/// @nodoc
class _$ReleaseNotesCopyWithImpl<$Res> implements $ReleaseNotesCopyWith<$Res> {
  _$ReleaseNotesCopyWithImpl(this._self, this._then);

  final ReleaseNotes _self;
  final $Res Function(ReleaseNotes) _then;

  /// Create a copy of ReleaseNotes
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? notes = null,
  }) {
    return _then(_self.copyWith(
      notes: null == notes
          ? _self.notes
          : notes // ignore: cast_nullable_to_non_nullable
              as Map<String, ReleaseNote>,
    ));
  }
}

/// @nodoc

class _ReleaseNotes extends ReleaseNotes {
  const _ReleaseNotes({required final Map<String, ReleaseNote> notes})
      : _notes = notes,
        super._();

  /// Map of version identifiers to their corresponding release notes.
  /// The key is typically a version string like "1.0.0".
  final Map<String, ReleaseNote> _notes;

  /// Map of version identifiers to their corresponding release notes.
  /// The key is typically a version string like "1.0.0".
  @override
  Map<String, ReleaseNote> get notes {
    if (_notes is EqualUnmodifiableMapView) return _notes;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableMapView(_notes);
  }

  /// Create a copy of ReleaseNotes
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  @pragma('vm:prefer-inline')
  _$ReleaseNotesCopyWith<_ReleaseNotes> get copyWith =>
      __$ReleaseNotesCopyWithImpl<_ReleaseNotes>(this, _$identity);

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _ReleaseNotes &&
            const DeepCollectionEquality().equals(other._notes, _notes));
  }

  @override
  int get hashCode =>
      Object.hash(runtimeType, const DeepCollectionEquality().hash(_notes));

  @override
  String toString() {
    return 'ReleaseNotes(notes: $notes)';
  }
}

/// @nodoc
abstract mixin class _$ReleaseNotesCopyWith<$Res>
    implements $ReleaseNotesCopyWith<$Res> {
  factory _$ReleaseNotesCopyWith(
          _ReleaseNotes value, $Res Function(_ReleaseNotes) _then) =
      __$ReleaseNotesCopyWithImpl;
  @override
  @useResult
  $Res call({Map<String, ReleaseNote> notes});
}

/// @nodoc
class __$ReleaseNotesCopyWithImpl<$Res>
    implements _$ReleaseNotesCopyWith<$Res> {
  __$ReleaseNotesCopyWithImpl(this._self, this._then);

  final _ReleaseNotes _self;
  final $Res Function(_ReleaseNotes) _then;

  /// Create a copy of ReleaseNotes
  /// with the given fields replaced by the non-null parameter values.
  @override
  @pragma('vm:prefer-inline')
  $Res call({
    Object? notes = null,
  }) {
    return _then(_ReleaseNotes(
      notes: null == notes
          ? _self._notes
          : notes // ignore: cast_nullable_to_non_nullable
              as Map<String, ReleaseNote>,
    ));
  }
}

// dart format on
