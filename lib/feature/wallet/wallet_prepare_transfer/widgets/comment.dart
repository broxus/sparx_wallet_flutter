import 'package:app/generated/generated.dart';
import 'package:elementary_helper/elementary_helper.dart';
import 'package:flutter/material.dart';
import 'package:lucide_icons_flutter/lucide_icons.dart';
import 'package:ui_components_lib/ui_components_lib.dart';

class WalletPrepareTransferComment extends StatelessWidget {
  const WalletPrepareTransferComment({
    required this.commentState,
    required this.textEditingController,
    required this.focusNode,
    required this.onPressedNext,
    required this.onPressedCleanComment,
    super.key,
  });

  final StateNotifier<bool> commentState;
  final TextEditingController textEditingController;
  final FocusNode focusNode;
  final VoidCallback onPressedNext;
  final VoidCallback onPressedCleanComment;

  @override
  Widget build(BuildContext context) {
    return StateNotifierBuilder(
      listenableState: commentState,
      builder: (context, value) => value ?? false
          ? SeparatedColumn(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                PrimaryTextField(
                  hintText: LocaleKeys.commentWord.tr(),
                  textEditingController: textEditingController,
                  focusNode: focusNode,
                  onSubmit: (_) => onPressedNext(),
                  suffixes: [
                    ValueListenableBuilder(
                      valueListenable: textEditingController,
                      builder: (_, value, __) {
                        if (value.text.isEmpty) {
                          return const SizedBox.shrink();
                        }

                        return Padding(
                          padding: const EdgeInsets.only(right: DimensSize.d8),
                          child: FloatButton(
                            buttonShape: ButtonShape.square,
                            buttonSize: ButtonSize.small,
                            icon: LucideIcons.x,
                            onPressed: onPressedCleanComment,
                          ),
                        );
                      },
                    ),
                  ],
                ),
                Text(
                  LocaleKeys.addCommentHint.tr(),
                  style: context.themeStyleV2.textStyles.labelXSmall.copyWith(
                    color: context.themeStyleV2.colors.content3,
                  ),
                ),
              ],
            )
          : GhostButton(
              buttonShape: ButtonShape.rectangle,
              buttonSize: ButtonSize.medium,
              title: LocaleKeys.addComment.tr(),
              icon: LucideIcons.plus,
              onPressed: () {
                commentState.accept(true);
                focusNode.requestFocus();
              },
            ),
    );
  }
}
