import 'package:app/app/router/compass/compass.dart';
import 'package:app/feature/network/edit_network/edit_network_page_widget.dart';
import 'package:injectable/injectable.dart';

/// Constants for query parameter names
const _dataIdQueryParam = 'connectionDataId';

@named
@Singleton(as: CompassBaseRoute)
class EditNetworkRoute extends CompassRoute<EditNetworkRouteData> {
  EditNetworkRoute()
      : super(
          path: '/edit-network',
          isSaveLocation: true,
          builder: (context, data, _) => EditNetworkPageWidget(
            connectionDataId: data.connectionDataId,
          ),
        );

  @override
  EditNetworkRouteData fromQueryParams(Map<String, String> queryParams) {
    return EditNetworkRouteData(
      connectionDataId: queryParams[_dataIdQueryParam],
    );
  }
}

class EditNetworkRouteData implements CompassRouteDataQuery {
  const EditNetworkRouteData({
    /// ID of the connection to edit, null for new connection
    this.connectionDataId,
  });

  final String? connectionDataId;

  @override
  Map<String, String> toQueryParams() {
    return {
      if (connectionDataId != null) _dataIdQueryParam: connectionDataId!,
    };
  }
}
