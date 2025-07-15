import 'package:app/core/error_handler_factory.dart';
import 'package:app/core/wm/custom_wm.dart';
import 'package:app/di/di.dart';
import 'package:app/feature/browser_v2/widgets/favicon_view/favicon_view.dart';
import 'package:app/feature/browser_v2/widgets/favicon_view/favicon_view_model.dart';
import 'package:elementary/elementary.dart';
import 'package:elementary_helper/elementary_helper.dart';
import 'package:flutter/widgets.dart';

/// Factory method for creating [FaviconViewWidgetModel]
FaviconViewWidgetModel defaultFaviconViewWidgetModelFactory(
  BuildContext context,
) {
  return FaviconViewWidgetModel(
    FaviconViewModel(
      createPrimaryErrorHandler(context),
      inject(),
    ),
  );
}

/// [WidgetModel] для [FaviconView]
class FaviconViewWidgetModel
    extends CustomWidgetModel<FaviconView, FaviconViewModel> {
  FaviconViewWidgetModel(
    super.model,
  );

  late final _faviconUrlState = createEntityNotifier<String?>()..loading();

  EntityStateNotifier<String?> get faviconUrlState => _faviconUrlState;

  @override
  void initWidgetModel() {
    _fetch();
    super.initWidgetModel();
  }

  Future<void> _fetch() async {
    final url = await model.getFavicon(widget.uri);

    if (url == null) {
      _faviconUrlState.error();
      return;
    }

    _faviconUrlState.content(url);
  }
}
