import 'dart:async';

import 'package:app/app/service/service.dart';
import 'package:app/feature/ton_connect/ton_connect.dart';
import 'package:app_links/app_links.dart';
import 'package:injectable/injectable.dart';
import 'package:rxdart/rxdart.dart';

@singleton
class AppLinksService {
  AppLinksService() {
    _linkSubscription = _appLinks.uriLinkStream.listen(handleAppLink);
  }

  static const _linkKey = 'link';

  final _appLinks = AppLinks();

  final _linksSubj = BehaviorSubject<AppLinksData>.seeded(EmptyAppLinksData());

  late final Stream<AppLinksData> _appLinksStream = _linksSubj.stream;

  Stream<BrowserAppLinksData> get browserLinksStream =>
      _appLinksStream.whereType<BrowserAppLinksData>();

  Stream<TonConnectAppLinksData> get tonConnecLinksData =>
      _appLinksStream.whereType<TonConnectAppLinksData>();

  StreamSubscription<Uri>? _linkSubscription;

  @disposeMethod
  void dispose() {
    _linkSubscription?.cancel();
  }

  /// Handle the initial link when app is launched from cold state
  Future<void> handleInitialLink() async {
    try {
      final uri = await _appLinks.getInitialLink();
      if (uri != null) {
        handleAppLink(uri);
      }
    } catch (_) {
      // Ignore errors getting initial link
    }
  }

  void handleAppLink(Uri uri) {
    final queryParameters = uri.queryParameters;
    final link = queryParameters[_linkKey];

    if (link != null) {
      _handleQueryLink(link);
    }

    if (uri.isScheme('tc') || uri.host == 'l.sparxwallet.com') {
      _handleTonConnectLink(uri);
    }
  }

  void _handleQueryLink(String link) {
    if (link.isEmpty) {
      return;
    }

    try {
      _linksSubj.add(BrowserAppLinksData(Uri.parse(link)));
    } catch (_) {}
  }

  void _handleTonConnectLink(Uri uri) {
    try {
      final query = ConnectQuery.fromQuery(uri.query);
      _linksSubj.add(TonConnectAppLinksData(query));
    } catch (_) {}
  }
}
