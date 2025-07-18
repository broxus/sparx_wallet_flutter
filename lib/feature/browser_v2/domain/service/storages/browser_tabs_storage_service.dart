import 'package:app/app/service/service.dart';
import 'package:app/feature/browser_v2/data/tabs/browser_tab.dart';
import 'package:get_storage/get_storage.dart';
import 'package:injectable/injectable.dart';

const _browserTabsDomain = 'browser_tabs';
const _browserTabsActiveTabIdKey = 'browser_tabs_active_tab_id_key';

/// This is a wrapper-class above [GetStorage] that provides methods
/// to interact with all browser tabs - related data.
@singleton
class BrowserTabsStorageService extends AbstractStorageService {
  BrowserTabsStorageService(
    @Named(container) this._storage,
  );

  static const container = _browserTabsDomain;
  static const browserTabsKey = 'browser_tabs_key';

  final GetStorage _storage;

  /// Read active tab from storage
  String? getActiveTabId() => _storage.read(_browserTabsActiveTabIdKey);

  /// Read list of browser tabs from storage
  List<BrowserTab> getTabs() {
    final list = _storage.read<List<dynamic>>(browserTabsKey);
    if (list == null) {
      return [];
    }

    return [
      for (final entry in list)
        BrowserTab.fromJson(entry as Map<String, dynamic>),
    ];
  }

  /// Save active tab id to storage
  void saveBrowserActiveTabId(String? id) {
    _storage.write(_browserTabsActiveTabIdKey, id);
  }

  /// Save list of browser tabs to storage
  void saveBrowserTabs(List<BrowserTab> tabs) {
    _storage.write(
      browserTabsKey,
      tabs.map((e) => e.toJson()).toList(),
    );
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
}
