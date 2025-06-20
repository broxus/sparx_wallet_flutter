import 'package:app/feature/nft/nft.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:lucide_icons_flutter/lucide_icons.dart';
import 'package:ui_components_lib/ui_components_lib.dart';
import 'package:ui_components_lib/v2/ui_components_lib_v2.dart';

class NftItemImageView extends StatefulWidget {
  const NftItemImageView(
    this.imageUrl, {
    super.key,
  });

  static const String tag = 'nft_image';

  final String? imageUrl;

  @override
  State<NftItemImageView> createState() => _NftItemImageViewState();
}

class _NftItemImageViewState extends State<NftItemImageView> {
  @override
  void initState() {
    super.initState();

    SystemChrome.setPreferredOrientations([
      DeviceOrientation.portraitUp,
      DeviceOrientation.landscapeLeft,
      DeviceOrientation.landscapeRight,
    ]);
  }

  @override
  void dispose() {
    super.dispose();
    SystemChrome.setPreferredOrientations([
      DeviceOrientation.portraitUp,
    ]);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      extendBodyBehindAppBar: true,
      appBar: DefaultAppBar(
        backgroundColor: Colors.transparent,
        closeType: CloseType.none,
        leading: const SizedBox.shrink(),
        actions: [
          FloatButton(
            buttonShape: ButtonShape.circle,
            icon: LucideIcons.x,
            buttonSize: ButtonSize.medium,
            onPressed: () => Navigator.of(context).pop(),
          ),
        ],
      ),
      body: Center(
        child: Padding(
          padding: const EdgeInsets.all(DimensSizeV2.d16),
          child: Hero(
            tag: NftItemImageView.tag,
            child: NftImage(
              imageUrl: widget.imageUrl,
              fit: BoxFit.contain,
            ),
          ),
        ),
      ),
    );
  }
}
