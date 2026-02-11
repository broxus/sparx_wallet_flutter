import 'package:flutter/material.dart';

class CustomMediaQuery extends StatelessWidget {
  const CustomMediaQuery({
    required this.child,
    this.data,
    this.viewInsets,
    this.viewInsetsBottomAddon = 0,
    super.key,
  });

  final Widget child;
  final MediaQueryData? data;
  final EdgeInsets? viewInsets;
  final double viewInsetsBottomAddon;

  @override
  Widget build(BuildContext context) {
    return MediaQuery(
      data:
          data ??
          MediaQuery.of(context).copyWith(
            viewInsets:
                viewInsets ??
                MediaQuery.of(context).viewInsets.copyWith(
                  bottom:
                      MediaQuery.of(context).viewInsets.bottom +
                      viewInsetsBottomAddon,
                ),
          ),
      child: child,
    );
  }
}
