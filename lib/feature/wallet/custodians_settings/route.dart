import 'dart:convert';

import 'package:app/app/router/compass/compass.dart';
import 'package:app/feature/wallet/custodians_settings/custodians_settings_page.dart';
import 'package:injectable/injectable.dart';

/// Constants for query parameter names
const _custodiansQueryParam = 'custodians';

@named
@Singleton(as: CompassBaseRoute)
class CustodiansSettingsRoute
    extends CompassRoute<CustodiansSettingsRouteData> {
  CustodiansSettingsRoute()
      : super(
          path: '/custodians-settings',
          builder: (context, data, _) => CustodiansSettingsPage(
            custodians: data.custodians,
          ),
        );

  @override
  CustodiansSettingsRouteData fromQueryParams(Map<String, String> queryParams) {
    final custodiansParam = queryParams[_custodiansQueryParam];
    if (custodiansParam == null || custodiansParam.isEmpty) {
      return const CustodiansSettingsRouteData(custodians: []);
    }

    final decoded =
        (jsonDecode(custodiansParam) as List<dynamic>).cast<String>();
    return CustodiansSettingsRouteData(custodians: decoded);
  }
}

class CustodiansSettingsRouteData implements CompassRouteDataQuery {
  const CustodiansSettingsRouteData({
    required this.custodians,
  });

  final List<String> custodians;

  @override
  Map<String, String> toQueryParams() {
    if (custodians.isEmpty) {
      return {};
    }

    return {
      _custodiansQueryParam: jsonEncode(custodians),
    };
  }
}
