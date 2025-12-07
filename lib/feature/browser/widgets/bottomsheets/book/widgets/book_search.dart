import 'package:app/generated/generated.dart';
import 'package:elementary_helper/elementary_helper.dart';
import 'package:flutter/material.dart';
import 'package:ui_components_lib/dimens.dart';
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
              bottom: DimensSize.d16,
              left: DimensSize.d24,
              right: DimensSize.d24,
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
