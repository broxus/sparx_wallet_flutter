import 'package:app/feature/ton_connect/ton_connect.dart';

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
