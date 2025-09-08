sealed class BaseBookUiModel {}

class BookMarkUiModel extends BaseBookUiModel {
  BookMarkUiModel({
    required this.bookmarkId,
    required this.uri,
    required this.title,
  });

  final String bookmarkId;
  final Uri uri;
  final String title;
  late final String subTitle = uri.host;
}

sealed class HistoryUiModel extends BaseBookUiModel {}

class DateUiModel extends HistoryUiModel {
  DateUiModel(this.dateText);

  final String dateText;
}

class HistoryItemUiModel extends HistoryUiModel {
  HistoryItemUiModel({
    required this.id,
    required this.uri,
    required this.title,
    required this.subTitle,
  });

  final String id;
  final Uri uri;
  final String title;
  final String subTitle;
}