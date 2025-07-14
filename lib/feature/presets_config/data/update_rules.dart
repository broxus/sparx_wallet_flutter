import 'package:freezed_annotation/freezed_annotation.dart';

part 'update_rules.freezed.dart';
part 'update_rules.g.dart';

/// Rules that govern the app update behavior.
///
/// Defines which versions require updates (blocking/warning) and
/// controls how update notifications are displayed to users.
@freezed
class UpdateRules with _$UpdateRules {
  const factory UpdateRules({
    /// Minimum version required - users below this version cannot use the app.
    required String blockingVersion,

    /// Version that triggers warning - users below this should update but can
    /// continue.
    required String warningVersion,

    /// Maximum number of times to show the warning notification.
    required int warningShowTimes,

    /// Delay in seconds between showing warning notifications.
    required int warningShowDelayS,
  }) = _UpdateRules;

  factory UpdateRules.fromJson(Map<String, dynamic> json) =>
      _$UpdateRulesFromJson(json);
}
