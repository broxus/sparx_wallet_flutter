import 'package:app/generated/generated.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';

final _placeholder = Image.asset(
  Assets.images.nftPlaceholder.nftPlaceholder.path,
  fit: BoxFit.cover,
);

class NftImage extends StatelessWidget {
  const NftImage({
    required this.imageUrl,
    this.width,
    this.height,
    this.fit = BoxFit.cover,
    super.key,
  });

  final String? imageUrl;
  final double? width;
  final double? height;
  final BoxFit fit;

  @override
  Widget build(BuildContext context) {
    final url = imageUrl?.trim();

    if (url == null || url.isEmpty) {
      return _placeholder;
    }

    return CachedNetworkImage(
      imageUrl: url,
      placeholder: (_, __) => _placeholder,
      errorWidget: (_, __, ___) => _placeholder,
      fit: fit,
      width: width,
      height: height,
    );
  }
}
