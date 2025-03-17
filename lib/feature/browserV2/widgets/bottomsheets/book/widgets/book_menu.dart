import 'package:app/feature/browserV2/widgets/bottomsheets/book/widgets/bookmarks/bookmarks_list_wm.dart';
import 'package:app/generated/generated.dart';
import 'package:elementary_helper/elementary_helper.dart';
import 'package:flutter/material.dart';
import 'package:ui_components_lib/v2/ui_components_lib_v2.dart';

class BrowserBookmarksMenu extends StatelessWidget {
  const BrowserBookmarksMenu({
    required this.editState,
    required this.activeState,
    required this.onPressedEdit,
    required this.onPressedDone,
    super.key,
  });

  final ListenableState<EditValue> editState;
  final ListenableState<bool> activeState;

  final VoidCallback onPressedEdit;
  final VoidCallback onPressedDone;

  static const height = _Container._height;

  @override
  Widget build(BuildContext context) {
    return _Container(
      child: Align(
        alignment: Alignment.topRight,
        child: StateNotifierBuilder(
          listenableState: editState,
          builder: (_, EditValue? editValue) {
            return AnimatedCrossFade(
              firstChild: _DoneButton(
                onPressed: onPressedDone,
              ),
              secondChild: StateNotifierBuilder(
                listenableState: activeState,
                builder: (_, bool? isActive) {
                  return _EditButton(
                    onPressed: isActive ?? false ? onPressedEdit : null,
                  );
                },
              ),
              crossFadeState: editValue != EditValue.none
                  ? CrossFadeState.showFirst
                  : CrossFadeState.showSecond,
              duration: const Duration(milliseconds: 250),
            );
          },
        ),
      ),
    );
  }
}

class HistoryBookmarksMenu extends StatelessWidget {
  const HistoryBookmarksMenu({
    required this.editState,
    required this.activeState,
    required this.onPressedEdit,
    required this.onPressedDone,
    required this.onPressedClear,
    super.key,
  });

  final ListenableState<bool> editState;
  final ListenableState<bool> activeState;

  final VoidCallback onPressedEdit;
  final VoidCallback onPressedDone;
  final VoidCallback onPressedClear;

  static const height = _Container._height;

  @override
  Widget build(BuildContext context) {
    return _Container(
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          StateNotifierBuilder(
            listenableState: activeState,
            builder: (_, bool? isActive) {
              return _ClearButton(
                onPressed: isActive ?? false ? onPressedClear : null,
              );
            },
          ),
          StateNotifierBuilder(
            listenableState: editState,
            builder: (_, bool? isEdited) {
              isEdited ??= false;

              return AnimatedCrossFade(
                firstChild: _DoneButton(
                  onPressed: onPressedDone,
                ),
                secondChild: StateNotifierBuilder(
                  listenableState: activeState,
                  builder: (_, bool? isActive) {
                    return _EditButton(
                      onPressed: isActive ?? false ? onPressedEdit : null,
                    );
                  },
                ),
                crossFadeState: isEdited
                    ? CrossFadeState.showFirst
                    : CrossFadeState.showSecond,
                duration: const Duration(milliseconds: 250),
              );
            },
          ),
        ],
      ),
    );
  }
}

class _Container extends StatelessWidget {
  const _Container({
    required this.child,
  });

  final Widget child;

  static const _height = DimensSizeV2.d70;

  @override
  Widget build(BuildContext context) {
    final colors = context.themeStyleV2.colors;

    return SizedBox(
      width: double.infinity,
      height: _height,
      child: DecoratedBox(
        decoration: BoxDecoration(
          color: colors.background1,
          border: Border(
            top: BorderSide(
              color: colors.primaryA.withOpacity(.1),
            ),
          ),
        ),
        child: child,
      ),
    );
  }
}

class _EditButton extends StatelessWidget {
  const _EditButton({
    this.onPressed,
  });

  final VoidCallback? onPressed;

  @override
  Widget build(BuildContext context) {
    final theme = context.themeStyleV2;
    return _ActionButton(
      text: LocaleKeys.edit.tr(),
      textStyle: theme.textStyles.labelSmall.copyWith(
        color: theme.colors.content2,
      ),
      onPressed: onPressed,
    );
  }
}

class _DoneButton extends StatelessWidget {
  const _DoneButton({
    required this.onPressed,
  });

  final VoidCallback onPressed;

  @override
  Widget build(BuildContext context) {
    final theme = context.themeStyleV2;
    return _ActionButton(
      text: LocaleKeys.done.tr(),
      textStyle: theme.textStyles.labelSmall.copyWith(
        color: theme.colors.content2,
      ),
      onPressed: onPressed,
    );
  }
}

class _ClearButton extends StatelessWidget {
  const _ClearButton({
    this.onPressed,
  });

  final VoidCallback? onPressed;

  @override
  Widget build(BuildContext context) {
    final theme = context.themeStyleV2;
    return _ActionButton(
      text: LocaleKeys.clearWord.tr(),
      textStyle: theme.textStyles.labelSmall.copyWith(
        // TODO(knightforce): move to colors
        color: const Color(0xFFFF395F),
      ),
      onPressed: onPressed,
    );
  }
}

class _ActionButton extends StatelessWidget {
  const _ActionButton({
    required this.text,
    required this.textStyle,
    this.onPressed,
  });

  final String text;
  final TextStyle textStyle;
  final VoidCallback? onPressed;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      behavior: HitTestBehavior.opaque,
      onTap: onPressed,
      child: Opacity(
        opacity: onPressed == null ? .4 : 1,
        child: SizedBox(
          width: DimensSizeV2.d84,
          child: Padding(
            padding: const EdgeInsets.symmetric(
              vertical: DimensSizeV2.d14,
            ),
            child: Align(
              alignment: Alignment.topCenter,
              child: Text(
                text,
                style: textStyle,
              ),
            ),
          ),
        ),
      ),
    );
  }
}
