// dart format width=80
// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'release_note.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// dart format off
T _$identity<T>(T value) => value;

/// @nodoc
mixin _$ReleaseNote {
  /// Whether this release note information is available/active.
  bool get available;

  /// Detailed information about the release shown to the user.
  String get info;

  /// Create a copy of ReleaseNote
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @pragma('vm:prefer-inline')
  $ReleaseNoteCopyWith<ReleaseNote> get copyWith =>
      _$ReleaseNoteCopyWithImpl<ReleaseNote>(this as ReleaseNote, _$identity);

  /// Serializes this ReleaseNote to a JSON map.
  Map<String, dynamic> toJson();

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is ReleaseNote &&
            (identical(other.available, available) ||
                other.available == available) &&
            (identical(other.info, info) || other.info == info));
  }

  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  int get hashCode => Object.hash(runtimeType, available, info);

  @override
  String toString() {
    return 'ReleaseNote(available: $available, info: $info)';
  }
}

/// @nodoc
abstract mixin class $ReleaseNoteCopyWith<$Res> {
  factory $ReleaseNoteCopyWith(
          ReleaseNote value, $Res Function(ReleaseNote) _then) =
      _$ReleaseNoteCopyWithImpl;
  @useResult
  $Res call({bool available, String info});
}

/// @nodoc
class _$ReleaseNoteCopyWithImpl<$Res> implements $ReleaseNoteCopyWith<$Res> {
  _$ReleaseNoteCopyWithImpl(this._self, this._then);

  final ReleaseNote _self;
  final $Res Function(ReleaseNote) _then;

  /// Create a copy of ReleaseNote
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? available = null,
    Object? info = null,
  }) {
    return _then(_self.copyWith(
      available: null == available
          ? _self.available
          : available // ignore: cast_nullable_to_non_nullable
              as bool,
      info: null == info
          ? _self.info
          : info // ignore: cast_nullable_to_non_nullable
              as String,
    ));
  }
}

/// @nodoc
@JsonSerializable()
class _ReleaseNote implements ReleaseNote {
  const _ReleaseNote({required this.available, required this.info});
  factory _ReleaseNote.fromJson(Map<String, dynamic> json) =>
      _$ReleaseNoteFromJson(json);

  /// Whether this release note information is available/active.
  @override
  final bool available;

  /// Detailed information about the release shown to the user.
  @override
  final String info;

  /// Create a copy of ReleaseNote
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  @pragma('vm:prefer-inline')
  _$ReleaseNoteCopyWith<_ReleaseNote> get copyWith =>
      __$ReleaseNoteCopyWithImpl<_ReleaseNote>(this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$ReleaseNoteToJson(
      this,
    );
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _ReleaseNote &&
            (identical(other.available, available) ||
                other.available == available) &&
            (identical(other.info, info) || other.info == info));
  }

  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  int get hashCode => Object.hash(runtimeType, available, info);

  @override
  String toString() {
    return 'ReleaseNote(available: $available, info: $info)';
  }
}

/// @nodoc
abstract mixin class _$ReleaseNoteCopyWith<$Res>
    implements $ReleaseNoteCopyWith<$Res> {
  factory _$ReleaseNoteCopyWith(
          _ReleaseNote value, $Res Function(_ReleaseNote) _then) =
      __$ReleaseNoteCopyWithImpl;
  @override
  @useResult
  $Res call({bool available, String info});
}

/// @nodoc
class __$ReleaseNoteCopyWithImpl<$Res> implements _$ReleaseNoteCopyWith<$Res> {
  __$ReleaseNoteCopyWithImpl(this._self, this._then);

  final _ReleaseNote _self;
  final $Res Function(_ReleaseNote) _then;

  /// Create a copy of ReleaseNote
  /// with the given fields replaced by the non-null parameter values.
  @override
  @pragma('vm:prefer-inline')
  $Res call({
    Object? available = null,
    Object? info = null,
  }) {
    return _then(_ReleaseNote(
      available: null == available
          ? _self.available
          : available // ignore: cast_nullable_to_non_nullable
              as bool,
      info: null == info
          ? _self.info
          : info // ignore: cast_nullable_to_non_nullable
              as String,
    ));
  }
}

// dart format on
