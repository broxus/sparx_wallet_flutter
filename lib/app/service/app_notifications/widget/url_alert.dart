import 'package:app/generated/generated.dart';
import 'package:flutter/material.dart';

class UrlAlert extends StatelessWidget {
  const UrlAlert(this.url, {super.key});

  final String url;

  static Future<bool?> show(BuildContext context, String url) async {
    return showDialog<bool?>(
      context: context,
      barrierDismissible: false, // user must tap button!
      builder: (BuildContext context) {
        return UrlAlert(url);
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      title: Text(LocaleKeys.externalLink.tr()),
      content: SingleChildScrollView(
        child: Text(LocaleKeys.openExternalLink.tr(args: [url])),
      ),
      actions: <Widget>[
        TextButton(
          child: Text(LocaleKeys.yesWord.tr()),
          onPressed: () {
            Navigator.of(context).pop(true);
          },
        ),
        TextButton(
          child: Text(LocaleKeys.noWord.tr()),
          onPressed: () {
            Navigator.of(context).pop(false);
          },
        ),
      ],
    );
  }
}
