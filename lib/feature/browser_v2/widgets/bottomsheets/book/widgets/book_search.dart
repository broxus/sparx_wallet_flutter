import 'package:app/feature/browser_v2/widgets/bottomsheets/book/widgets/tab_data.dart';
import 'package:app/generated/generated.dart';
import 'package:elementary_helper/elementary_helper.dart';
import 'package:flutter/material.dart';
import 'package:ui_components_lib/v2/dimens_v2.dart';
import 'package:ui_components_lib/v2/widgets/text_fields/primary_text_field.dart';

class BookSearch extends StatelessWidget {
  const BookSearch({
    required this.searchVisibleState,
    required this.searchController,
    super.key,
  });

  final ListenableState<bool> searchVisibleState;
  final TextEditingController searchController;

  @override
  Widget build(BuildContext context) {
    return SliverToBoxAdapter(
      child: StateNotifierBuilder<bool>(
        listenableState: searchVisibleState,
        builder: (_, bool? isVisible) {
          isVisible ??= false;

          if (!isVisible) {
            return const SizedBox.shrink();
          }
          return Padding(
            padding: const EdgeInsets.only(
              bottom: DimensSizeV2.d16,
              left: DimensSizeV2.d24,
              right: DimensSizeV2.d24,
            ),
            child: PrimaryTextField(
              hintText: LocaleKeys.browserSearch.tr(),
              textEditingController: searchController,
            ),
          );
        },
      ),
    );
  }
}
