import 'dart:async';

import 'package:app/app/service/service.dart';
import 'package:flutter/cupertino.dart';
import 'package:injectable/injectable.dart';
import 'package:logging/logging.dart';

const _browserFaviconURLDomain = 'browser_favicon_urls';

@singleton
class BrowserFaviconURLStorageService extends AbstractStorageService {
  BrowserFaviconURLStorageService(this._storageAdapter)
    : _storage = _storageAdapter.box(_browserFaviconURLDomain);

  static final _log = Logger('BrowserFaviconURLStorageService');

  static const container = _browserFaviconURLDomain;

  final StorageAdapter _storageAdapter;
  final StorageBox _storage;

  Future<String?> getFaviconURL(String url) async {
    try {
      return _storage.read<String>(url);
    } catch (e, s) {
      _log.severe('Favicon get exception $e\n$s');
      debugPrintStack(stackTrace: s);
      return null;
    }
  }

  Future<void> saveFaviconUrl(String url, String iconUrl) async {
    try {
      await _storage.write(url, iconUrl);
    } catch (e, s) {
      _log.severe('Favicon save exception $e');
      debugPrintStack(stackTrace: s);
    }
  }

  @override
  Future<void> clear() async {
    try {
      return await _storage.erase();
    } catch (_) {}
  }

  @override
  Future<void> init() async {
    await _storageAdapter.init(container);
  }
}
