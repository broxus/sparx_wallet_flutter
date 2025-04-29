import 'dart:async';
import 'dart:collection';

import 'package:app/feature/browser_v2/domain/service/storages/browser_favicon_url_storage_service.dart';
import 'package:favicon/favicon.dart';

const _suffixes = ['png', 'ico'];

class FaviconManager {
  FaviconManager(
    this._browserFaviconURLStorageService,
  );

  final BrowserFaviconURLStorageService _browserFaviconURLStorageService;

  final _cache = HashMap<Uri, String>();

  Future<String?> getFaviconURL(Uri uri) async {
    if (_cache[uri] != null) {
      return _cache[uri];
    }

    final url = uri.toString();

    var iconUrl = await _browserFaviconURLStorageService.getFaviconURL(url);

    if (iconUrl == null) {
      final loadedUrl =
          (await FaviconFinder.getBest(url, suffixes: _suffixes))?.url;

      if (loadedUrl != null) {
        unawaited(
          _browserFaviconURLStorageService.saveFaviconUrl(url, loadedUrl),
        );
      }
      iconUrl = loadedUrl;
    }

    if (iconUrl == null) {
      return null;
    }
    return _cache[uri] = iconUrl;
  }
}
