import 'package:app/di/di.dart';
import 'package:app/feature/browserV2/data/tabs_data.dart';
import 'package:app/feature/browserV2/service/browser_service.dart';
import 'package:app/generated/generated.dart';
import 'package:elementary_helper/elementary_helper.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:share_plus/share_plus.dart';
import 'package:ui_components_lib/ui_components_lib.dart';

class BrowserSearchBar extends StatefulWidget {
  const BrowserSearchBar({
    this.onSubmitted,
    this.onChanged,
    super.key,
  });

  final ValueChanged<String?>? onSubmitted;
  final ValueChanged<String?>? onChanged;

  static const height = DimensSize.d64;

  @override
  State<BrowserSearchBar> createState() => _BrowserSearchBarState();
}

class _BrowserSearchBarState extends State<BrowserSearchBar> {
  late final _browserService = inject<BrowserService>();

  @override
  Widget build(BuildContext context) {
    return StateNotifierBuilder<BrowserTabsData>(
      listenableState: _browserService.tM.tabsState,
      builder: (_, BrowserTabsData? data) {
        return BrowserSearchBarInput(
          uri: data?.activeTab?.url,
          hintText: LocaleKeys.browserSearchURL.tr(),
          cancelText: LocaleKeys.browserSearchURLCancel.tr(),
          onSubmitted: widget.onSubmitted,
          onChanged: widget.onChanged,
          onShared: _onShared,
          searchSvg: Assets.images.search.path,
          secureSvg: Assets.images.lock.path,
          shareSvg: Assets.images.export2.path,
        );
      },
    );
  }

  void _onShared(Uri? url) {
    final shareText = url?.toString();
    if (shareText != null) {
      Share.share(shareText);
    }
  }
}
