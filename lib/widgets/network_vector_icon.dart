import 'package:app/generated/generated.dart';
import 'package:app/widgets/cached_svg.dart';
import 'package:flutter/material.dart';
import 'package:ui_components_lib/ui_components_lib.dart';

class NetworkVectorIcon extends StatelessWidget {
  const NetworkVectorIcon(this.url, {super.key});

  final String? url;

  @override
  Widget build(BuildContext context) {
    return url == null
        ? Assets.images.networkVectorDefault.svg(
            width: DimensSize.d40,
            height: DimensSize.d40,
          )
        : CachedSvg(url!, width: DimensSize.d40, height: DimensSize.d40);
  }
}
