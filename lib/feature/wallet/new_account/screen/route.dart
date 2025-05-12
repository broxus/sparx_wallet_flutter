import 'package:app/app/router/compass/compass.dart';
import 'package:app/feature/wallet/new_account/screen/new_account_screen.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:injectable/injectable.dart';

part 'route.freezed.dart';

// Constants moved from wallet.dart
const _publicKeyQueryParam = 'publicKey';
const _passwordQueryParam = 'password';

@singleton
class NewAccountRoute extends CompassRoute<NewAccountRouteData> {
  NewAccountRoute()
      : super(
          name: 'wallet-new-account',
          builder: (context, data, _) => NewAccountScreen(
            publicKey: data.publicKey,
            password: data.password,
          ),
        );

  @override
  NewAccountRouteData fromQueryParams(Map<String, String> queryParams) {
    return NewAccountRouteData(
      publicKey: queryParams[_publicKeyQueryParam]!,
      password: queryParams[_passwordQueryParam],
    );
  }
}

/// Data model for NewAccount route
@freezed
class NewAccountRouteData
    with _$NewAccountRouteData
    implements CompassRouteDataQuery {
  const factory NewAccountRouteData({
    required String publicKey,
    String? password,
  }) = _NewAccountRouteData;

  const NewAccountRouteData._();

  @override
  Map<String, String> toQueryParams() {
    final result = <String, String>{
      _publicKeyQueryParam: publicKey,
    };

    if (password != null) {
      result[_passwordQueryParam] = password!;
    }

    return result;
  }
}
