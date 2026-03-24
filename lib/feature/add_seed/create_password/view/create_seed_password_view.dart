import 'package:app/feature/add_seed/create_password/model/password_status.dart';
import 'package:app/feature/add_seed/create_password/view/layouts/create_seed_password_view_default_layout.dart';
import 'package:app/feature/add_seed/create_password/view/layouts/create_seed_password_view_small_layout.dart';
import 'package:app/utils/focus_utils.dart';
import 'package:flutter/material.dart';
import 'package:ui_components_lib/utils/view_utils.dart';

class CreateSeedPasswordView extends StatefulWidget {
  const CreateSeedPasswordView({
    required this.needBiometryIfPossible,
    required this.passwordController,
    required this.confirmController,
    required this.onPressedNext,
    required this.isLoading,
    this.passwordStatus,
    this.backgroundColor,
    super.key,
  });

  /// If true, then biometry will be requested if possible
  final bool needBiometryIfPossible;
  final TextEditingController passwordController;
  final TextEditingController confirmController;
  final VoidCallback onPressedNext;
  final bool isLoading;
  final PasswordStatus? passwordStatus;
  final Color? backgroundColor;

  @override
  State<CreateSeedPasswordView> createState() => _CreateSeedPasswordViewState();
}

class _CreateSeedPasswordViewState extends State<CreateSeedPasswordView> {
  final ScrollController _scrollController = ScrollController();
  final FocusNode _pwd1focusNode = FocusNode();
  final FocusNode _pwd2focusNode = FocusNode();

  @override
  void initState() {
    super.initState();

    _pwd1focusNode.addListener(() {
      if (_pwd1focusNode.hasFocus) {
        _scrollToBottom();
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return isSmallScreenHeight
        ? CreateSeedPasswordViewSmallLayout(
            backgroundColor: widget.backgroundColor,
            scrollController: _scrollController,
            passwordController: widget.passwordController,
            confirmController: widget.confirmController,
            pwd1focusNode: _pwd1focusNode,
            pwd2focusNode: _pwd2focusNode,
            isLoading: widget.isLoading,
            passwordStatus: widget.passwordStatus,
            onPwd1Submit: _onPwd1Submit,
            onPwd2Submit: _onPwd2Submit,
            onSubmit: _onSubmit,
          )
        : CreateSeedPasswordViewDefaultLayout(
            backgroundColor: widget.backgroundColor,
            scrollController: _scrollController,
            passwordController: widget.passwordController,
            confirmController: widget.confirmController,
            pwd1focusNode: _pwd1focusNode,
            pwd2focusNode: _pwd2focusNode,
            isLoading: widget.isLoading,
            passwordStatus: widget.passwordStatus,
            onPwd1Submit: _onPwd1Submit,
            onPwd2Submit: _onPwd2Submit,
            onSubmit: _onSubmit,
          );
  }

  @override
  void dispose() {
    _pwd1focusNode.dispose();
    _pwd2focusNode.dispose();
    _scrollController.dispose();
    super.dispose();
  }

  void _scrollToBottom() {
    WidgetsBinding.instance.addPostFrameCallback((_) {
      if (!mounted) return;

      if (FocusScope.of(context).hasFocus) {
        Future.delayed(const Duration(milliseconds: 300), () {
          if (mounted && _scrollController.hasClients) {
            _scrollController.animateTo(
              _scrollController.position.maxScrollExtent,
              duration: const Duration(milliseconds: 300),
              curve: Curves.easeInOut,
            );
          }
        });
      }
    });
  }

  void _onPwd1Submit(String? _) => requestFocus(context, _pwd2focusNode);

  void _onPwd2Submit(String? _) => _onSubmit();

  void _onSubmit() {
    if (widget.passwordStatus == PasswordStatus.match) {
      _pwd1focusNode.unfocus();
      _pwd2focusNode.unfocus();
      widget.onPressedNext();
    }
  }
}
