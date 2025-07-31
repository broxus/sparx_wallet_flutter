import 'package:app/core/wm/custom_wm.dart';
import 'package:app/feature/browser_v2/widgets/favicon_view/favicon_view_wm.dart';
import 'package:app/generated/generated.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:elementary_helper/elementary_helper.dart';
import 'package:flutter/material.dart';
import 'package:ui_components_lib/ui_components_lib.dart';

class FaviconView
    extends InjectedElementaryParametrizedWidget<FaviconViewWidgetModel, Uri?> {
  const FaviconView({
    Uri? uri,
    this.height,
    this.width,
    super.key,
  }) : super(
          wmFactoryParam: uri,
        );

  final double? height;
  final double? width;

  @override
  Widget build(FaviconViewWidgetModel wm) {
    return EntityStateNotifierBuilder<String?>(
      listenableEntityState: wm.faviconUrlState,
      loadingBuilder: (_, __) => const CommonCircularProgressIndicator(),
      errorBuilder: (_, __, ___) => const _Stub(),
      builder: (_, String? url) {
        if (url == null) {
          return const _Stub();
        }

        return CachedNetworkImage(
          height: height,
          width: width,
          imageUrl: url,
          placeholder: (_, __) => const CommonCircularProgressIndicator(),
          errorWidget: (_, __, ___) => const _Stub(),
        );
      },
    );
  }
}

class _Stub extends StatelessWidget {
  const _Stub();

  @override
  Widget build(BuildContext context) {
    return CommonIconWidget.svg(
      svg: Assets.images.web.path,
    );
  }
}
