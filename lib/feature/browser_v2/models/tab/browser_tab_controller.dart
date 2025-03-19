// import 'package:elementary_helper/elementary_helper.dart';
// import 'package:flutter_inappwebview/flutter_inappwebview.dart';
//
// class BrowserTabController {
//   BrowserTabController(this._webViewController);
//
//   final InAppWebViewController _webViewController;
//
//   final _navigationState = StateNotifier<BrowserNavigation>(
//     initValue: BrowserNavigation(),
//   );
//
//   Future<void> shake() async {
//     _navigationState.accept(
//       BrowserNavigation(
//         isCanGoBack: await _webViewController.canGoBack(),
//         isCanGoForward: await _webViewController.canGoForward(),
//       ),
//     );
//   }
// }
//
// class BrowserNavigation {
//   BrowserNavigation({
//     bool? isCanGoBack,
//     bool? isCanGoForward,
//   })  : isCanGoBack = isCanGoBack ?? false,
//         isCanGoForward = isCanGoForward ?? false;
//
//   final bool isCanGoBack;
//   final bool isCanGoForward;
// }
