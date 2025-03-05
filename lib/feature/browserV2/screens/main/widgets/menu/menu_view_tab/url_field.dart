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
    required this.onPressedRefresh,
    required this.onEditingComplete,
    super.key,
  });

  final BrowserTab tab;
  final double width;
  final ValueChanged<String> onPressedUrlMenu;
  final ValueChanged<String> onPressedRefresh;
  final DoubleValueCallback<String, String> onEditingComplete;

  @override
  State<UrlField> createState() => _UrlFieldState();
}

class _UrlFieldState extends State<UrlField> {
  late final _controller = TextEditingController(text: _urlText);
  final _focusNode = FocusNode();

  late final _urlTextState = StateNotifier<String?>(initValue: _host);

  BrowserTab get _tab => widget.tab;

  Uri get _url => _tab.url;

  String get _urlText => _url.toString();

  String get _host => _tab.url.host;

  bool get _isVisibleText => _urlTextState.value != null;

  @override
  void didUpdateWidget(covariant UrlField oldWidget) {
    if (oldWidget.tab.url != _url) {
      if (_isVisibleText) {
        _urlTextState.accept(_host);
      }
      final str = _urlText;
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
            child: StateNotifierBuilder<String?>(
              listenableState: _urlTextState,
              builder: (_, String? host) {
                return host != null
                    ? _UrlText(
                        text: _host,
                        onPressedMenu: _onPressedMenu,
                        onPressedText: _onPressedText,
                        onPressedRefresh: _onPressedRefresh,
                      )
                    : _UrlTextField(
                        controller: _controller,
                        focusNode: _focusNode,
                        onPressedClear: _onPressedClear,
                        onEditingComplete: _onEditingComplete,
                      );
              },
            ),
          ),
        ),
      ),
    );
  }

  void _onPressedMenu() => widget.onPressedUrlMenu(widget.tab.id);

  void _onPressedRefresh() => widget.onPressedRefresh(widget.tab.id);

  void _onEditingComplete() {
    resetFocus(context);
    _urlTextState.accept(_host);
    widget.onEditingComplete(
      widget.tab.id,
      _controller.text,
    );
  }

  void _onPressedClear() {
    _controller.clear();
  }

  void _onPressedText() {
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
    required this.onPressedClear,
    required this.onEditingComplete,
  });

  final TextEditingController controller;
  final FocusNode focusNode;
  final VoidCallback onPressedClear;
  final VoidCallback onEditingComplete;

  @override
  Widget build(BuildContext context) {
    final theme = context.themeStyleV2;

    return Row(
      children: [
        Expanded(
          child: TextField(
            controller: controller,
            focusNode: focusNode,
            style: TextStyle(
              color: theme.colors.content3,
            ),
            decoration: const InputDecoration(
              border: InputBorder.none,
              focusedBorder: InputBorder.none,
              enabledBorder: InputBorder.none,
              errorBorder: InputBorder.none,
              disabledBorder: InputBorder.none,
              contentPadding: EdgeInsets.symmetric(
                horizontal: DimensSizeV2.d14,
              ),
            ),
            onEditingComplete: onEditingComplete,
          ),
        ),
        GestureDetector(
          behavior: HitTestBehavior.opaque,
          onTap: onPressedClear,
          child: Padding(
            padding: const EdgeInsets.only(right: DimensSizeV2.d12),
            child: Assets.images.clear.svg(
              width: DimensSizeV2.d20,
              height: DimensSizeV2.d20,
              colorFilter: context.themeStyleV2.colors.content3.colorFilter,
            ),
          ),
        ),
      ],
    );
  }
}

class _UrlText extends StatelessWidget {
  const _UrlText({
    required this.text,
    required this.onPressedMenu,
    required this.onPressedText,
    required this.onPressedRefresh,
  });

  final String text;
  final VoidCallback onPressedMenu;
  final VoidCallback onPressedText;
  final VoidCallback onPressedRefresh;

  @override
  Widget build(BuildContext context) {
    final theme = context.themeStyleV2;
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        _Button(
          onPressed: onPressedMenu,
          icon: LucideIcons.menu,
        ),
        Expanded(
          child: GestureDetector(
            behavior: HitTestBehavior.opaque,
            onTap: onPressedText,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Padding(
                  padding: const EdgeInsets.only(right: DimensSizeV2.d4),
                  child: text.isEmpty
                      ? Icon(
                          LucideIcons.search,
                          size: DimensSizeV2.d16,
                          color: theme.colors.content3,
                        )
                      : Assets.images.lockFill.svg(
                          width: DimensSizeV2.d16,
                          height: DimensSizeV2.d16,
                          colorFilter:
                              context.themeStyleV2.colors.content3.colorFilter,
                        ),
                ),
                Text(
                  text.isEmpty ? LocaleKeys.browserSearchURL.tr() : text,
                  style: theme.textStyles.labelMedium.copyWith(
                    color: theme.colors.content3,
                  ),
                  overflow: TextOverflow.ellipsis,
                ),
              ],
            ),
          ),
        ),
        _Button(
          onPressed: onPressedRefresh,
          icon: LucideIcons.rotateCcw,
        ),
      ],
    );
  }
}
