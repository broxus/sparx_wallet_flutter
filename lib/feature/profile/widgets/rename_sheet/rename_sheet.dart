import 'package:app/di/di.dart';
import 'package:app/feature/messenger/data/message.dart';
import 'package:app/feature/messenger/domain/service/messenger_service.dart';
import 'package:app/feature/profile/widgets/rename_sheet/rename_sheet_cubit.dart';
import 'package:app/generated/generated.dart';
import 'package:app/utils/constants.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:nekoton_repository/nekoton_repository.dart' hide Message;
import 'package:ui_components_lib/ui_components_lib.dart';
import 'package:ui_components_lib/v2/widgets/widgets.dart';

export 'rename_sheet_cubit.dart';

/// Helper method to show the [RenameSheet] widget as a bottom sheet.
///
/// To rename seed phrase, put [renameSeed] true, else key will be renamed.
///
/// Snackbar will contains 'seed' if [renameSeed] is true and 'key' if false.
ModalRoute<void> showRenameSheet(
  BuildContext context,
  PublicKey publicKey, {
  bool renameSeed = false,
  bool isCustodian = false,
}) {
  return commonBottomSheetRoute(
    titleTextStyle: context.themeStyleV2.textStyles.headingLarge,
    title: LocaleKeys.enterNewName.tr(),
    body: (_, __) => BlocProvider<RenameSheetCubit>(
      create: (_) => RenameSheetCubit(
        nekotonRepository: inject<NekotonRepository>(),
        publicKey: publicKey,
        renameSeed: renameSeed,
      ),
      child: RenameSheet(isCustodian: isCustodian),
    ),
  );
}

/// Sheet that allows enter new name of the seed or public key.
/// This sheet automatically calls rename method for key/seed.
class RenameSheet extends StatefulWidget {
  const RenameSheet({
    required this.isCustodian,
    super.key,
  });

  final bool isCustodian;

  @override
  State<RenameSheet> createState() => _RenameSheetState();
}

class _RenameSheetState extends State<RenameSheet> {
  final _nameController = TextEditingController();

  @override
  void dispose() {
    _nameController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return SeparatedColumn(
      mainAxisSize: MainAxisSize.min,
      spacing: DimensSize.d24,
      children: [
        PrimaryTextField(
          maxLength: maxLengthForMainEntities,
          textEditingController: _nameController,
          hintText: LocaleKeys.nameWord.tr(),
          onSubmit: (_) => _rename(context),
        ),
        BlocConsumer<RenameSheetCubit, RenameSheetState>(
          listener: (context, state) {
            if (state case RenameSheetStateCompleted(:final isSeed)
                when isSeed) {
              inject<MessengerService>().show(
                Message.successful(
                  message: isSeed
                      ? LocaleKeys.valueRenamed.tr(
                          args: [LocaleKeys.seedPhrase.tr()],
                        )
                      : widget.isCustodian
                          ? LocaleKeys.custodianRenamed.tr()
                          : LocaleKeys.valueRenamed.tr(
                              args: [LocaleKeys.keyWord.tr()],
                            ),
                ),
              );
              Navigator.of(context).pop();
            }
          },
          builder: (context, state) {
            final isLoading = switch (state) {
              RenameSheetStateLoading() => true,
              _ => false,
            };

            return PrimaryButton(
              buttonShape: ButtonShape.pill,
              isLoading: isLoading,
              onPressed: () => _rename(context),
              title: LocaleKeys.renameWord.tr(),
            );
          },
        ),
      ],
    );
  }

  void _rename(BuildContext context) =>
      context.read<RenameSheetCubit>().rename(_nameController.text);
}
