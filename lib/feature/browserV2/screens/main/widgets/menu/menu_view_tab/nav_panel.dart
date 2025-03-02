import 'package:app/generated/generated.dart';
import 'package:flutter/material.dart';
import 'package:ui_components_lib/v2/ui_components_lib_v2.dart';


class BrowserTabViewMenuNavPanel extends StatelessWidget {
  const BrowserTabViewMenuNavPanel({
    required this.height,
    required this.onPressedBackPressed,
    required this.onPressedForwardPressed,
    required this.onPressedDotsPressed,
    required this.onPressedBook,
    required this.onPressedTabs,
    super.key,
  });

  final double height;
  final VoidCallback onPressedBackPressed;
  final VoidCallback onPressedForwardPressed;
  final VoidCallback onPressedDotsPressed;
  final VoidCallback onPressedBook;
  final VoidCallback onPressedTabs;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: height,
      child: Row(
        children: [
          Expanded(
            child: _IconButton(
              svg: Assets.images.navigateBack.path,
              onPressed: onPressedBackPressed,
            ),
          ),
          Expanded(
            child: _IconButton(
              svg: Assets.images.navigateForward.path,
              onPressed: onPressedForwardPressed,
            ),
          ),
          Expanded(
            child: _IconButton(
              svg: Assets.images.verticalDots.path,
              onPressed: onPressedDotsPressed,
            ),
          ),
          Expanded(
            child: _IconButton(
              svg: Assets.images.bookOpen.path,
              onPressed: onPressedBook,
            ),
          ),
          Expanded(
            child: _IconButton(
              svg: Assets.images.layers.path,
              onPressed: onPressedTabs,
            ),
          ),
        ],
      ),
    );
  }
}

class _IconButton extends StatelessWidget {
  const _IconButton({
    required this.svg,
    required this.onPressed,
  });

  final String svg;
  final VoidCallback? onPressed;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      behavior: HitTestBehavior.opaque,
      onTap: onPressed,
      child: Center(
        child: SvgPicture.asset(
          svg,
          width: 20,
          height: 20,
        ),
      ),
    );
  }
}
