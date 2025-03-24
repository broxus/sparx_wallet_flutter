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

  late final _faviconUrlState = createNotifier<String?>();

  ListenableState<String?> get faviconUrlState => _faviconUrlState;

  @override
  void initWidgetModel() {
    model.allFaviconsState.addListener(_handleFavicons);
    model.fetchFavicons(widget.uri);
    super.initWidgetModel();
  }

  @override
  void dispose() {
    model.allFaviconsState.removeListener(_handleFavicons);
    super.dispose();
  }

  void _handleFavicons() {
    final data = model.allFaviconsState.value;
    final faviconUri = widget.uri;

    if (faviconUri == null || data == null) {
      return;
    }
    _faviconUrlState.accept(model.allFaviconsState.value?.getSafe(faviconUri));
  }
}
