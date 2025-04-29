import 'package:flutter/material.dart';
import 'package:ui_components_lib/v2/ui_components_lib_v2.dart';

class CustomOverlay {
  static OverlayEntry? _overlayEntry;

  static void showOverlay(
    BuildContext context,
    List<GlobalKey> keys,
  ) {
    if (_overlayEntry != null) return;

    final positions = <Offset>[];
    final sizes = <Size>[];

    for (final key in keys) {
      if (key.currentContext?.findRenderObject() is! RenderBox) return;
      final renderBox = key.currentContext!.findRenderObject()! as RenderBox;
      positions.add(renderBox.localToGlobal(Offset.zero));
      sizes.add(renderBox.size);
    }

    _overlayEntry = OverlayEntry(
      builder: (context) => Stack(
        children: [
          Positioned.fill(
            child: GestureDetector(
              onTap: removeOverlay,
              child: ClipPath(
                clipper: HoleClipper(positions, sizes),
                child: Container(
                  color: context.themeStyleV2.colors.background0.withOpacity(
                    OpacV2.opac90,
                  ),
                ),
              ),
            ),
          ),
        ],
      ),
    );

    Overlay.of(context).insert(_overlayEntry!);
  }

  static void removeOverlay() {
    _overlayEntry?.remove();
    _overlayEntry = null;
  }
}

class HoleClipper extends CustomClipper<Path> {
  HoleClipper(this.positions, this.sizes);

  final List<Offset> positions;
  final List<Size> sizes;

  @override
  Path getClip(Size size) {
    final path = Path()
      ..addRect(
        Rect.fromLTWH(
          0,
          0,
          size.width,
          size.height,
        ),
      );

    for (var i = 0; i < positions.length; i++) {
      path.addRect(
        Rect.fromLTWH(
          positions[i].dx,
          positions[i].dy,
          sizes[i].width,
          sizes[i].height,
        ),
      );
    }

    return path..fillType = PathFillType.evenOdd;
  }

  @override
  bool shouldReclip(covariant CustomClipper<Path> oldClipper) => true;
}
