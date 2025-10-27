import 'dart:convert';

import 'package:app/app/router/compass/compass.dart';
import 'package:app/app/service/service.dart';
import 'package:app/feature/wallet/new_account/screen/new_account_screen.dart';
import 'package:app/utils/utils.dart';
import 'package:injectable/injectable.dart';

// Constants moved from wallet.dart
const _publicKeyQueryParam = 'publicKey';
const _passwordQueryParam = 'password';

@named
@Singleton(as: CompassBaseRoute)
class NewAccountRoute extends CompassRoute<NewAccountRouteData> {
  NewAccountRoute()
    : super(
        path: '/wallet-new-account',
        builder: (context, data, _) => NewAccountScreen(
          publicKey: data.publicKey,
          password: data.password,
        ),
      );

  @override
  NewAccountRouteData fromQueryParams(Map<String, String> queryParams) {
    return NewAccountRouteData(
      publicKey: queryParams[_publicKeyQueryParam]!,
      password: queryParams[_passwordQueryParam]?.let(
        (it) => SecureString.fromJson(jsonDecode(it) as Map<String, dynamic>),
      ),
    );
  }
}

class NewAccountRouteData implements CompassRouteDataQuery {
  const NewAccountRouteData({required this.publicKey, this.password});

  final String publicKey;
  final SecureString? password;

  @override
  Map<String, String> toQueryParams() {
    final result = <String, String>{_publicKeyQueryParam: publicKey};

    if (password != null) {
      result[_passwordQueryParam] = jsonEncode(password!.toJson());
    }

    return result;
  }
}
