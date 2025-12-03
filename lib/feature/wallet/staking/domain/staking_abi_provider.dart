import 'package:app/app/service/connection/data/network_type.dart';
import 'package:app/app/service/resources_service.dart';
import 'package:app/generated/generated.dart';
import 'package:injectable/injectable.dart';

@singleton
class StakingAbiProvider {
  StakingAbiProvider(this._resourcesService);

  final ResourcesService _resourcesService;
  final Map<String, Future<String>> _abiCache = {};

  Future<String> getVaultAbi(NetworkType networkType) {
    final path = switch (networkType) {
      NetworkType.ever => Assets.abi.stEverVaultAbi,
      NetworkType.tycho => Assets.abi.stEverVaultTychoAbi,
      _ => Assets.abi.stEverVaultNewAbi,
    };

    return _load(path);
  }

  Future<String> getAccountAbi(NetworkType networkType) {
    final path = switch (networkType) {
      NetworkType.ever => Assets.abi.stEverAccountAbi,
      _ => Assets.abi.stEverAccountNewAbi,
    };

    return _load(path);
  }

  Future<String> _load(String path) {
    var abi = _abiCache[path];

    if (abi == null) {
      abi = _resourcesService.loadString(path);
      _abiCache[path] = abi;
    }

    return abi;
  }
}
