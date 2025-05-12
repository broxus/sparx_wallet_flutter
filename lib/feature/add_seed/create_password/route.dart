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

@singleton
class CreateSeedPasswordRoute
    extends CompassRoute<CreateSeedPasswordRouteData> {
  CreateSeedPasswordRoute({
    required this.enableBiometryRoute,
  }) : super(
          name: 'create-seed-password',
          builder: (context, data, _) => data.map(
            onboarding: (onboarding) {
              return CreateSeedPasswordScreen(
                phrase: SeedPhraseModel(onboarding.seedPhrase),
                mnemonicType: onboarding.mnemonicType,
              );
            },
            profile: (profile) {
              return CreateSeedPasswordProfilePage(
                seedPhrase: SeedPhraseModel(profile.seedPhrase),
                name: profile.name,
                type: profile.type,
                mnemonicType: profile.mnemonicType,
              );
            },
          ),
          compassBaseRoutes: [enableBiometryRoute],
        );

  final EnableBiometryRoute enableBiometryRoute;

  @override
  CreateSeedPasswordRouteData fromQueryParams(Map<String, String> queryParams) {
    final mnemonicTypeStr = queryParams[_mnemonicTypeQueryParam];
    final mnemonicType = mnemonicTypeStr != null
        ? const MnemonicTypeJsonConverter().fromJson(
            jsonDecode(mnemonicTypeStr) as Map<String, dynamic>,
          )
        : null;

    if (queryParams.containsKey(_typeQueryParam)) {
      return CreateSeedPasswordRouteData.onboarding(
        seedPhrase: queryParams[_seedQueryParam],
        mnemonicType: mnemonicType,
      );
    } else {
      return CreateSeedPasswordRouteData.profile(
        type: SeedAddType.values.byName(queryParams[_typeQueryParam]!),
        seedPhrase: queryParams[_seedQueryParam],
        mnemonicType: mnemonicType,
        name: queryParams[_namePathParam],
      );
    }
  }
}

/// Route data for CreateSeedPassword
@freezed
sealed class CreateSeedPasswordRouteData
    with _$CreateSeedPasswordRouteData
    implements CompassRouteDataQuery {
  const factory CreateSeedPasswordRouteData.onboarding({
    String? seedPhrase,
    MnemonicType? mnemonicType,
  }) = _OnboardingCreateSeed;

  const factory CreateSeedPasswordRouteData.profile({
    required SeedAddType type,
    String? seedPhrase,
    MnemonicType? mnemonicType,
    String? name,
  }) = _ProfileCreateSeed;

  const CreateSeedPasswordRouteData._();

  @override
  Map<String, String> toQueryParams() {
    return switch (this) {
      _OnboardingCreateSeed(
        :final seedPhrase,
        :final mnemonicType,
      ) =>
        {
          if (seedPhrase != null) _seedQueryParam: seedPhrase,
          if (mnemonicType != null)
            _mnemonicTypeQueryParam: jsonEncode(mnemonicType.toJson()),
        },
      _ProfileCreateSeed(
        :final seedPhrase,
        :final mnemonicType,
        :final name,
        :final type,
      ) =>
        {
          _typeQueryParam: type.name,
          if (seedPhrase != null) _seedQueryParam: seedPhrase,
          if (name != null) _namePathParam: name,
          if (mnemonicType != null)
            _mnemonicTypeQueryParam: jsonEncode(mnemonicType.toJson()),
        },
    };
  }
}
