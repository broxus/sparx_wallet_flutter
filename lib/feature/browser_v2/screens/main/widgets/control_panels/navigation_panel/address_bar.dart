import 'package:app/core/wm/not_null_listenable_state.dart';
import 'package:app/core/wm/not_null_safe_notifier.dart';
import 'package:app/feature/browser_v2/data/tabs/browser_tab.dart';
import 'package:app/feature/browser_v2/widgets/tips_bar/tips_bar.dart';
import 'package:app/generated/generated.dart';
import 'package:app/utils/focus_utils.dart';
import 'package:app/utils/types/fuction_types.dart';
import 'package:elementary_helper/elementary_helper.dart';
import 'package:flutter/material.dart';
import 'package:lucide_icons_flutter/lucide_icons.dart';
import 'package:ui_components_lib/ui_components_lib.dart';

class BrowserAddressBar extends StatefulWidget {
  const BrowserAddressBar({
    required this.listenable,
    required this.width,
    required this.onPressedCurrentUrlMenu,
    required this.onPressedRefresh,
    required this.onEditingComplete,
    super.key,
  });

  final NotNullListenableState<BrowserTab> listenable;
  final double width;
  final ValueChanged<String> onPressedCurrentUrlMenu;
  final ValueChanged<String> onPressedRefresh;
  final DoubleValueCallback<String, String> onEditingComplete;

  @override
  State<BrowserAddressBar> createState() => _BrowserAddressBarState();
}

class _BrowserAddressBarState extends State<BrowserAddressBar> {
  late final _controller = TextEditingController(text: _url.toString());
  late final _textNotifier = NotNullNotifier<String>(_controller.text);
  final _focusNode = FocusNode();
  final _link = LayerLink();

  late final _urlVisibleTextState = StateNotifier<bool>(initValue: true);
  late final _closeVisibleState = StateNotifier<bool>(
    initValue: _controller.text.isNotEmpty,
  );

  late final _listenable = widget.listenable;
  final _tipsOverlayController = OverlayPortalController();

  BrowserTab get _tab => _listenable.value;

  Uri get _url => _tab.url;

  bool get _isVisibleAddress => !(_urlVisibleTextState.value ?? false);

  @override
  void initState() {
    _focusNode.addListener(_onFocusChange);
    _controller.addListener(_onChangeText);
    _listenable.addListener(_handleTab);
    _urlVisibleTextState.addListener(_handleVisibleText);
    super.initState();
  }

  @override
  void dispose() {
    _controller.dispose();
    _focusNode.dispose();
    _textNotifier.dispose();
    _urlVisibleTextState.dispose();
    _closeVisibleState.dispose();
    _listenable.removeListener(_handleTab);
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: _onPressedBackground,
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
              borderRadius: BorderRadius.circular(DimensRadiusV2.radius12),
            ),
            child: CompositedTransformTarget(
              link: _link,
              child: OverlayPortal(
                controller: _tipsOverlayController,
                overlayChildBuilder: (_) => CompositedTransformFollower(
                  targetAnchor: Alignment.topCenter,
                  followerAnchor: Alignment.bottomCenter,
                  link: _link,
                  child: TipsBar(
                    textNotifier: _textNotifier,
                    onPressedItem: _onPressedTip,
                  ),
                ),
                child: Stack(
                  children: [
                    StateNotifierBuilder<bool>(
                      listenableState: _urlVisibleTextState,
                      builder: (_, bool? isVisibleText) {
                        return Visibility(
                          visible: isVisibleText ?? false,
                          child: _UrlText(
                            listenable: _listenable,
                            onPressedMenu: _onPressedMenu,
                            onPressedText: _onPressedText,
                            onPressedRefresh: _onPressedRefresh,
                          ),
                        );
                      },
                    ),
                    StateNotifierBuilder<bool>(
                      listenableState: _urlVisibleTextState,
                      builder: (_, bool? isVisibleText) {
                        return Visibility(
                          visible: !(isVisibleText ?? false),
                          child: _UrlTextField(
                            controller: _controller,
                            focusNode: _focusNode,
                            closeVisibleState: _closeVisibleState,
                            onPressedClear: _onPressedClear,
                            onEditingComplete: _onEditingComplete,
                          ),
                        );
                      },
                    ),
                  ],
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }

  void _onPressedBackground() => _textNotifier.accept('');

  void _onPressedMenu() => widget.onPressedCurrentUrlMenu(_tab.id);

  void _onPressedRefresh() => widget.onPressedRefresh(_tab.id);

  void _onEditingComplete() {
    resetFocus(context);
    widget.onEditingComplete(
      _tab.id,
      _controller.text,
    );
  }

  void _onPressedTip() {
    _urlVisibleTextState.accept(true);
    resetFocus();
  }

  void _onPressedClear() {
    _controller.clear();
  }

  void _onPressedText() {
    _urlVisibleTextState.accept(false);
    Future(_focusNode.requestFocus);
  }

  void _onFocusChange() {
    if (_focusNode.hasFocus) {
      return;
    }
    _urlVisibleTextState.accept(true);
  }

  void _onChangeText() {
    _textNotifier.accept(_controller.text);
    _closeVisibleState.accept(_controller.text.isNotEmpty);
  }

  void _handleVisibleText() {
    _toggleTips(_isVisibleAddress);
  }

  void _toggleTips(bool isShow) {
    Future(() {
      if (isShow && !_tipsOverlayController.isShowing) {
        _tipsOverlayController.show();
      } else if (!isShow && _tipsOverlayController.isShowing) {
        _tipsOverlayController.hide();
      }
    });
  }

  void _handleTab() {
    final urlText = _url.toString();
    if (_controller.text == urlText) {
      return;
    } else if (urlText == 'about:blank') {
      _controller.text = '';
      return;
    }
    _controller.text = urlText;
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
    required this.closeVisibleState,
    required this.onPressedClear,
    required this.onEditingComplete,
  });

  final TextEditingController controller;
  final FocusNode focusNode;
  final ListenableState<bool> closeVisibleState;
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
            autocorrect: false,
            enableSuggestions: false,
            style: theme.textStyles.paragraphXMedium.copyWith(
              color: ColorsResV2.black,
            ),
            cursorColor: ColorsResV2.black,
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
        StateNotifierBuilder(
          listenableState: closeVisibleState,
          builder: (_, bool? isVisible) {
            isVisible ??= true;
            return AnimatedOpacity(
              opacity: isVisible ? 1 : 0,
              duration: const Duration(milliseconds: 250),
              child: IgnorePointer(
                ignoring: !isVisible,
                child: GestureDetector(
                  behavior: HitTestBehavior.opaque,
                  onTap: onPressedClear,
                  child: Padding(
                    padding: const EdgeInsets.only(right: DimensSizeV2.d12),
                    child: Assets.images.clear.svg(
                      width: DimensSizeV2.d20,
                      height: DimensSizeV2.d20,
                      colorFilter:
                          context.themeStyleV2.colors.content3.colorFilter,
                    ),
                  ),
                ),
              ),
            );
          },
        ),
      ],
    );
  }
}

class _UrlText extends StatelessWidget {
  const _UrlText({
    required this.listenable,
    required this.onPressedMenu,
    required this.onPressedText,
    required this.onPressedRefresh,
  });

  final NotNullListenableState<BrowserTab> listenable;
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
        StateNotifierBuilder(
          listenableState: listenable,
          builder: (_, BrowserTab? tab) {
            if (tab?.url.host.isEmpty ?? true) {
              return const SizedBox.shrink();
            }

            return _Button(
              onPressed: onPressedMenu,
              icon: LucideIcons.menu,
            );
          },
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
                  child: StateNotifierBuilder(
                    listenableState: listenable,
                    builder: (_, BrowserTab? tab) {
                      return tab?.url.host.isEmpty ?? true
                          ? Icon(
                              LucideIcons.search,
                              size: DimensSizeV2.d16,
                              color: theme.colors.content3,
                            )
                          : Assets.images.lockFill.svg(
                              width: DimensSizeV2.d16,
                              height: DimensSizeV2.d16,
                              colorFilter: context
                                  .themeStyleV2.colors.content3.colorFilter,
                            );
                    },
                  ),
                ),
                Flexible(
                  child: StateNotifierBuilder(
                    listenableState: listenable,
                    builder: (_, BrowserTab? tab) {
                      return Text(
                        tab?.url.host.isEmpty ?? true
                            ? LocaleKeys.browserSearchURL.tr()
                            : tab!.url.host,
                        style: theme.textStyles.labelMedium.copyWith(
                          color: theme.colors.content3,
                        ),
                        overflow: TextOverflow.ellipsis,
                      );
                    },
                  ),
                ),
              ],
            ),
          ),
        ),
        StateNotifierBuilder(
          listenableState: listenable,
          builder: (_, BrowserTab? tab) {
            if (tab?.url.host.isEmpty ?? true) {
              return const SizedBox.shrink();
            }

            return _Button(
              onPressed: onPressedRefresh,
              icon: LucideIcons.rotateCcw,
            );
          },
        ),
      ],
    );
  }
}
