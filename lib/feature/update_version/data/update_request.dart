import 'package:app/feature/presets_config/data/release_note.dart';
import 'package:app/feature/update_version/data/update_status.dart';
import 'package:freezed_annotation/freezed_annotation.dart';

part 'update_request.freezed.dart';

/// Represents a request to show an update notification to the user
@freezed
class UpdateRequest with _$UpdateRequest {
  /// Creates a new update request
  const factory UpdateRequest({
    /// The status of the update (blocking, warning, none)
    required UpdateStatus status,

    /// The target version to update to
    String? targetVersion,

    /// Optional release notes for the target version
    ReleaseNote? releaseNote,
  }) = _UpdateRequest;
}
