import 'package:app/feature/browser/browser.dart';
import 'package:flutter/material.dart';

class BrowserPage extends StatefulWidget {
  const BrowserPage({required this.child, super.key});

  final Widget child;

  @override
  State<BrowserPage> createState() => _BrowserPageState();
}

class _BrowserPageState extends State<BrowserPage> {
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: ApprovalsListenerWidget(
        child: BrowserView(child: widget.child),
      ),
    );
  }

// void _onBrowserHistoryItemAdd(
//   BuildContext context,
//   BrowserHistoryItem item,
// ) {
//   _browserService.hM.addHistoryItem(item);
// }

// void _onBrowserMultipleHistoryItemAdd(
//   BuildContext context,
//   List<BrowserHistoryItem> items,
// ) {
//   _browserService.hM.addHistoryItems(items);
// }
}
