import 'package:app/app/service/connection/connection.dart';
import 'package:app/app/service/connection/data/work_chain/connection_work_chain.dart';
import 'package:elementary_helper/elementary_helper.dart';
import 'package:flutter/material.dart';

class WorkchainSelectorDialog extends StatelessWidget {
  const WorkchainSelectorDialog({
    required this.currentConnectionListanable,
    required this.currentWorkchainListanable,
    super.key,
  });

  final ListenableState<Connection?> currentConnectionListanable;
  final ListenableState<ConnectionWorkchain?> currentWorkchainListanable;

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      title: Text(
        'Select Workchain for '
        '${currentConnectionListanable.value?.networkName}',
      ),
      content: SingleChildScrollView(
        child: DoubleSourceBuilder<Connection?, ConnectionWorkchain?>(
          firstSource: currentConnectionListanable,
          secondSource: currentWorkchainListanable,
          builder:
              (
                _,
                Connection? currentConnection,
                ConnectionWorkchain? currentWorkchain,
              ) {
                if (currentConnection == null) {
                  return const SizedBox.shrink();
                }

                return ListBody(
                  children: <Widget>[
                    for (final workchain in currentConnection.workchains)
                      ListTile(
                        title: Text('${workchain.id}'),
                        selected: workchain.id == currentWorkchain?.id,
                        onTap: () => Navigator.of(context).pop(workchain.id),
                      ),
                  ],
                );
              },
        ),
      ),
    );
  }
}
