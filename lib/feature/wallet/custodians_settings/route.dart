import 'dart:convert';

import 'package:app/app/router/compass/compass.dart';
import 'package:app/feature/wallet/custodians_settings/custodians_settings_page.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:injectable/injectable.dart';

part 'route.freezed.dart';

// Moved parameter constants here from wallet.dart
const custodianSettingsCustodiansParam = 'custodianSettingsCustodiansParam';

@singleton
class CustodiansSettingsRoute
    extends CompassRoute<CustodiansSettingsRouteData> {
  CustodiansSettingsRoute()
      : super(
          name: 'custodians-settings',
          builder: (context, data, _) => CustodiansSettingsPage(
            custodians: data.custodians,
          ),
        );

  @override
  CustodiansSettingsRouteData fromQueryParams(Map<String, String> queryParams) {
    final custodiansParam = queryParams[custodianSettingsCustodiansParam];
    if (custodiansParam == null || custodiansParam.isEmpty) {
      return const CustodiansSettingsRouteData(custodians: []);
    }

    final decoded =
        (jsonDecode(custodiansParam) as List<dynamic>).cast<String>();
    return CustodiansSettingsRouteData(custodians: decoded);
  }
}

/// Data model for CustodiansSettings route
@freezed
class CustodiansSettingsRouteData
    with _$CustodiansSettingsRouteData
    implements CompassRouteDataQuery {
  const factory CustodiansSettingsRouteData({
    required List<String> custodians,
  }) = _CustodiansSettingsRouteData;

  const CustodiansSettingsRouteData._();

  @override
  Map<String, String> toQueryParams() {
    if (custodians.isEmpty) {
      return {};
    }

    return {
      custodianSettingsCustodiansParam: jsonEncode(custodians),
    };
  }
}
