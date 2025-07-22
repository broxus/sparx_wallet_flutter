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
class WebsiteInfoWidgetModel extends CustomWidgetModelParametrized<
    WebsiteInfoWidget, WebsiteInfoModel, WebsiteInfoWmParams> {
  WebsiteInfoWidgetModel(
    super.model,
  );

  late final _uriState = createWmParamsNotifier(
    (it) => it.uri,
  );

  late final _faviconUrlState = createWmParamsNotifier(
    (it) => it.iconUrl?.toString(),
  );

  ValueListenable<Uri> get uriState => _uriState;

  ValueListenable<String?> get faviconUrlState => _faviconUrlState;

  ThemeStyleV2 get theme => context.themeStyleV2;

  @override
  void initWidgetModel() {
    super.initWidgetModel();

    if (_faviconUrlState.value == null) {
      _getFaviconUrl();
    }
  }

  Future<void> _getFaviconUrl() async {
    final url = await model.getFaviconUrl(_uriState.value);

    if (url != null) {
      _faviconUrlState.value = url;
    }
  }
}
