// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'release_notes.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_$ReleaseNotesImpl _$$ReleaseNotesImplFromJson(Map<String, dynamic> json) =>
    _$ReleaseNotesImpl(
      notes: (json['notes'] as Map<String, dynamic>).map(
        (k, e) => MapEntry(k, ReleaseNote.fromJson(e as Map<String, dynamic>)),
      ),
    );

Map<String, dynamic> _$$ReleaseNotesImplToJson(_$ReleaseNotesImpl instance) =>
    <String, dynamic>{
      'notes': instance.notes.map((k, e) => MapEntry(k, e.toJson())),
    };
