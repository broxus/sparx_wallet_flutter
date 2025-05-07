import 'dart:convert';

import 'package:app/app/router/compass/compass.dart';
import 'package:app/data/models/seed/seed_phrase_model.dart';
import 'package:app/feature/add_seed/create_password/screens/create_seed_password/create_seed_password_screen.dart';
import 'package:app/feature/biometry/view/route.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:injectable/injectable.dart';
import 'package:nekoton_repository/nekoton_repository.dart';

part 'route.freezed.dart';

/// Constants for query parameter names
const createSeedPasswordPhraseQueryParam = 'phrase';
const createSeedPasswordMnemonicTypeQueryParam = 'mnemonicType';

@lazySingleton
class CreateSeedPasswordRoute
    extends CompassRoute<CreateSeedPasswordRouteData, void> {
  CreateSeedPasswordRoute({
    required this.enableBiometryRoute,
  }) : super(
          name: 'create-seed-password',
          path: 'create-seed-password',
          builder: (context, data, _) => CreateSeedPasswordScreen(
            phrase: data.phrase,
            mnemonicType: data.mnemonicType,
          ),
          compassBaseRoutes: [enableBiometryRoute],
        );

  final EnableBiometryRoute enableBiometryRoute;

  @override
  CreateSeedPasswordRouteData fromQueryParams(Map<String, String> queryParams) {
    final mnemonicTypeJson =
        queryParams[createSeedPasswordMnemonicTypeQueryParam];

    return CreateSeedPasswordRouteData(
      phrase: queryParams[createSeedPasswordPhraseQueryParam] != null
          ? SeedPhraseModel(queryParams[createSeedPasswordPhraseQueryParam])
          : null,
      mnemonicType: mnemonicTypeJson != null
          ? const MnemonicTypeJsonConverter().fromJson(
              jsonDecode(mnemonicTypeJson) as Map<String, dynamic>,
            )
          : null,
    );
  }
}

/// Data model for CreateSeedPassword route
@freezed
class CreateSeedPasswordRouteData
    with _$CreateSeedPasswordRouteData
    implements CompassRouteDataQuery {
  const factory CreateSeedPasswordRouteData({
    /// Seed phrase
    SeedPhraseModel? phrase,

    /// Mnemonic type
    MnemonicType? mnemonicType,
  }) = _CreateSeedPasswordRouteData;

  const CreateSeedPasswordRouteData._();

  @override
  Map<String, String> toQueryParams() {
    final mnemonicType = this.mnemonicType;

    return {
      if (phrase != null) createSeedPasswordPhraseQueryParam: phrase!.phrase,
      if (mnemonicType != null)
        createSeedPasswordMnemonicTypeQueryParam: jsonEncode(
          const MnemonicTypeJsonConverter().toJson(mnemonicType),
        ),
    };
  }
}
