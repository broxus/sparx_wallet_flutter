import 'package:app/generated/generated.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:ui_components_lib/ui_components_lib.dart';

class SearchBarHeaderDelegate extends SliverPersistentHeaderDelegate {
  SearchBarHeaderDelegate({required this.controller});

  static const double headerHeight = DimensSize.d106;

  TextEditingController controller;

  @override
  Widget build(
    BuildContext context,
    double shrinkOffset,
    bool overlapsContent,
  ) {
    final colors = context.themeStyleV2.colors;

    return Column(
      children: [
        Container(
          color: colors.background0,
          padding: const EdgeInsets.only(
            top: DimensSize.d32,
            bottom: DimensSize.d16,
            left: DimensSize.d16,
            right: DimensSize.d16,
          ),
          child: PrimaryTextField(
            hintText: LocaleKeys.browserSearch.tr(),
            textEditingController: controller,
            suffixes: [
              Padding(
                padding: const EdgeInsets.only(right: DimensSize.d20),
                child: CommonIconWidget.svg(
                  svg: Assets.images.search.path,
                  color: colors.content0,
                  width: DimensSize.d16,
                  height: DimensSize.d16,
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }

  @override
  double get maxExtent => headerHeight;

  @override
  double get minExtent => headerHeight;

  @override
  bool shouldRebuild(covariant SliverPersistentHeaderDelegate oldDelegate) {
    return true;
  }
}
