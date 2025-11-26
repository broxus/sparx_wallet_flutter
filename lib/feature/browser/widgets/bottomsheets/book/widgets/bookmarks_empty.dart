import 'package:app/feature/browser/widgets/bottomsheets/book/widgets/empty_content.dart';
import 'package:app/generated/generated.dart';
import 'package:flutter/material.dart';

class BookmarksEmptyContent extends StatelessWidget {
  const BookmarksEmptyContent({super.key});

  @override
  Widget build(BuildContext context) {
    return BookEmpty(
      title: LocaleKeys.noBookmarksYet.tr(),
      description: LocaleKeys.bookmarksEmptyDescription.tr(),
    );
  }
}
