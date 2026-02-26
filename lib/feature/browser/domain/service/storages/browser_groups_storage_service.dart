import 'package:app/app/service/service.dart';
import 'package:app/feature/browser/data/groups/browser_group.dart';
import 'package:app/generated/generated.dart';
import 'package:injectable/injectable.dart';

const _browserGroupsDomain = 'browser_groups';

/// This is a wrapper-class above [StorageAdapter] that provides methods
/// to interact with all browser tabs - related data.
@singleton
class BrowserGroupsStorageService extends AbstractStorageService {
  BrowserGroupsStorageService(this._storageAdapter)
    : _storage = _storageAdapter.box(_browserGroupsDomain);

  static const container = _browserGroupsDomain;
  static const browserGroupsKey = 'browser_groups_key';

  final StorageAdapter _storageAdapter;
  final StorageBox _storage;

  @override
  Future<void> init() async {
    await _storageAdapter.init(container);
  }

  @override
  Future<void> clear() async {
    try {
      await _storage.erase();
    } catch (_) {}
  }

  List<BrowserGroup> getGroups() {
    final groups = _storage.read<List<dynamic>>(browserGroupsKey);

    if (groups == null) {
      return [];
    }

    return [
      for (final group in groups)
        BrowserGroup.fromJson(group as Map<String, dynamic>),
    ];
  }

  List<BrowserGroup> initGroups([List<String>? tabIds]) {
    final tabsGroup = <String, dynamic>{
      'id': tabsGroupId,
      'title': LocaleKeys.tabs.tr(),
      'tabsIds': tabIds ?? [],
      'sortingOrder': DateTime.now().millisecondsSinceEpoch.toDouble(),
      'isEditable': false,
    };

    _storage.write(browserGroupsKey, [tabsGroup]);

    return [BrowserGroup.fromJson(tabsGroup)];
  }

  void saveGroups(List<BrowserGroup> groups) {
    _storage.write(browserGroupsKey, groups.map((e) => e.toJson()).toList());
  }
}
