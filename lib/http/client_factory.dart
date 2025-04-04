import 'dart:io';

import 'package:cupertino_http/cupertino_http.dart';
import 'package:http/http.dart' as http;

final class ClientFactory {
  ClientFactory._();

  static http.Client create() => Platform.isIOS
      ? CupertinoClient.defaultSessionConfiguration()
      : http.Client();
}
