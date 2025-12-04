import 'dart:collection';
import 'dart:convert';

import 'package:app/app/service/resources_service.dart';
import 'package:app/feature/browser/domain/delegates/browser_base_delegate.dart';
import 'package:app/utils/json/json.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/services.dart';
import 'package:injectable/injectable.dart';
import 'package:logging/logging.dart';

abstract interface class BrowserAntiPhishing {
  bool checkIsPhishingUri(Uri uri);

  Future<String> getPhishingGuardHtml(Uri uri);

  void addToWhiteList(String url);
}

@injectable
class BrowserAntiPhishingDelegate
    implements BrowserDelegate, BrowserAntiPhishing {
  BrowserAntiPhishingDelegate(this._resourcesService);

  static final _schemeRegExp = RegExp(
    r'^(?:[a-z][a-z0-9+\-.]*://)',
    caseSensitive: false,
  );

  static final _schemeDomainExp = RegExp(r'^www\d*\.', caseSensitive: false);

  final _blackList = HashSet<String>();

  final _phishingHostCache = HashSet<String>();

  final _whiteListHostCache = HashSet<String>();

  final ResourcesService _resourcesService;

  final _log = Logger('BrowserAntiPhishingManager');
  String? _htmlCache;

  Future<void> init() {
    return _loadLinksJson();
  }

  void dispose() {
    _blackList.clear();
    _phishingHostCache.clear();
    _whiteListHostCache.clear();
  }

  @override
  bool checkIsPhishingUri(Uri uri) {
    final url = _upgradeUrl(uri.toString());

    if (_whiteListHostCache.contains(url)) {
      return false;
    } else if (_phishingHostCache.contains(url)) {
      return true;
    }

    for (final link in _blackList) {
      if (url.contains(link) || _checkPattern(url, link)) {
        _phishingHostCache.add(url);
        return true;
      }
    }

    return false;
  }

  @override
  Future<String> getPhishingGuardHtml(Uri uri) async {
    final html = _htmlCache ??= await rootBundle.loadString(
      'assets/html/anti_phishing.html',
    );

    return html.replaceFirst('{PHISHING_ORIGINAL_SITE}', uri.toString());
  }

  @override
  void addToWhiteList(String url) {
    try {
      _whiteListHostCache.add(_upgradeUrl(url));
    } catch (e, s) {
      _log.severe('Error add url to whitelist', e, s);
    }
  }

  Future<void> _loadLinksJson() async {
    try {
      final json = await _resourcesService.loadString(
        'assets/configs/anti_phishing.json',
      );

      final map = await compute<String, Map<String, dynamic>>(_parse, json);
      _blackList.addAll(castJsonList<String>(map['blacklist']));
    } catch (e, s) {
      _log.severe('Load blacklist JSON error', e, s);
    }
  }

  String _upgradeUrl(String url) {
    var s = url
        .trim()
        .replaceFirst(_schemeRegExp, '')
        .replaceFirst(_schemeDomainExp, '');

    final i = s.indexOf('#');
    if (i != -1) s = s.substring(0, i);

    final slashIndex = s.indexOf('/');
    if (slashIndex != -1) {
      s = s.substring(0, slashIndex);
    }

    if (s.endsWith('/')) s = s.substring(0, s.length - 1);

    return s;
  }

  bool _checkPattern(String url, String link) {
    return link.startsWith('*') && url.endsWith(link.substring(1));
  }

  static Map<String, dynamic> _parse(String json) {
    return jsonDecode(json) as Map<String, dynamic>;
  }
}
