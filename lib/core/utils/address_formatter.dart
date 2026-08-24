import 'package:flutter/services.dart';

class AddressFormatter extends TextInputFormatter {
  @override
  TextEditingValue formatEditUpdate(
    TextEditingValue oldValue,
    TextEditingValue newValue,
  ) {
    // If the user adds a space, replace it with " - "
    // Only trigger if text length increased (typing) and last char is space
    if (newValue.text.length > oldValue.text.length &&
        newValue.text.endsWith(' ')) {
      // Prevent double dashes if user types " - " manually or backspaces
      if (oldValue.text.endsWith(' - ') || oldValue.text.endsWith('- ')) {
        return newValue;
      }

      // Replace the last space with " - "
      final newText = '${newValue.text.trim()} - ';
      return TextEditingValue(
        text: newText,
        selection: TextSelection.collapsed(offset: newText.length),
      );
    }
    return newValue;
  }
}
