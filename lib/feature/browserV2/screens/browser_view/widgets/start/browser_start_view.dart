import 'package:app/generated/generated.dart';
import 'package:flutter/material.dart';
import 'package:ui_components_lib/v2/ui_components_lib_v2.dart';

// TODO(kngihtforce): not complete
class BrowserStartView extends StatelessWidget {
  const BrowserStartView({super.key});

  @override
  Widget build(BuildContext context) {
    return DecoratedBox(
      decoration: BoxDecoration(
        color: context.themeStyleV2.colors.background0,
      ),
      child: Stack(
        children: [
          Assets.images.bgNetwork.image(width: double.infinity),
          const Positioned(
            bottom: 0,
            left: 0,
            right: 0,
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [],
            ),
          ),
        ],
      ),
    );
  }
}
