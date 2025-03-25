import 'dart:collection';

import 'package:app/feature/browser_v2/service/storages/browser_favicon_url_storage_service.dart';
import 'package:elementary_helper/elementary_helper.dart';

class FaviconManager {
  FaviconManager(
    this._browserFaviconURLStorageService,
  );

  final BrowserFaviconURLStorageService _browserFaviconURLStorageService;

  final _cache = FaviconData._();

  Future<String?> getFavicon(Uri uri) async {
    if (_cache.checkExist(uri)) {
      return _cache.getSafe(uri);
    }

    final faviconUrl =
        await _browserFaviconURLStorageService.getFaviconURL(uri);

    if (faviconUrl == null) {
      return null;
    }

    _cache.upgrade(uri, faviconUrl);

    return faviconUrl;
  }
}

class FaviconData {
  FaviconData._([
    HashMap<Uri, String>? cache,
  ]) : _cache = cache ?? HashMap();

  final HashMap<Uri, String> _cache;

  bool checkExist(Uri key) => _cache[key] != null;

  String getSafe(Uri key) => _cache[key] ?? '';

  FaviconData upgrade(Uri uri, String faviconUrl) {
    _cache[uri] = faviconUrl;
    return FaviconData._(_cache);
  }
}
