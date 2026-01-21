import 'package:elementary_helper/elementary_helper.dart';
import 'package:flutter/material.dart';

abstract interface class CommentUi {
  abstract final TextEditingController commentController;

  abstract final FocusNode commentFocus;

  abstract final ListenableState<bool> commentState;

  void onPlusPressed();
}

class CommentUiDelegate implements CommentUi {
  @override
  final commentController = TextEditingController();
  @override
  final commentFocus = FocusNode();

  @override
  final StateNotifier<bool> commentState = StateNotifier(initValue: false);

  String get text => commentController.text;

  void requestFocus() {
    commentFocus.requestFocus();
  }

  void clearComment() {
    commentController.clear();
  }

  @override
  void onPlusPressed() {
    commentState.accept(true);
    commentFocus.requestFocus();
  }

  void dispose() {
    commentController.dispose();
    commentFocus.dispose();
    commentState.dispose();
  }
}
