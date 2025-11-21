import 'package:flutter/material.dart';
import 'package:ui_components_lib/v2/ui_components_lib_v2.dart';

class BookEmpty extends StatelessWidget {
  const BookEmpty({required this.title, required this.description, super.key});

  final String title;
  final String description;

  @override
  Widget build(BuildContext context) {
    final theme = context.themeStyleV2;
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Padding(
          padding: const EdgeInsets.only(bottom: DimensSizeV2.d8),
          child: Text(title, style: theme.textStyles.headingLarge),
        ),
        Text(
          description,
          textAlign: TextAlign.center,
          style: theme.textStyles.paragraphMedium.copyWith(
            color: theme.colors.content4,
          ),
        ),
      ],
    );
  }
}
