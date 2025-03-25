import 'package:freezed_annotation/freezed_annotation.dart';

part 'release_note.freezed.dart';
part 'release_note.g.dart';

@freezed
class ReleaseNote with _$ReleaseNote {
  const factory ReleaseNote({
    required bool available,
    required String info,
  }) = _ReleaseNote;

  factory ReleaseNote.fromJson(Map<String, dynamic> json) =>
      _$ReleaseNoteFromJson(json);
}
