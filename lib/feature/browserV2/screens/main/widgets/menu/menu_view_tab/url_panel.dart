import 'package:app/feature/browserV2/data/tabs_data.dart';
import 'package:app/feature/browserV2/models/tab/browser_tab.dart';
import 'package:app/utils/types/fuction_types.dart';
import 'package:elementary_helper/elementary_helper.dart';
import 'package:flutter/material.dart';
import 'package:ui_components_lib/ui_components_lib.dart';

class BrowserTabViewMenuUrlPanel extends StatefulWidget {
  const BrowserTabViewMenuUrlPanel({
    required this.height,
    required this.controller,
    required this.tabsState,
    required this.onEditingCompleteUrl,
    super.key,
  });

  final double height;
  final ScrollController controller;
  final ListenableState<BrowserTabsCollection> tabsState;
  final DoubleValueCallback<String, String> onEditingCompleteUrl;

  @override
  State<BrowserTabViewMenuUrlPanel> createState() =>
      _BrowserTabViewMenuUrlPanelState();
}

class _BrowserTabViewMenuUrlPanelState
    extends State<BrowserTabViewMenuUrlPanel> {
  final _physics = const PageScrollPhysics();

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: double.infinity,
      height: widget.height,
      child: StateNotifierBuilder<BrowserTabsCollection>(
        listenableState: widget.tabsState,
        builder: (_, BrowserTabsCollection? data) {
          if (data == null) {
            return const SizedBox.shrink();
          }

          return ListView.builder(
            physics: _physics,
            scrollDirection: Axis.horizontal,
            controller: widget.controller,
            itemCount: data.count,
            itemBuilder: (_, int index) {
              return Padding(
                padding: EdgeInsets.symmetric(horizontal: 8),
                child: _UrlAddressPanel(
                  key: ValueKey(data.list[index].id),
                  tab: data.list[index],
                  onEditingComplete: widget.onEditingCompleteUrl,
                ),
              );
            },
          );
        },
      ),
    );
  }
}

class _UrlAddressPanel extends StatefulWidget {
  const _UrlAddressPanel({
    required this.tab,
    required this.onEditingComplete,
    super.key,
  });

  final BrowserTab tab;
  final DoubleValueCallback<String, String> onEditingComplete;

  @override
  State<_UrlAddressPanel> createState() => _UrlAddressPanelState();
}

class _UrlAddressPanelState extends State<_UrlAddressPanel> {
  late final _controller = TextEditingController(
    text: widget.tab.url.toString(),
  );

  @override
  void didUpdateWidget(covariant _UrlAddressPanel oldWidget) {
    if (oldWidget.tab.url != widget.tab.url) {
      _controller.text = widget.tab.url.toString();
    }
    super.didUpdateWidget(oldWidget);
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: 343,
      height: DimensSizeV2.d40,
      child: DecoratedBox(
        decoration: BoxDecoration(
          color: context.themeStyleV2.colors.backgroundInput,
        ),
        child: TextField(
          controller: _controller,
          onEditingComplete: _onEditingComplete,
        ),
      ),
    );
  }

  void _onEditingComplete() => widget.onEditingComplete(
        widget.tab.id,
        _controller.text,
      );
}
