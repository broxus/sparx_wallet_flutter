import 'dart:convert';

import 'package:app/data/models/models.dart';
import 'package:injectable/injectable.dart';
import 'package:nekoton_repository/nekoton_repository.dart';

@singleton
class GasPriceService {
  GasPriceService(
    this._nekotonRepository,
  );

  final NekotonRepository _nekotonRepository;

  Transport get _transport => _nekotonRepository.currentTransport.transport;

  Future<GasPriceParams?> getGasPriceParams([
    GasPriceType type = GasPriceType.workchainGasLimitsAndPrices,
  ]) async {
    try {
      final (fields, state) = await _transport.getContractFields(
        address: _address,
        contractAbi: _configAbi,
      );
      final (nonEmptyMap, hash) = packIntoCell(
        params: const [
          AbiParam(name: 'flag', type: 'bool'),
          AbiParam(name: 'root', type: 'cell'),
        ],
        tokens: {
          'flag': true,
          'root': fields!['paramsRoot'],
        },
      );
      final rawParams = unpackFromCell(
        params: const [AbiParam(name: 'params', type: 'map(uint32,cell)')],
        boc: nonEmptyMap,
        allowPartial: true,
      );
      final entries = (rawParams['params'] as List<dynamic>)
          .cast<List<dynamic>>()
          .map((e) => MapEntry(int.parse(e[0] as String), e[1] as String));
      final params = Map.fromEntries(entries);
      final data = unpackFromCell(
        params: (jsonDecode(_pricesParamAbi) as List<dynamic>)
            .map(
              (json) => AbiParam.fromJson(json as Map<String, dynamic>),
            )
            .toList(),
        boc: params[type.paramsKey]!,
        allowPartial: true,
      );

      return GasPriceParams.fromJson(
        data['value'] as Map<String, dynamic>,
      );
    } catch (_) {
      return null;
    }
  }

  Future<BigInt> computeGas({
    required BigInt dynamicGas,
    BigInt? fixedGas,
    GasPriceParams? params,
    GasPriceType type = GasPriceType.workchainGasLimitsAndPrices,
  }) async {
    final p = params ?? await getGasPriceParams(type);
    final gasPrice = BigInt.from(
      (p?.gasPrice ?? type.baseGasPrice) / type.baseGasPrice, // pow(2, 16)
    );

    return dynamicGas * gasPrice + (fixedGas ?? BigInt.zero);
  }
}

enum GasPriceType {
  masterchainGasLimitsAndPrices,
  masterchainMessageForwardingPrices,
  workchainGasLimitsAndPrices,
  workchainMessageForwardingPrices;

  int get paramsKey => switch (this) {
        masterchainGasLimitsAndPrices => 20,
        masterchainMessageForwardingPrices => 24,
        workchainGasLimitsAndPrices => 21,
        workchainMessageForwardingPrices => 25,
      };

  BigInt get baseGasPrice => switch (this) {
        masterchainGasLimitsAndPrices ||
        masterchainMessageForwardingPrices =>
          _evrscaleMasterchainGasPrice,
        workchainGasLimitsAndPrices ||
        workchainMessageForwardingPrices =>
          _evrscaleWorkchainGasPrice,
      };
}

final _evrscaleWorkchainGasPrice = BigInt.parse('65536000');
final _evrscaleMasterchainGasPrice = BigInt.parse('655360000');
const _address = Address(
  address:
      '-1:5555555555555555555555555555555555555555555555555555555555555555',
);
const _configAbi = '''
{
  "ABI version": 2,
  "version": "2.2",
  "header": [],
  "functions": [],
  "events": [],
  "fields": [
    {
      "name": "paramsRoot",
      "type": "cell"
    }
  ]
}''';
const _pricesParamAbi = '''
[
  {
    "name": "value",
    "type": "tuple",
    "components": [
      { "name": "tag1", "type": "uint8" },
      { "name": "flatGasLimit", "type": "uint64" },
      { "name": "flatGasPrice", "type": "uint64" },
      { "name": "tag2", "type": "uint8" },
      { "name": "gasPrice", "type": "uint64" },
      { "name": "gasLimit", "type": "uint64" },
      { "name": "specialGasLimit", "type": "uint64" },
      { "name": "gasCredit", "type": "uint64" },
      { "name": "blockGasLimit", "type": "uint64" },
      { "name": "freezeDueLimit", "type": "uint64" },
      { "name": "deleteDueLimit", "type": "uint64" }
    ]
  }
]
''';
