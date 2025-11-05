sealed class TipUiModel {
  TipUiModel({required this.id, required this.title});

  final String id;
  final String title;
}

class HistoryTipUiModel extends TipUiModel {
  HistoryTipUiModel({required super.id, required super.title});
}

class BookmarkTipUiModel extends TipUiModel {
  BookmarkTipUiModel({
    required super.id,
    required super.title,
    required this.uri,
  });

  final Uri uri;
}
