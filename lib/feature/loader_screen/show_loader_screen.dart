import 'package:app/feature/loader_screen/loader_screen.dart';
import 'package:flutter/material.dart';

Future<void> showLoaderScreen(
  BuildContext context, {
  required String title,
  bool canClose = false,
}) =>
    Navigator.of(context, rootNavigator: true).push<void>(
      MaterialPageRoute(
        builder: (_) => LoaderScreenWidget(
          title: title,
          canClose: canClose,
        ),
      ),
    );
