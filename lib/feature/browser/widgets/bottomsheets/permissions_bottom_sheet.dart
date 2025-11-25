import 'package:app/generated/generated.dart';
import 'package:flutter/material.dart';
import 'package:flutter_inappwebview/flutter_inappwebview.dart';
import 'package:ui_components_lib/ui_components_lib.dart';
import 'package:ui_components_lib/v2/ui_components_lib_v2.dart';

Future<List<PermissionResourceType>?> showPermissionsSheet({
  required BuildContext context,
  required String host,
  required List<PermissionResourceType> permissions,
}) {
  return showCommonBottomSheet<List<PermissionResourceType>?>(
    context: context,
    body: (BuildContext context, __) =>
        _Body(host: host, permissions: permissions),
  );
}

class _Body extends StatefulWidget {
  const _Body({required this.host, required this.permissions});

  final String host;
  final List<PermissionResourceType> permissions;

  @override
  State<_Body> createState() => _BodyState();
}

class _BodyState extends State<_Body> {
  late final _permissionsMap = Map<PermissionResourceType, bool>.fromIterable(
    widget.permissions,
    value: (_) => true,
  );

  List<PermissionResourceType> get _acceptPermissions => [
    for (final k in _permissionsMap.keys)
      if (_permissionsMap[k] ?? false) k,
  ];

  @override
  Widget build(BuildContext context) {
    final theme = context.themeStyleV2;

    return Column(
      mainAxisSize: MainAxisSize.min,
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        const SizedBox(height: DimensSizeV2.d24),
        Text(
          LocaleKeys.browserPermissionsHeader.tr(),
          style: theme.textStyles.headingLarge,
          textAlign: TextAlign.center,
        ),
        const SizedBox(height: DimensSizeV2.d8),
        Text(
          LocaleKeys.browserPermissionsBody.tr(args: [widget.host]),
          style: theme.textStyles.paragraphSmall,
          textAlign: TextAlign.center,
        ),
        const SizedBox(height: DimensSizeV2.d24),
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: DimensSizeV2.d12),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              for (final k in _permissionsMap.keys)
                Flexible(
                  key: ValueKey(k),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(k.toValue(), style: theme.textStyles.labelSmall),
                      Switch(
                        value: _permissionsMap[k] ?? true,
                        onChanged: (value) =>
                            setState(() => _permissionsMap[k] = value),
                      ),
                    ],
                  ),
                ),
            ],
          ),
        ),
        const SizedBox(height: DimensSizeV2.d24),
        PrimaryButton(
          buttonShape: ButtonShape.pill,
          title: LocaleKeys.acceptWord.tr(),
          onPressed: () {
            Navigator.of(context).pop(_acceptPermissions);
          },
        ),
        const SizedBox(height: DimensSizeV2.d8),
        DestructiveButton(
          buttonShape: ButtonShape.pill,
          title: LocaleKeys.cancelWord.tr(),
          onPressed: () {
            Navigator.of(context).pop();
          },
        ),
        const SizedBox(height: DimensSizeV2.d12),
      ],
    );
  }
}
