import 'package:app/app/router/app_route.dart';
import 'package:app/di/di.dart';
import 'package:app/feature/browser/browser.dart';
import 'package:app/feature/browser/primary/primary_view.dart';
import 'package:app/feature/browserV2/service/browser_service.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

// TODO(knightforce): refactor
class PrimaryPage extends StatefulWidget {
  const PrimaryPage({this.url, this.tabId, super.key});

  final String? url;
  final String? tabId;

  @override
  State<PrimaryPage> createState() => _PrimaryPageState();
}

class _PrimaryPageState extends State<PrimaryPage> {
  final _browserService = inject<BrowserService>();

  @override
  void didUpdateWidget(covariant PrimaryPage oldWidget) {
    super.didUpdateWidget(oldWidget);

    _handleWidgetUpdate(oldWidget);
  }

  @override
  Widget build(BuildContext context) {
    return BlocProvider<HudBloc>(
      create: (context) => HudBloc(),
      child: const PrimaryView(),
    );
  }

  void _handleWidgetUpdate(PrimaryPage oldWidget) {
    // We don't want to store url, tab id or anything else in the route location
    // because it's complicated to handle it in the browser tabs bloc: we will
    // have two sources of truth: route location and browser tabs bloc state.
    // So, just change bloc state, clear route location and let the browser tabs
    // bloc handle the rest. It is perfectly fine until we don't need to build
    // web version of the app.

    // Change url of the active tab.
    if (widget.tabId != null && widget.url != null) {
      _browserService.tM.setActiveTab(widget.tabId);
      _clearQueryParams();

      return;
    }

    // Change active tab id.
    if (widget.tabId != oldWidget.tabId && widget.tabId != null) {
      _browserService.tM.setActiveTab(widget.tabId);
      _clearQueryParams();

      return;
    }

    // Create new tab.
    if (widget.url != null &&
        widget.url != oldWidget.url &&
        widget.tabId == null) {
      _browserService.tM.createBrowserTab(Uri.parse(widget.url!));
      _clearQueryParams();

      return;
    }
  }

  void _clearQueryParams() {
    WidgetsBinding.instance.addPostFrameCallback((_) {
      context.clearQueryParams();
    });
  }
}
