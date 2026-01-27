import 'package:app/generated/generated.dart';
import 'package:flutter/material.dart';
import 'package:ui_components_lib/ui_components_lib.dart';

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
      backgroundColor: context.themeStyleV2.colors.background1,
      titlePadding: const EdgeInsets.only(
        top: DimensSize.d20,
        bottom: DimensSize.d16,
        left: DimensSize.d24,
        right: DimensSize.d24,
      ),
      contentPadding: const EdgeInsets.symmetric(horizontal: DimensSize.d24),
      actionsPadding: const EdgeInsets.only(
        left: DimensSize.d24,
        right: DimensSize.d24,
        bottom: DimensSize.d8,
      ),
      title: Text(LocaleKeys.externalLink.tr()),
      content: SingleChildScrollView(
        child: Text(LocaleKeys.openExternalLink.tr(args: [url])),
      ),
      actions: <Widget>[
        TextButton(
          child: Text(LocaleKeys.noWord.tr()),
          onPressed: () {
            Navigator.of(context).pop(false);
          },
        ),
        TextButton(
          child: Text(LocaleKeys.yesWord.tr()),
          onPressed: () {
            Navigator.of(context).pop(true);
          },
        ),
      ],
    );
  }
}
