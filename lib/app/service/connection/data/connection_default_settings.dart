import 'package:app/app/service/connection/data/wallet_default_account_names.dart';
import 'package:freezed_annotation/freezed_annotation.dart';

part 'connection_default_settings.freezed.dart';

part 'connection_default_settings.g.dart';

@freezed
abstract class ConnectionDefaultSettings with _$ConnectionDefaultSettings {
  factory ConnectionDefaultSettings({
    required WalletDefaultAccountNames walletAccountNames,
  }) = _ConnectionDefaultSettings;

  factory ConnectionDefaultSettings.fromJson(Map<String, dynamic> json) =>
      _$ConnectionDefaultSettingsFromJson(json);
}
