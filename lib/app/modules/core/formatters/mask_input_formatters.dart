import 'package:flutter/services.dart';

class PhoneInputFormatter
    extends TextInputFormatter {
  @override
  TextEditingValue formatEditUpdate(
    TextEditingValue oldValue,
    TextEditingValue newValue,
  ) {
    var text = newValue.text.replaceAll(
      RegExp(r'\D'),
      '',
    );

    if (text.length > 11)
      text = text.substring(0, 11);

    String formatted = '';

    if (text.length >= 2) {
      formatted = '(${text.substring(0, 2)})';
      if (text.length >= 7) {
        formatted +=
            ' ${text.substring(2, 7)}-${text.substring(7)}';
      } else if (text.length > 2) {
        formatted += ' ${text.substring(2)}';
      }
    } else {
      formatted = text;
    }

    return TextEditingValue(
      text: formatted,
      selection: TextSelection.collapsed(
        offset: formatted.length,
      ),
    );
  }
}
