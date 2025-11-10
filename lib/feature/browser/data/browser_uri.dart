import 'package:flutter_inappwebview/flutter_inappwebview.dart';

class BrowserUri extends WebUri {
  BrowserUri(
    super.source, {
    super.forceToStringRawValue,
    this.isInternalAppUri = false,
  });

  // ignore: use_super_parameters
  BrowserUri.uri(Uri uri, {this.isInternalAppUri = false}) : super.uri(uri);

  final bool isInternalAppUri;

  late final String url = toString();
}
