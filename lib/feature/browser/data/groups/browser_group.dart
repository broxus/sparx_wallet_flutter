import 'package:app/feature/browser/data/broser_entity.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:uuid/uuid.dart';

part 'browser_group.freezed.dart';
part 'browser_group.g.dart';

const tabsGroupId = 'mainTabsGroup';

@unfreezed
abstract class BrowserGroup with _$BrowserGroup implements BrowserEntity {
  factory BrowserGroup({
    required String id,
    required String? title,
    required double sortingOrder,
    @Default(<String>[]) List<String> tabsIds,
    @Default(true) bool isEditable,
  }) = _BrowserGroup;

  factory BrowserGroup.fromJson(Map<String, dynamic> json) =>
      _$BrowserGroupFromJson(json);

  factory BrowserGroup.create({
    required String name,
    List<String>? tabsIds,
    bool isEditable = true,
  }) {
    return BrowserGroup(
      id: const Uuid().v4(),
      title: name,
      tabsIds: tabsIds ?? <String>[],
      sortingOrder: DateTime.now().millisecondsSinceEpoch.toDouble(),
      isEditable: isEditable,
    );
  }

  const BrowserGroup._();

  String get tabsCountText => tabsIds.length.toString();
}
