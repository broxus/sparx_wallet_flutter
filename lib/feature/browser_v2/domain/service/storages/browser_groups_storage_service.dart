import 'package:app/app/service/service.dart';
import 'package:app/feature/browser_v2/data/groups/browser_group.dart';
import 'package:get_storage/get_storage.dart';
import 'package:injectable/injectable.dart';

const _browserGroupsDomain = 'browser_groups';

/// This is a wrapper-class above [GetStorage] that provides methods
/// to interact with all browser tabs - related data.
@singleton
class BrowserGroupsStorageService extends AbstractStorageService {
  BrowserGroupsStorageService(
    @Named(container) this._storage,
  );

  static const container = _browserGroupsDomain;
  static const browserGroupsKey = 'browser_groups_key';

  final GetStorage _storage;

  List<BrowserGroup> getGroups() {
    final list = _storage.read<List<dynamic>>(browserGroupsKey);
    if (list == null) {
      return [];
    }

    return [
      for (final entry in list)
        BrowserGroup.fromJson(entry as Map<String, dynamic>),
    ];
  }

  @override
  Future<void> init() async {
    await GetStorage.init(container);
  }

  @override
  Future<void> clear() async {
    try {
      await _storage.erase();
    } catch (_) {}
  }

  void saveBrowserGroups(List<BrowserGroup> groups) {
    _storage.write(
      browserGroupsKey,
      groups.map((e) => e.toJson()).toList(),
    );
  }
}
