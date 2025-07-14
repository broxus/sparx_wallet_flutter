import 'package:freezed_annotation/freezed_annotation.dart';

part 'release_note.freezed.dart';
part 'release_note.g.dart';

/// Release note information for a specific app version.
///
/// Contains availability status and descriptive information about a release.
@freezed
class ReleaseNote with _$ReleaseNote {
  const factory ReleaseNote({
    /// Whether this release note information is available/active.
    required bool available,

    /// Detailed information about the release shown to the user.
    required String info,
  }) = _ReleaseNote;

  factory ReleaseNote.fromJson(Map<String, dynamic> json) =>
      _$ReleaseNoteFromJson(json);
}
