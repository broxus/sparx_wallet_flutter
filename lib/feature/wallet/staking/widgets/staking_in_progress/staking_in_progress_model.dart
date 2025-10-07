import 'package:app/feature/wallet/staking/widgets/staking_in_progress/staking_in_progress.dart';
import 'package:elementary/elementary.dart';
import 'package:injectable/injectable.dart';
import 'package:nekoton_repository/nekoton_repository.dart';

/// [ElementaryModel] for [StakingInProgress]
@injectable
class StakingInProgressModel extends ElementaryModel {
  StakingInProgressModel(
    ErrorHandler errorHandler,
    this._nekotonRepository,
  ) : super(errorHandler: errorHandler);

  final NekotonRepository _nekotonRepository;

  Money getTransactionValueByAmount(BigInt amount) =>
      Money.fromBigIntWithCurrency(
        amount,
        Currencies()[_nekotonRepository.currentTransport.nativeTokenTicker]!,
      );
}
