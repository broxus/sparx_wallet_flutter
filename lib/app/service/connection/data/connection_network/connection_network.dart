import 'package:app/app/service/connection/data/connection_data/connection_data.dart';
import 'package:app/app/service/connection/data/connection_transport/connection_transport_data.dart';

class ConnectionNetwork {
  ConnectionNetwork({
   required this.connection,
   required this.transport,
});

  final ConnectionData connection;
  final ConnectionTransportData transport;

}