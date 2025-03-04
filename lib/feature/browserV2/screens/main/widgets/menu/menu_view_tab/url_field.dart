import 'package:app/feature/browserV2/models/tab/browser_tab.dart';
import 'package:app/generated/generated.dart';
import 'package:app/utils/focus_utils.dart';
import 'package:app/utils/types/fuction_types.dart';
import 'package:elementary_helper/elementary_helper.dart';
import 'package:flutter/material.dart';
import 'package:lucide_icons_flutter/lucide_icons.dart';
import 'package:ui_components_lib/ui_components_lib.dart';

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
  final _controller = TextEditingController();
  final _focusNode = FocusNode();

  late final _urlTextState = StateNotifier<String?>(initValue: _host);

  String get _host => widget.tab.url.host;

  bool get _isVisibleText => _urlTextState.value != null;

  @override
  void didUpdateWidget(covariant UrlField oldWidget) {
    if (oldWidget.tab.url != widget.tab.url) {
      if (_isVisibleText) {
        _urlTextState.accept(widget.tab.url.host);
      }
      final str = widget.tab.url.toString();
      if (_controller.text != str) {
        _controller.text = str;
      }
    }
    super.didUpdateWidget(oldWidget);
  }

  @override
  void dispose() {
    _controller.dispose();
    _focusNode.dispose();
    _urlTextState.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return PopCapture(
      onPop: _onPop,
      child: SizedBox(
        width: widget.width,
        height: DimensSizeV2.d40,
        child: Padding(
          padding: const EdgeInsets.symmetric(
            horizontal: DimensSizeV2.d4,
          ),
          child: DecoratedBox(
            decoration: BoxDecoration(
                color: context.themeStyleV2.colors.backgroundInput,
                borderRadius: BorderRadius.circular(DimensRadiusV2.radius12)),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                _Button(
                  onPressed: _onPressedMenu,
                  icon: LucideIcons.menu,
                ),
                Flexible(
                  child: Listener(
                    behavior: HitTestBehavior.translucent,
                    onPointerDown: _onPointerDown,
                    child: StateNotifierBuilder<String?>(
                      listenableState: _urlTextState,
                      builder: (_, String? text) {
                        return text == null
                            ? _UrlTextField(
                                controller: _controller,
                                focusNode: _focusNode,
                                onEditingComplete: _onEditingComplete,
                              )
                            : _UrlText(_host);
                      },
                    ),
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
      ),
    );
  }

  void _onPressedMenu() => widget.onPressedUrlMenu(widget.tab.id);

  void _onEditingComplete() {
    resetFocus(context);
    _urlTextState.accept(_host);
    widget.onEditingComplete(
      widget.tab.id,
      _controller.text,
    );
  }

  void _onPointerDown(_) {
    _urlTextState.accept(null);
    Future(_focusNode.requestFocus);
  }

  void _onPop() {
    resetFocus(context);
    _urlTextState.accept(_host);
  }
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

class _UrlTextField extends StatelessWidget {
  const _UrlTextField({
    required this.controller,
    required this.focusNode,
    required this.onEditingComplete,
  });

  final TextEditingController controller;
  final FocusNode focusNode;
  final VoidCallback onEditingComplete;

  @override
  Widget build(BuildContext context) {
    final theme = context.themeStyleV2;

    return TextField(
      controller: controller,
      focusNode: focusNode,
      style: TextStyle(
        color: theme.colors.content3,
      ),
      textAlign: TextAlign.center,
      decoration: InputDecoration(
        border: InputBorder.none,
        focusedBorder: InputBorder.none,
        enabledBorder: InputBorder.none,
        errorBorder: InputBorder.none,
        disabledBorder: InputBorder.none,
      ),
      onEditingComplete: onEditingComplete,
    );
  }
}

class _UrlText extends StatelessWidget {
  const _UrlText(
    this.text,
  );

  final String text;

  @override
  Widget build(BuildContext context) {
    final theme = context.themeStyleV2;
    return Row(
      mainAxisSize: MainAxisSize.min,
      children: [
        Padding(
          padding: const EdgeInsets.only(right: DimensSizeV2.d4),
          child: Icon(
            text.isEmpty ? LucideIcons.search : LucideIcons.lock,
            size: DimensSizeV2.d16,
            color: theme.colors.content3,
          ),
        ),
        Text(
          text.isEmpty ? LocaleKeys.browserSearchURL.tr() : text,
          style: theme.textStyles.labelMedium.copyWith(
            color: theme.colors.content3,
          ),
        ),
      ],
    );
  }
}
