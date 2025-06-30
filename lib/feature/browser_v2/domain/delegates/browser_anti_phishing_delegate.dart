import 'dart:collection';
import 'dart:convert';

import 'package:app/app/service/resources_service.dart';
import 'package:app/utils/json/json.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/services.dart';
import 'package:injectable/injectable.dart';
import 'package:logging/logging.dart';
import 'package:rxdart/rxdart.dart';

@injectable
class BrowserAntiPhishingDelegate {
  BrowserAntiPhishingDelegate(this._resourcesService);

  final _blackListSubj = BehaviorSubject<HashSet<String>>.seeded(HashSet());

  HashSet<String> get blackList => _blackListSubj.value;

  final ResourcesService _resourcesService;

  final _log = Logger('BrowserAntiPhishingManager');
  String? _htmlCache;

  Future<void> init() {
    return loadLinksJson();
  }

  void dispose() {
    _blackListSubj.close();
  }

  Future<void> loadLinksJson() async {
    try {
      final json = await _resourcesService.loadString(
        'assets/configs/anti_phishing.json',
      );

      final map = await compute<String, Map<String, dynamic>>(_parse, json);

      _blackListSubj.add(
        HashSet.from(
          castJsonList<String>(map['blacklist']),
        ),
      );
    } catch (e, s) {
      _log.severe('Load blacklist JSON error', e, s);
    }
  }

  Future<String> getPhishingGuardHtml(String path) async {
    final html = _htmlCache ??=
        await rootBundle.loadString('assets/html/anti_phishing.html');

    return html.replaceFirst('{PHISHING_ORIGINAL_SITE}', path);
  }

  static Map<String, dynamic> _parse(String json) {
    return jsonDecode(json) as Map<String, dynamic>;
  }
}
