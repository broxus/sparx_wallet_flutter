import 'package:app/app/service/service.dart';

sealed class AppLinksData {}

class EmptyAppLinksData extends AppLinksData {}

class BrowserAppLinksData extends AppLinksData {
  BrowserAppLinksData(this.url);

  final Uri url;
}

class TonConnectAppLinksData extends AppLinksData {
  TonConnectAppLinksData(this.query);

  final ConnectQuery query;
}
