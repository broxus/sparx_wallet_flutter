sealed class HistoryUiModel {}

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
