import 'dart:convert';

import 'package:app/app/router/compass/compass.dart';
import 'package:app/data/models/seed/seed_phrase_model.dart';
import 'package:app/feature/add_seed/create_password/screens/create_seed_password/create_seed_password_screen.dart';
import 'package:app/feature/add_seed/create_password/view/create_seed_password_page.dart';
import 'package:app/feature/biometry/view/route.dart';
import 'package:app/utils/utils.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:injectable/injectable.dart';
import 'package:nekoton_repository/nekoton_repository.dart';

part 'route.freezed.dart';

// Constants for query parameter names
const _seedQueryParam = 'seed';
const _mnemonicTypeQueryParam = 'mnemonicType';
const _namePathParam = 'name';
const _typeQueryParam = 'type';

@named
@Singleton(as: CompassBaseRoute)
class CreateSeedOnboardingPasswordRoute
    extends CompassRoute<CreateSeedOnboardingPasswordRouteData> {
  CreateSeedOnboardingPasswordRoute(
    @Named.from(EnableBiometryRoute) CompassBaseRoute enableBiometryRoute,
  ) : super(
          name: 'create-seed-onboarding-password',
          builder: (context, data, _) => CreateSeedPasswordScreen(
            phrase: SeedPhraseModel(data.seedPhrase),
            mnemonicType: data.mnemonicType,
          ),
          compassBaseRoutes: [enableBiometryRoute],
        );

  @override
  CreateSeedOnboardingPasswordRouteData fromQueryParams(
    Map<String, String> queryParams,
  ) {
    final mnemonicTypeStr = queryParams[_mnemonicTypeQueryParam];
    final mnemonicType = mnemonicTypeStr != null
        ? const MnemonicTypeJsonConverter().fromJson(
            jsonDecode(mnemonicTypeStr) as Map<String, dynamic>,
          )
        : null;

    return CreateSeedOnboardingPasswordRouteData(
      seedPhrase: queryParams[_seedQueryParam],
      mnemonicType: mnemonicType,
    );
  }
}

@freezed
class CreateSeedOnboardingPasswordRouteData
    with _$CreateSeedOnboardingPasswordRouteData
    implements CompassRouteDataQuery {
  const factory CreateSeedOnboardingPasswordRouteData({
    String? seedPhrase,
    MnemonicType? mnemonicType,
  }) = _CreateSeedOnboardingPasswordRouteData;

  const CreateSeedOnboardingPasswordRouteData._();

  @override
  Map<String, String> toQueryParams() {
    final seedPhrase = this.seedPhrase;
    final mnemonicType = this.mnemonicType;

    return {
      if (seedPhrase != null) _seedQueryParam: seedPhrase,
      if (mnemonicType != null)
        _mnemonicTypeQueryParam: jsonEncode(mnemonicType.toJson()),
    };
  }
}

@named
@Singleton(as: CompassBaseRoute)
class CreateSeedPasswordRoute
    extends CompassRoute<CreateSeedPasswordRouteData> {
  CreateSeedPasswordRoute()
      : super(
          name: 'create-seed-password',
          builder: (context, data, _) => CreateSeedPasswordProfilePage(
            seedPhrase: SeedPhraseModel(data.seedPhrase),
            name: data.name,
            type: data.type,
            mnemonicType: data.mnemonicType,
          ),
        );

  @override
  CreateSeedPasswordRouteData fromQueryParams(Map<String, String> queryParams) {
    final mnemonicTypeStr = queryParams[_mnemonicTypeQueryParam];
    final mnemonicType = mnemonicTypeStr != null
        ? const MnemonicTypeJsonConverter().fromJson(
            jsonDecode(mnemonicTypeStr) as Map<String, dynamic>,
          )
        : null;

    return CreateSeedPasswordRouteData(
      type: SeedAddType.values.byName(queryParams[_typeQueryParam]!),
      seedPhrase: queryParams[_seedQueryParam],
      mnemonicType: mnemonicType,
      name: queryParams[_namePathParam],
    );
  }
}

@freezed
class CreateSeedPasswordRouteData
    with _$CreateSeedPasswordRouteData
    implements CompassRouteDataQuery {
  const factory CreateSeedPasswordRouteData({
    required SeedAddType type,
    String? seedPhrase,
    MnemonicType? mnemonicType,
    String? name,
  }) = _CreateSeedPasswordRouteData;

  const CreateSeedPasswordRouteData._();

  @override
  Map<String, String> toQueryParams() {
    final type = this.type;
    final seedPhrase = this.seedPhrase;
    final name = this.name;
    final mnemonicType = this.mnemonicType;

    return {
      _typeQueryParam: type.name,
      if (seedPhrase != null) _seedQueryParam: seedPhrase,
      if (name != null) _namePathParam: name,
      if (mnemonicType != null)
        _mnemonicTypeQueryParam: jsonEncode(mnemonicType.toJson()),
    };
  }
}
