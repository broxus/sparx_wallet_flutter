import 'package:app/feature/browser_v2/data/browser_item.dart';
import 'package:app/utils/common_utils.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:uuid/uuid.dart';

part 'browser_group.freezed.dart';

part 'browser_group.g.dart';

const tabsGroupId = 'mainTabsGroup';

@freezed
class BrowserGroup with _$BrowserGroup implements BrowserItem {
  const factory BrowserGroup({
    required String id,
    required String? title,
    @Default([]) List<String> tabsIds,
    required double sortingOrder,
    @Default(false) bool isCanRemoved,
    @Default(false) bool isCanEditTitle,
  }) = _BrowserGroup;

  factory BrowserGroup.fromJson(Map<String, dynamic> json) =>
      _$BrowserGroupFromJson(json);

  static BrowserGroup create({
    required String name,
    List<String>? tabsIds,
    bool isCanRemoved = false,
  }) {
    return BrowserGroup(
      id: const Uuid().v4(),
      title: name,
      tabsIds: tabsIds ?? [],
      sortingOrder: NtpTime.now().millisecondsSinceEpoch.toDouble(),
      isCanRemoved: isCanRemoved,
    );
  }
}

extension BrowserGroupExt on BrowserGroup {
  int get tabsCount => tabsIds.length;

  String get tabsCountText => tabsIds.length.toString();
}
