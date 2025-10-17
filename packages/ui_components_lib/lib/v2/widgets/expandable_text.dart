import 'package:flutter/widgets.dart';
import 'package:ui_components_lib/ui_components_lib.dart';

class ExpandableText extends StatefulWidget {
  const ExpandableText({
    required this.text,
    required this.expandText,
    this.textStyle,
    this.maxLines = 3,
    this.expandTextStyle,
    super.key,
  });

  final String text;
  final TextStyle? textStyle;
  final int maxLines;
  final String expandText;
  final TextStyle? expandTextStyle;

  @override
  State<ExpandableText> createState() => _ExpandableTextState();
}

class _ExpandableTextState extends State<ExpandableText> {
  bool _expanded = false;
  bool _isOverflowing = false;

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    WidgetsBinding.instance.addPostFrameCallback((_) => _checkOverflow());
  }

  void _checkOverflow() {
    final span = TextSpan(text: widget.text, style: widget.textStyle);
    final tp = TextPainter(
      text: span,
      maxLines: widget.maxLines,
      textDirection: TextDirection.ltr,
    )..layout(maxWidth: context.size?.width ?? double.infinity);
    final overflowing = tp.didExceedMaxLines;

    if (_isOverflowing != overflowing) {
      setState(() {
        _isOverflowing = overflowing;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(
      builder: (context, constraints) {
        final textWidget = Text(
          widget.text,
          style: widget.textStyle,
          maxLines: _expanded ? null : widget.maxLines,
          overflow: _expanded ? TextOverflow.visible : TextOverflow.ellipsis,
        );
        return Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            textWidget,
            if (!_expanded && _isOverflowing)
              GestureDetector(
                onTap: () => setState(() => _expanded = true),
                child: Padding(
                  padding: const EdgeInsets.only(top: DimensSizeV2.d8),
                  child: Text(widget.expandText, style: widget.expandTextStyle),
                ),
              ),
          ],
        );
      },
    );
  }
}
