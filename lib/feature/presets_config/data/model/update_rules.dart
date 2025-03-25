import 'package:freezed_annotation/freezed_annotation.dart';

part 'update_rules.freezed.dart';
part 'update_rules.g.dart';

@freezed
class UpdateRules with _$UpdateRules {
  const factory UpdateRules({
    required String blockingVersion,
    required String warningVersion,
    required int warningShowTimes,
    required int warningShowDelayS,
  }) = _UpdateRules;

  factory UpdateRules.fromJson(Map<String, dynamic> json) =>
      _$UpdateRulesFromJson(json);
}
