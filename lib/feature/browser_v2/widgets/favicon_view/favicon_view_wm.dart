import 'package:app/core/wm/custom_wm.dart';
import 'package:app/feature/browser_v2/widgets/favicon_view/favicon_view.dart';
import 'package:app/feature/browser_v2/widgets/favicon_view/favicon_view_model.dart';
import 'package:elementary/elementary.dart';
import 'package:elementary_helper/elementary_helper.dart';
import 'package:injectable/injectable.dart';

/// [WidgetModel] для [FaviconView]
@injectable
class FaviconViewWidgetModel
    extends CustomWidgetModel<FaviconView, FaviconViewModel> {
  FaviconViewWidgetModel(
    super.model,
    @factoryParam this._uri,
  );

  final Uri? _uri;

  late final _faviconUrlState = createEntityNotifier<String?>()..loading();

  EntityStateNotifier<String?> get faviconUrlState => _faviconUrlState;

  @override
  void initWidgetModel() {
    _fetch();
    super.initWidgetModel();
  }

  Future<void> _fetch() async {
    final url = await model.getFavicon(_uri);

    if (url == null) {
      _faviconUrlState.error();
      return;
    }

    _faviconUrlState.content(url);
  }
}
