import 'package:app/utils/common_utils.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:uuid/uuid.dart';

part 'browser_group.freezed.dart';

part 'browser_group.g.dart';

const tabsGroupId = 'mainTabsGroup';

@freezed
class BrowserGroup with _$BrowserGroup {
  const factory BrowserGroup({
    required String id,
    required String? title,
    @Default(<String>[]) List<String> tabsIds,
    required double sortingOrder,
    @Default(true) bool isEditable,
  }) = _BrowserGroup;

  factory BrowserGroup.fromJson(Map<String, dynamic> json) =>
      _$BrowserGroupFromJson(json);

  static BrowserGroup create({
    required String name,
    List<String>? tabsIds,
    bool isEditable = true,
  }) {
    return BrowserGroup(
      id: const Uuid().v4(),
      title: name,
      tabsIds: tabsIds ?? <String>[],
      sortingOrder: NtpTime.now().millisecondsSinceEpoch.toDouble(),
      isEditable: isEditable,
    );
  }
}

extension BrowserGroupExt on BrowserGroup {
  int get tabsCount => tabsIds.length;

  String get tabsCountText => tabsIds.length.toString();
}
