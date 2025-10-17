import 'package:app/feature/loader_screen/loader_screen.dart';
import 'package:flutter/material.dart';

/// Displays a loader screen overlay and returns a callback to dismiss it.
///
/// The returned [VoidCallback] should be called when the loading process
/// is complete to remove the loader from the screen.
///
/// Example:
/// ```dart
/// final hideLoader = showLoaderScreen();
/// // Do some async work
/// hideLoader(); // Dismiss the loader when done
/// ```
///
VoidCallback showLoaderScreen(
  BuildContext context, {
  required String title,
  bool canClose = false,
}) {
  final navigator = Navigator.of(context, rootNavigator: true);
  var isClosed = false;

  navigator
      .push<void>(
        MaterialPageRoute(
          builder: (_) => LoaderScreenWidget(title: title, canClose: canClose),
        ),
      )
      .then((_) => isClosed = true);

  return () {
    if (!isClosed && navigator.canPop()) {
      navigator.pop();
    }
  };
}
