import 'package:app/generated/generated.dart';
import 'package:flutter/material.dart';
import 'package:ui_components_lib/v2/ui_components_lib_v2.dart';

Future<String?> showBrowserEditNameMenu(
  BuildContext context,
  String name,
) {
  return showModalBottomSheet(
    context: context,
    barrierColor: Colors.transparent,
    useRootNavigator: true,
    isScrollControlled: true,
    builder: (_) {
      return EditGroupNameBottomSheet(name);
    },
  );
}

class EditGroupNameBottomSheet extends StatefulWidget {
  const EditGroupNameBottomSheet(
    this.name, {
    super.key,
  });

  final String name;

  @override
  State<EditGroupNameBottomSheet> createState() =>
      _EditGroupNameBottomSheetState();
}

class _EditGroupNameBottomSheetState extends State<EditGroupNameBottomSheet> {
  late final _controller = TextEditingController(text: widget.name);

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final theme = context.themeStyleV2;
    return SizedBox(
      height: DimensSizeV2.d530,
      child: PrimaryBottomSheetContainer(
        backgroundColor: ColorsResV2.n15,
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: DimensSizeV2.d24),
          child: Column(
            spacing: DimensSizeV2.d16,
            children: [
              Text(
                LocaleKeys.editName.tr(),
                style: theme.textStyles.labelMedium,
              ),
              PrimaryTextField(
                textEditingController: _controller,
                isAutofocus: true,
                borderFocusColor: ColorsResV2.p65,
                textStyle: theme.textStyles.paragraphMedium.copyWith(
                  color: theme.colors.border2,
                ),
                cursorColor: theme.colors.border2,
                cursorWidth: DimensSizeV2.d1,
                cursorHeight: DimensSizeV2.d20,
              ),
              Flexible(
                child: Row(
                  spacing: DimensSizeV2.d8,
                  children: [
                    Expanded(
                      child: CustomButton(
                        buttonShape: ButtonShape.pill,
                        // TODO(knightforce): add to color palette
                        backgroundColor: const Color(0xff353960),
                        title: LocaleKeys.backWord.tr(),
                        onPressed: _onPressedBack,
                      ),
                    ),
                    Expanded(
                      child: CustomButton(
                        buttonShape: ButtonShape.pill,
                        backgroundColor: theme.colors.accent,
                        title: LocaleKeys.save.tr(),
                        onPressed: _onPressedSave,
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  void _onPressedBack() {
    Navigator.of(context).pop();
  }

  void _onPressedSave() {
    Navigator.of(context).pop(
      _controller.text.isEmpty ? null : _controller.text,
    );
  }
}
