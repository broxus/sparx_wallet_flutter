import 'package:app/generated/generated.dart' hide TextDirection;
import 'package:flutter/material.dart';
import 'package:ui_components_lib/ui_components_lib.dart';

class GroupTitleTextField extends StatefulWidget {
  const GroupTitleTextField({
    required this.onChangeText,
    required this.onEditingComplete,
    required this.onOverflowLength,
    required this.maxLength,
    super.key,
  });

  final ValueChanged<String> onChangeText;
  final ValueChanged<String> onEditingComplete;
  final VoidCallback onOverflowLength;
  final int maxLength;

  @override
  State<GroupTitleTextField> createState() => _GroupTitleTextFieldState();
}

class _GroupTitleTextFieldState extends State<GroupTitleTextField> {
  final _controller = TextEditingController();

  late final _onChangeText = widget.onChangeText;
  late final _onComplete = widget.onEditingComplete;

  late final _onOverflowLength = widget.onOverflowLength;

  late final _maxLength = widget.maxLength;

  final _hintText = '  ${LocaleKeys.newGroup.tr()}';
  late final _hintTextStyle = _textStyles.headingMedium.copyWith(
    color: _colors.content0.withAlpha(122),
  );

  late final _emptyFieldWidth = _calculateWidth();
  late double _width = _isExitText ? double.infinity : _emptyFieldWidth;

  late final _cursorColor = _colors.primaryA;

  bool _isExitText = false;
  String _text = '';

  late final _decoration = InputDecoration(
    border: InputBorder.none,
    hintText: _hintText,
    hintStyle: _hintTextStyle,
  );

  late final _themeStyleV2 = context.themeStyleV2;

  late final _colors = _themeStyleV2.colors;

  late final _textStyles = _themeStyleV2.textStyles;

  @override
  void initState() {
    _controller.addListener(_handleText);
    super.initState();
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: _width,
      child: TextField(
        textAlign: _isExitText ? TextAlign.center : TextAlign.start,
        decoration: _decoration,
        style: _textStyles.headingMedium,
        cursorColor: _cursorColor,
        cursorWidth: DimensSizeV2.d3,
        cursorRadius: Radius.zero,
        autofocus: true,
        controller: _controller,
        onChanged: _onChangedText,
        onEditingComplete: _onEditingComplete,
      ),
    );
  }

  void _onChangedText(String text) {
    _text = text;
    _onChangeText(text);
    if (_isExitText == text.isNotEmpty) {
      return;
    }
    _isExitText = text.isNotEmpty;
    _width = _isExitText ? double.infinity : _emptyFieldWidth;
    setState(() {});
  }

  void _onEditingComplete() {
    _onComplete(_text);
  }

  double _calculateWidth() {
    final textPainter = TextPainter(
      text: TextSpan(text: _hintText, style: _hintTextStyle),
      textDirection: TextDirection.ltr,
      maxLines: 1,
    )..layout();

    return textPainter.size.width;
  }

  void _handleText() {
    final text = _controller.text;

    if (text.length > _maxLength) {
      _controller.text = text.substring(0, _maxLength);
      _onOverflowLength();
    }
  }
}
