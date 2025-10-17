import 'dart:async';
import 'dart:collection';

import 'package:app/feature/browser_v2/domain/delegates/browser_base_delegate.dart';
import 'package:app/feature/browser_v2/domain/service/storages/browser_favicon_url_storage_service.dart';
import 'package:favicon/favicon.dart';
import 'package:injectable/injectable.dart';

const _suffixes = ['png', 'ico'];

// ignore: one_member_abstracts
abstract interface class BrowserServiceFavicon {
  Future<String?> getFaviconURL(Uri uri);
}

@injectable
class BrowserServiceFaviconDelegate
    implements BrowserDelegate, BrowserServiceFavicon {
  BrowserServiceFaviconDelegate(this._browserFaviconURLStorageService);

  final BrowserFaviconURLStorageService _browserFaviconURLStorageService;

  final _cache = HashMap<Uri, String>();

  @override
  Future<String?> getFaviconURL(Uri uri) async {
    if (_cache[uri] != null) {
      return _cache[uri];
    }

    final url = uri.toString();

    var iconUrl = await _browserFaviconURLStorageService.getFaviconURL(url);

    if (iconUrl == null) {
      final loadedUrl = (await FaviconFinder.getBest(
        url,
        suffixes: _suffixes,
      ))?.url;

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
