import 'package:app/feature/browser_v2/widgets/bottomsheets/book/widgets/empty_content.dart';
import 'package:app/generated/generated.dart';
import 'package:flutter/material.dart';

class HistoryEmptyEmptyContent extends StatelessWidget {
  const HistoryEmptyEmptyContent({super.key});

  @override
  Widget build(BuildContext context) {
    return BookEmpty(
      title: LocaleKeys.noHistoryYet.tr(),
      description: LocaleKeys.historyEmptyDescription.tr(),
    );
  }
}
