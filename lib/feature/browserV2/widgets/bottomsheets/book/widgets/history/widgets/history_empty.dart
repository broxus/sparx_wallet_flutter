import 'package:app/feature/browserV2/widgets/bottomsheets/book/widgets/empty_content.dart';
import 'package:app/generated/generated.dart';
import 'package:flutter/material.dart';

class HistoryEmptyEmptyContent extends StatelessWidget {
  const HistoryEmptyEmptyContent({super.key});

  @override
  Widget build(BuildContext context) {
    return BookEmpty(
      title: LocaleKeys.noBookmarksYet.tr(),
      description: LocaleKeys.bookmarksEmptyDescription.tr(),
    );
  }
}
