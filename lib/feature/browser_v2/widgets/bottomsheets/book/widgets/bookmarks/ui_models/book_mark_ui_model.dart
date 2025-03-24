class BookMarkUiModel {
  BookMarkUiModel({
    required this.bookmarkId,
    required this.uri,
    required this.title,
  });

  final String bookmarkId;
  final Uri uri;
  // late final String url = uri.toString();
  final String title;
  late final String subTitle = uri.host;
}
