import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class CustomPhoneNumberFormField extends StatelessWidget {
  final TextEditingController controller;
  final String labelText;
  final String hintText;

  const CustomPhoneNumberFormField({
    super.key,
    required this.controller,
    required this.labelText,
    required this.hintText,
  });

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      controller: controller,
      decoration: InputDecoration(
        labelText: labelText,
        hintText: hintText,
        border: const OutlineInputBorder(),
      ),
      keyboardType: TextInputType.phone,
      inputFormatters: [
        FilteringTextInputFormatter.digitsOnly,
        LengthLimitingTextInputFormatter(
            10), // Limit to 10 digits for US phone numbers
        PhoneNumberFormatter(), // Custom formatter to add phone number formatting
      ],
    );
  }
}

class PhoneNumberFormatter extends TextInputFormatter {
  @override
  TextEditingValue formatEditUpdate(
      TextEditingValue oldValue, TextEditingValue newValue) {
    // Format phone number: (123) 456-7890
    final newText = newValue.text
        .replaceAll(RegExp(r'\D'), ''); // Remove non-digit characters
    final StringBuffer formattedText = StringBuffer();

    if (newText.isNotEmpty) {
      formattedText.write('(${newText.substring(0, 3)}');
    }
    if (newText.length >= 4) {
      formattedText.write(') ${newText.substring(3, 6)}');
    }
    if (newText.length >= 7) {
      formattedText.write('-${newText.substring(6, 10)}');
    }

    return TextEditingValue(
      text: formattedText.toString(),
      selection: TextSelection.collapsed(offset: formattedText.length),
    );
  }
}
