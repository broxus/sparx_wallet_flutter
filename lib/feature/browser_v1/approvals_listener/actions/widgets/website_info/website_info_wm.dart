import 'package:app/core/wm/custom_wm.dart';
import 'package:app/feature/browser_v1/approvals_listener/actions/widgets/website_info/website_info_model.dart';
import 'package:app/feature/browser_v1/approvals_listener/actions/widgets/website_info/website_info_widget.dart';
import 'package:elementary_helper/elementary_helper.dart';
import 'package:injectable/injectable.dart';
import 'package:ui_components_lib/ui_components_lib.dart';

class WebsiteInfoWmParams {
  const WebsiteInfoWmParams({
    required this.uri,
    this.iconUrl,
  });

  final Uri uri;
  final Uri? iconUrl;
}

@injectable
class WebsiteInfoWidgetModel
    extends CustomWidgetModel<WebsiteInfoWidget, WebsiteInfoModel> {
  WebsiteInfoWidgetModel(
    super.model,
    @factoryParam this._wmParams,
  );

  final WebsiteInfoWmParams _wmParams;

  late final _faviconUrl =
      createNotifier<String>(_wmParams.iconUrl?.toString());

  Uri get uri => _wmParams.uri;

  ListenableState<String> get faviconUrl => _faviconUrl;

  ThemeStyleV2 get theme => context.themeStyleV2;

  @override
  void initWidgetModel() {
    super.initWidgetModel();

    if (_wmParams.iconUrl == null) {
      _getFaviconUrl();
    }
  }

  Future<void> _getFaviconUrl() async {
    final url = await model.getFaviconUrl(_wmParams.uri);

    if (url != null) {
      _faviconUrl.accept(url);
    }
  }
}
