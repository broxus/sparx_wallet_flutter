import 'dart:async';

import 'package:app/app/service/app_links/app_links_data.dart';
import 'package:app_links/app_links.dart';
import 'package:injectable/injectable.dart';
import 'package:rxdart/rxdart.dart';

@singleton
class AppLinksService {
  AppLinksService() {
    _linkSubscription = _appLinks.uriLinkStream.listen(_handleAppLink);
  }

  static const _linkKey = 'link';

  final _appLinks = AppLinks();

  final _linksSubj = BehaviorSubject<AppLinksData>.seeded(EmptyAppLinksData());

  final _uriLinkSubject = BehaviorSubject<Uri?>.seeded(null);

  late final Stream<Uri> uriLinkStream = _uriLinkSubject.stream.whereNotNull();

  late final Stream<AppLinksData> appLinksStream = _linksSubj.stream;

  Stream<BrowserAppLinksData> get browserLinksStream => appLinksStream
      .where((data) => data is BrowserAppLinksData)
      .cast<BrowserAppLinksData>();

  StreamSubscription<Uri>? _linkSubscription;

  @disposeMethod
  void dispose() {
    _linkSubscription?.cancel();
  }

  void _handleAppLink(Uri uri) {
    final queryParameters = uri.queryParameters;
    final link = queryParameters[_linkKey];

    if (link != null) {
      _handleQueryLink(link);
    }

    _uriLinkSubject.add(uri);
  }

  void _handleQueryLink(String link) {
    if (link.isEmpty) {
      return;
    }

    try {
      _linksSubj.add(
        BrowserAppLinksData(
          Uri.parse(link),
        ),
      );
    } catch (_) {}
  }
}
