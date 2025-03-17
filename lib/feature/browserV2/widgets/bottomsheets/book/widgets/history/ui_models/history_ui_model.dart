sealed class HistoryUiModel {}

class DateUiModel extends HistoryUiModel {
  DateUiModel(this.dateText);

  final String dateText;
}

class HistoryItemUiModel extends HistoryUiModel {
  HistoryItemUiModel({
    required this.id,
    required this.title,
    required this.url,
  });

  final String id;
  final String title;
  final String url;
}
