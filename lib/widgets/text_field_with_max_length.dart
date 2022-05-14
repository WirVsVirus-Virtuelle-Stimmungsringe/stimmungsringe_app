import 'dart:math';

import 'package:flutter/cupertino.dart';
import 'package:flutter/services.dart';

class TextFieldWithMaxLength extends StatefulWidget {
  final int maxLength;
  final String? placeholder;
  final TextEditingController? controller;
  final void Function(String text)? onChanged;

  const TextFieldWithMaxLength({
    Key? key,
    this.maxLength = -1,
    this.placeholder,
    this.controller,
    this.onChanged,
  }) : super(key: key);

  @override
  _TextFieldWithMaxLengthState createState() => _TextFieldWithMaxLengthState();
}

class _TextFieldWithMaxLengthState extends State<TextFieldWithMaxLength> {
  int _currentLength = 0;
  late final TextEditingController _controller;

  @override
  void initState() {
    super.initState();

    _controller = widget.controller ?? TextEditingController();

    final truncatedText = _truncateText(_controller.text, widget.maxLength);
    _currentLength = truncatedText.characters.length;

    if (_controller.text != truncatedText) {
      _controller.text = truncatedText;
    }
  }

  @override
  Widget build(BuildContext context) {
    return CupertinoTextField(
      placeholder: widget.placeholder,
      controller: _controller,
      inputFormatters: [
        _StringCharactersLimitingTextInputFormatter(widget.maxLength)
      ],
      onChanged: (enteredText) {
        setState(() {
          _currentLength = enteredText.characters.length;
        });

        widget.onChanged?.call(enteredText);
      },
      suffix: Padding(
        padding: const EdgeInsets.only(right: 4.0),
        child: Text(
          "$_currentLength/${widget.maxLength}",
          style: const TextStyle(
            fontSize: 14,
            color: CupertinoColors.inactiveGray,
          ),
        ),
      ),
    );
  }
}

class _StringCharactersLimitingTextInputFormatter extends TextInputFormatter {
  final int maxLength;

  _StringCharactersLimitingTextInputFormatter(this.maxLength)
      : assert(maxLength == -1 || maxLength > 0);

  @override
  TextEditingValue formatEditUpdate(
    TextEditingValue oldValue,
    TextEditingValue newValue,
  ) {
    if (maxLength > 0 && newValue.text.characters.length > maxLength) {
      // If already at the maximum and tried to enter even more, keep the old value.
      if (oldValue.text.characters.length == maxLength) {
        return oldValue;
      }
      return _truncate(newValue, maxLength);
    }
    return newValue;
  }

  static TextEditingValue _truncate(TextEditingValue value, int maxLength) {
    final String newValue = _truncateText(value.text, maxLength);

    return TextEditingValue(
      text: newValue,
      selection: value.selection.copyWith(
        baseOffset: min(value.selection.start, newValue.length),
        extentOffset: min(value.selection.end, newValue.length),
      ),
    );
  }
}

String _truncateText(String text, int maxLength) {
  if (maxLength == -1 || text.characters.length <= maxLength) {
    return text;
  }

  return text.characters.take(maxLength).string;
}
