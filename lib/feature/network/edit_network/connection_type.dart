import 'package:app/app/service/connection/data/connection_data/connection_data.dart';

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

  static ConnectionType fromConnection(ConnectionData connection) =>
      switch (connection) {
        ConnectionDataGql() => ConnectionType.gql,
        ConnectionDataProto() => ConnectionType.proto,
        ConnectionDataJrpc() => ConnectionType.jrpc,
      };
}
