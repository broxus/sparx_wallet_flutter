import 'package:app/app/router/compass/compass.dart';
import 'package:app/feature/network/edit_network/edit_network_page_widget.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:injectable/injectable.dart';

part 'route.freezed.dart';

/// Constants for query parameter names
const networkConnectionDataIdQueryParam = 'connectionDataId';

@named
@Singleton(as: CompassBaseRoute)
class EditNetworkRoute extends CompassRoute<EditNetworkRouteData> {
  EditNetworkRoute()
      : super(
          name: 'edit-network',
          builder: (context, data, _) => EditNetworkPageWidget(
            connectionDataId: data.connectionDataId,
          ),
        );

  @override
  EditNetworkRouteData fromQueryParams(Map<String, String> queryParams) {
    return EditNetworkRouteData(
      connectionDataId: queryParams[networkConnectionDataIdQueryParam],
    );
  }
}

/// Data model for EditNetwork route
@freezed
class EditNetworkRouteData
    with _$EditNetworkRouteData
    implements CompassRouteDataQuery {
  const factory EditNetworkRouteData({
    /// ID of the connection to edit, null for new connection
    String? connectionDataId,
  }) = _EditNetworkRouteData;

  const EditNetworkRouteData._();

  @override
  Map<String, String> toQueryParams() {
    return {
      if (connectionDataId != null)
        networkConnectionDataIdQueryParam: connectionDataId!,
    };
  }
}

