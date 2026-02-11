import 'package:app/utils/parse_utils.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:nekoton_repository/nekoton_repository.dart';

class PollingConfigConverter
    implements JsonConverter<PollingConfig?, Map<String, dynamic>?> {
  const PollingConfigConverter();

  @override
  PollingConfig? fromJson(Map<String, dynamic>? json) {
    if (json == null) return null;

    final ton = parseToInt(json['tonWalletRefreshInterval']);
    final token = parseToInt(json['tokenWalletRefreshInterval']);
    final intensive = parseToInt(json['intensivePollingInterval']);

    String? sseBaseUrl;
    final rawSseBaseUrl = json['sseBaseUrl'];
    if (rawSseBaseUrl is String && rawSseBaseUrl.isNotEmpty) {
      final uri = Uri.tryParse(rawSseBaseUrl);
      if (uri != null &&
          uri.hasScheme &&
          uri.hasAuthority &&
          (uri.scheme == 'http' || uri.scheme == 'https')) {
        sseBaseUrl = rawSseBaseUrl;
      }
    }
    return PollingConfig(
      tonWalletRefreshInterval: ton != null
          ? Duration(seconds: ton)
          : PollingConfig.defaultConfig.tonWalletRefreshInterval,
      tokenWalletRefreshInterval: token != null
          ? Duration(seconds: token)
          : PollingConfig.defaultConfig.tokenWalletRefreshInterval,
      intensivePollingInterval: intensive != null
          ? Duration(seconds: intensive)
          : PollingConfig.defaultConfig.intensivePollingInterval,
      sseBaseUrl: sseBaseUrl,
    );
  }

  @override
  Map<String, dynamic>? toJson(PollingConfig? v) => v == null
      ? null
      : {
          'tonWalletRefreshInterval': v.tonWalletRefreshInterval.inSeconds,
          'tokenWalletRefreshInterval': v.tokenWalletRefreshInterval.inSeconds,
          'intensivePollingInterval': v.intensivePollingInterval.inSeconds,
        };
}
