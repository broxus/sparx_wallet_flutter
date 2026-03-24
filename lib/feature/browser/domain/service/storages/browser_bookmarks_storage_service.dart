import 'package:app/app/service/service.dart';
import 'package:app/core/sentry.dart';
import 'package:app/data/models/models.dart';
import 'package:app/utils/common_utils.dart';
import 'package:injectable/injectable.dart';
import 'package:logging/logging.dart';

const _browserBookmarksDomain = 'browser_bookmarks';
const _browserBookmarksKey = 'browser_bookmarks_key';

/// This is a wrapper-class above [StorageAdapter] that provides methods
/// to interact with all browser bookmark - related data.
@singleton
class BrowserBookmarksStorageService extends AbstractStorageService {
  BrowserBookmarksStorageService(this._storageAdapter)
    : _storage = _storageAdapter.box(_browserBookmarksDomain);

  static const container = _browserBookmarksDomain;

  final StorageAdapter _storageAdapter;
  final StorageBox _storage;

  final _sentry = SentryWorker.instance;

  final _log = Logger('BrowserBookmarksStorageService');

  /// Read list of browser bookmarks items from storage
  List<BrowserBookmarkItem> getBrowserBookmarks() {
    final list = _storage.read<List<dynamic>>(_browserBookmarksKey);
    if (list == null) {
      return [];
    }

    return [
      for (final entry in list)
        BrowserBookmarkItem.fromJson(entry as Map<String, dynamic>),
    ];
  }

  /// Save list of browser bookmarks items to storage
  void saveBrowserBookmarks(List<BrowserBookmarkItem> bookmarks) {
    _storage.write(
      _browserBookmarksKey,
      bookmarks.map((e) => e.toJson()).toList(),
    );
  }

  @override
  Future<void> init() async {
    await _storageAdapter.init(container);
  }

  @override
  Future<void> clear() async {
    await tryWrapper(_storage.erase, onCatch: _captureException);
  }

  Future<void> _captureException(Object e, StackTrace s) async {
    _log.severe('BrowserBookmarksStorageService captureException', e, s);
    _sentry.captureException(e, stackTrace: s);
  }
}
