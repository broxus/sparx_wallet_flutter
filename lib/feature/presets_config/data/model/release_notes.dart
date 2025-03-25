import 'package:app/feature/presets_config/data/model/release_note.dart';
import 'package:freezed_annotation/freezed_annotation.dart';

part 'release_notes.freezed.dart';
part 'release_notes.g.dart';

@freezed
class ReleaseNotes with _$ReleaseNotes {
  const factory ReleaseNotes({
    required Map<String, ReleaseNote> notes,
  }) = _ReleaseNotes;

  factory ReleaseNotes.fromJson(Map<String, dynamic> json) =>
      _$ReleaseNotesFromJson(json);
}
