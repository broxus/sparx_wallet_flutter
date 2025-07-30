import 'package:app/feature/browser_v2/widgets/bottomsheets/book/browser_book.dart';
import 'package:elementary/elementary.dart';
import 'package:injectable/injectable.dart';

/// [ElementaryModel] for [BrowserBook]
@injectable
class BrowserBookModel extends ElementaryModel {
  BrowserBookModel(
    ErrorHandler errorHandler,
  ) : super(errorHandler: errorHandler);
}
