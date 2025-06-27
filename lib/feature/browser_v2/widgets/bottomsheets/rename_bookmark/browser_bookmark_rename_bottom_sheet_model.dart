import 'package:app/feature/browser_v2/domain/service/browser_service.dart';
import 'package:app/feature/browser_v2/widgets/bottomsheets/rename_bookmark/browser_bookmark_rename_bottom_sheet.dart';
import 'package:elementary/elementary.dart';
import 'package:injectable/injectable.dart';

/// [ElementaryModel] for [BrowserBookmarkRenameBottomSheet]
@injectable
class BrowserBookmarkRenameBottomSheetModel extends ElementaryModel {
  BrowserBookmarkRenameBottomSheetModel(
    ErrorHandler errorHandler,
    this._browserService,
  ) : super(errorHandler: errorHandler);

  final BrowserService _browserService;

  void renameBookmark(String id, String text) {
    _browserService.book.renameBookmark(id, text);
  }
}
