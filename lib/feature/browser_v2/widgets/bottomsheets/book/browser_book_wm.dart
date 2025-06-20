import 'package:app/core/wm/custom_wm.dart';
import 'package:app/feature/browser_v2/widgets/bottomsheets/book/browser_book.dart';
import 'package:app/feature/browser_v2/widgets/bottomsheets/book/browser_book_model.dart';
import 'package:app/feature/browser_v2/widgets/bottomsheets/book/widgets/tab_data.dart';
import 'package:elementary/elementary.dart';
import 'package:elementary_helper/elementary_helper.dart';
import 'package:flutter/widgets.dart';
import 'package:injectable/injectable.dart';

/// [WidgetModel] для [BrowserBook]
@injectable
class BrowserBookWidgetModel
    extends CustomWidgetModel<BrowserBook, BrowserBookModel> {
  BrowserBookWidgetModel(
    super.model,
  );

  late final _tabBarState = createNotifier<BrowserBookTabBarValue>(
    BrowserBookTabBarValue.bookMarks,
  );
  late final height = _screenHeight * .7;

  late final _screenHeight = MediaQuery.of(context).size.height;

  ListenableState<BrowserBookTabBarValue> get tabBarState => _tabBarState;

  void onPressedTab(BrowserBookTabBarValue value) {
    _tabBarState.accept(value);
  }
}
