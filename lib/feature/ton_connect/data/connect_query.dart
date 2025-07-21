import 'package:freezed_annotation/freezed_annotation.dart';

part 'connect_query.freezed.dart';
part 'connect_query.g.dart';

@freezed
abstract class ConnectQuery with _$ConnectQuery {
  const factory ConnectQuery({
    required String v,
    required String r,
    required String id,
    required String ret,
  }) = _ConnectQuery;

  factory ConnectQuery.fromJson(Map<String, dynamic> json) =>
      _$ConnectQueryFromJson(json);

  factory ConnectQuery.fromQuery(String query) => ConnectQuery.fromJson(
        Map<String, dynamic>.from(
          Uri.splitQueryString(query),
        ),
      );
}
