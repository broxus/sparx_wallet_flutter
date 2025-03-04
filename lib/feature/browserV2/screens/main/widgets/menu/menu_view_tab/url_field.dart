import 'package:app/feature/browserV2/models/tab/browser_tab.dart';
import 'package:app/utils/types/fuction_types.dart';
import 'package:flutter/material.dart';
import 'package:lucide_icons_flutter/lucide_icons.dart';
import 'package:ui_components_lib/v2/ui_components_lib_v2.dart';

class UrlField extends StatefulWidget {
  const UrlField({
    required this.tab,
    required this.width,
    required this.onPressedUrlMenu,
    required this.onEditingComplete,
    super.key,
  });

  final BrowserTab tab;
  final double width;
  final ValueChanged<String> onPressedUrlMenu;
  final DoubleValueCallback<String, String> onEditingComplete;

  @override
  State<UrlField> createState() => _UrlFieldState();
}

class _UrlFieldState extends State<UrlField> {
  late final _controller = TextEditingController(
    text: widget.tab.url.toString(),
  );

  @override
  void didUpdateWidget(covariant UrlField oldWidget) {
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
      width: widget.width,
      height: DimensSizeV2.d40,
      child: Padding(
        padding: const EdgeInsets.symmetric(
          horizontal: DimensSizeV2.d4,
        ),
        child: DecoratedBox(
          decoration: BoxDecoration(
            color: context.themeStyleV2.colors.backgroundInput,
            border: null,
          ),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              _Button(
                onPressed: _onPressedMenu,
                icon: LucideIcons.menu,
              ),
              Flexible(
                child: TextField(
                  controller: _controller,
                  decoration: InputDecoration(
                    border: InputBorder.none,
                    focusedBorder: InputBorder.none,
                    enabledBorder: InputBorder.none,
                    errorBorder: InputBorder.none,
                    disabledBorder: InputBorder.none,
                  ),
                  onEditingComplete: _onEditingComplete,
                ),
              ),
              _Button(
                onPressed: _onPressedMenu,
                icon: LucideIcons.rotateCcw,
              ),
            ],
          ),
        ),
      ),
    );
  }

  void _onPressedMenu() => widget.onPressedUrlMenu(widget.tab.id);

  void _onEditingComplete() => widget.onEditingComplete(
        widget.tab.id,
        _controller.text,
      );
}

class _Button extends StatelessWidget {
  const _Button({
    required this.onPressed,
    required this.icon,
  });

  final VoidCallback onPressed;
  final IconData icon;

  @override
  Widget build(BuildContext context) {
    final colors = context.themeStyleV2.colors;

    return GestureDetector(
      behavior: HitTestBehavior.opaque,
      onTap: onPressed,
      child: Padding(
        padding: const EdgeInsets.symmetric(
          horizontal: DimensSizeV2.d12,
        ),
        child: Icon(
          icon,
          color: colors.content3,
          size: DimensSizeV2.d16,
        ),
      ),
    );
  }
}
