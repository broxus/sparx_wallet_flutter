import 'dart:collection';

import 'package:app/feature/browser_v2/service/storages/browser_favicon_url_storage_service.dart';

class FaviconManager {
  FaviconManager(
    this._browserFaviconURLStorageService,
  );

  final BrowserFaviconURLStorageService _browserFaviconURLStorageService;

  final _cache = HashMap<Uri, String>();

  Future<String?> getFavicon(Uri uri) async {
    if (_cache[uri] != null) {
      return _cache[uri];
    }

    final faviconUrl =
        await _browserFaviconURLStorageService.getFaviconURL(uri);

    if (faviconUrl == null) {
      return null;
    }

    return _cache[uri] = faviconUrl;
  }
}
