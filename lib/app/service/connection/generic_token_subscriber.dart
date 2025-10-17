import 'package:app/app/service/service.dart';
import 'package:app/http/repository/ton_repository.dart';
import 'package:app/utils/utils.dart';
import 'package:collection/collection.dart';
import 'package:nekoton_repository/nekoton_repository.dart';

sealed class GenericTokenSubscriber {
  Future<GenericTokenWallet> subscribeToken({
    required Address owner,
    required Address rootTokenContract,
    required Transport transport,
  });
}

class Tip3TokenWalletSubscriber extends GenericTokenSubscriber {
  Tip3TokenWalletSubscriber(this._assetsService);

  final AssetsService _assetsService;

  @override
  Future<GenericTokenWallet> subscribeToken({
    required Address owner,
    required Address rootTokenContract,
    required Transport transport,
  }) => Tip3TokenWallet.subscribe(
    transport: transport,
    owner: owner,
    rootTokenContract: rootTokenContract,
    symbol: _getSymbol(rootTokenContract),
  );

  Symbol? _getSymbol(Address rootTokenContract) {
    final asset = _assetsService.currentSystemTokenContractAssets
        .firstWhereOrNull((asset) => asset.address == rootTokenContract);

    return asset?.let(
      (asset) => Symbol(
        name: asset.symbol,
        fullName: asset.name,
        decimals: asset.decimals,
        rootTokenContract: asset.address,
      ),
    );
  }
}

class JettonTokenWalletSubscriber extends GenericTokenSubscriber {
  JettonTokenWalletSubscriber(this._tonRepository);

  final TonRepository _tonRepository;
  final Map<Address, Symbol> _symbolCache = {};

  @override
  Future<GenericTokenWallet> subscribeToken({
    required Address owner,
    required Address rootTokenContract,
    required Transport transport,
  }) async => JettonTokenWallet.subscribe(
    transport: transport,
    owner: owner,
    rootTokenContract: rootTokenContract,
    symbol: await _getSymbol(rootTokenContract),
  );

  Future<Symbol> _getSymbol(Address rootTokenContract) async {
    var symbol = _symbolCache[rootTokenContract];

    if (symbol == null) {
      final info = await _tonRepository.getTokenInfo(
        address: rootTokenContract,
      );

      symbol = Symbol(
        name: info.symbol ?? 'UNKNOWN',
        fullName: info.name ?? 'Unknown token',
        decimals: info.decimals ?? 0,
        rootTokenContract: info.address,
      );
      _symbolCache[rootTokenContract] = symbol;
    }

    return symbol;
  }
}

enum GenericTokenType { tip3, jetton }
