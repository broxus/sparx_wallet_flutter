import 'package:app/app/service/connection/data/connection/connection.dart';
import 'package:app/app/service/connection/data/work_chain/workchain_transport_type.dart';

enum ConnectionType {
  jrpc,
  gql,
  proto;

  bool get enableMultipleEndpoints {
    switch (this) {
      case ConnectionType.jrpc:
        return false;
      case ConnectionType.gql:
        return true;
      case ConnectionType.proto:
        return false;
    }
  }

  bool get enableLocal {
    switch (this) {
      case ConnectionType.jrpc:
        return false;
      case ConnectionType.gql:
        return true;
      case ConnectionType.proto:
        return false;
    }
  }

  static ConnectionType fromConnection(Connection connection) =>
      switch (connection.defaultWorkchain.transportType) {
        WorkchainTransportType.gql => ConnectionType.gql,
        WorkchainTransportType.proto => ConnectionType.proto,
        WorkchainTransportType.jrpc => ConnectionType.jrpc,
      };
}
