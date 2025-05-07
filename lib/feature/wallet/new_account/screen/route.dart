import 'package:app/app/router/compass/compass.dart';
import 'package:app/feature/wallet/new_account/screen/new_account_screen.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:injectable/injectable.dart';

part 'route.freezed.dart';

// Constants moved from wallet.dart
const walletCreatePublicKeyQueryParam = 'walletCreatePublicKey';
const walletCreatePasswordQueryParam = 'walletCreatePassword';

@lazySingleton
class WalletNewAccountRoute
    extends CompassRoute<WalletNewAccountRouteData> {
  WalletNewAccountRoute()
      : super(
          name: 'wallet-new-account',
          builder: (context, data, _) => NewAccountScreen(
            publicKey: data.publicKey,
            password: data.password,
          ),
        );

  @override
  WalletNewAccountRouteData fromQueryParams(Map<String, String> queryParams) {
    return WalletNewAccountRouteData(
      publicKey: queryParams[walletCreatePublicKeyQueryParam] ?? '',
      password: queryParams[walletCreatePasswordQueryParam],
    );
  }
}

/// Data model for WalletNewAccount route
@freezed
class WalletNewAccountRouteData
    with _$WalletNewAccountRouteData
    implements CompassRouteDataQuery {
  const factory WalletNewAccountRouteData({
    required String publicKey,
    String? password,
  }) = _WalletNewAccountRouteData;

  const WalletNewAccountRouteData._();

  @override
  Map<String, String> toQueryParams() {
    final result = <String, String>{
      walletCreatePublicKeyQueryParam: publicKey,
    };

    if (password != null) {
      result[walletCreatePasswordQueryParam] = password!;
    }

    return result;
  }
}
