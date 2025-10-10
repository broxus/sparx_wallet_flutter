import 'package:app/feature/presets_config/data/release_note.dart';
import 'package:freezed_annotation/freezed_annotation.dart';

part 'release_notes.freezed.dart';

/// Collection of release notes for different app versions.
///
/// Maps version identifiers to their corresponding release note information.
@freezed
abstract class ReleaseNotes with _$ReleaseNotes {
  const factory ReleaseNotes({
    /// Map of version identifiers to their corresponding release notes.
    /// The key is typically a version string like "1.0.0".
    required Map<String, ReleaseNote> notes,
  }) = _ReleaseNotes;

  const ReleaseNotes._();

  factory ReleaseNotes.fromJson(Map<String, dynamic> json) {
    return ReleaseNotes(
      notes: json.map(
        (k, e) => MapEntry(k, ReleaseNote.fromJson(e as Map<String, dynamic>)),
      ),
    );
  }

  Map<String, dynamic> toJson() {
    return notes.map((k, e) => MapEntry(k, e.toJson()));
  }
}
