import 'package:app/feature/browser_v2/widgets/favicon_view/favicon_view_wm.dart';
import 'package:app/generated/generated.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:elementary/elementary.dart';
import 'package:elementary_helper/elementary_helper.dart';
import 'package:flutter/material.dart';
import 'package:ui_components_lib/ui_components_lib.dart';

class FaviconView extends ElementaryWidget<FaviconViewWidgetModel> {
  const FaviconView({
    this.uri,
    this.height,
    this.width,
    super.key,
    WidgetModelFactory<FaviconViewWidgetModel> wmFactory =
        defaultFaviconViewWidgetModelFactory,
  }) : super(wmFactory);

  final Uri? uri;
  final double? height;
  final double? width;

  @override
  Widget build(FaviconViewWidgetModel wm) {
    return StateNotifierBuilder<String?>(
      listenableState: wm.faviconUrlState,
      builder: (_, String? url) {
        if (url == null) {
          return const CommonCircularProgressIndicator();
        }

        return CachedNetworkImage(
          height: height,
          width: width,
          imageUrl: url,
          placeholder: (_, __) => const CommonCircularProgressIndicator(),
          errorWidget: (_, __, ___) => CommonIconWidget.svg(
            svg: Assets.images.web.path,
          ),
        );
      },
    );
  }
}
