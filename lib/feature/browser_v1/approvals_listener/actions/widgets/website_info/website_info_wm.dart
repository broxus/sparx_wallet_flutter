import 'package:app/core/wm/custom_wm.dart';
import 'package:app/feature/browser_v1/approvals_listener/actions/widgets/website_info/website_info_model.dart';
import 'package:app/feature/browser_v1/approvals_listener/actions/widgets/website_info/website_info_widget.dart';
import 'package:flutter/foundation.dart';
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
class WebsiteInfoWidgetModel extends InjectedWidgetModel<WebsiteInfoWidget,
    WebsiteInfoModel, WebsiteInfoWmParams> {
  WebsiteInfoWidgetModel(
    super.model,
  );

  late final _uri = createWmParamsNotifier(
    (it) => it.uri,
  );

  late final _faviconUrl = createWmParamsNotifier(
    (it) => it.iconUrl?.toString(),
  );

  ValueListenable<Uri> get uri => _uri;

  ValueListenable<String?> get faviconUrl => _faviconUrl;

  ThemeStyleV2 get theme => context.themeStyleV2;

  @override
  void initWidgetModel() {
    super.initWidgetModel();

    if (_faviconUrl.value == null) {
      _getFaviconUrl();
    }
  }

  Future<void> _getFaviconUrl() async {
    final url = await model.getFaviconUrl(_uri.value);

    if (url != null) {
      _faviconUrl.value = url;
    }
  }
}
