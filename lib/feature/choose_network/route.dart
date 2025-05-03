import 'package:app/app/router/base/base.dart';
import 'package:app/feature/choose_network/choose_network_screen.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:injectable/injectable.dart';

part 'route.freezed.dart';

@lazySingleton
class ChooseNetworkRoute extends SparxRoute<ChooseNetworkRouteData, void> {
  ChooseNetworkRoute()
      : super(
          name: 'choose-network',
          builder: (context, data, _) {
            return ChooseNetworkScreen(
              nextStep: data.nextStep,
            );
          },
        );

  @override
  ChooseNetworkRouteData fromQueryParams(Map<String, String> queryParams) {
    return ChooseNetworkRouteData.fromQueryParams(queryParams);
  }
}

@freezed
class ChooseNetworkRouteData
    with _$ChooseNetworkRouteData
    implements SparxRouteDataQuery {
  const factory ChooseNetworkRouteData({
    required String? nextStep,
  }) = _ChooseNetworkRouteData;

  factory ChooseNetworkRouteData.fromQueryParams(
    Map<String, String> queryParams,
  ) {
    return ChooseNetworkRouteData(
      nextStep: queryParams['nextStep'],
    );
  }

  @override
  Map<String, String> toQueryParams() {
    return {
      if (nextStep != null) 'nextStep': nextStep!,
    };
  }
}
