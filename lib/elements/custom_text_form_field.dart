import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

// ignore: must_be_immutable
class CustomTextFormField extends StatelessWidget {
  final TextEditingController controller;
  final String labelText;
  final String validatorText;
  final bool readOnly;
  String? Function(String?)? validator;

  CustomTextFormField({
    super.key,
    this.readOnly = false,
    required this.controller,
    required this.labelText,
    required this.validatorText,
  }) {
    validator = (p0) {
      if (p0!.isEmpty) {
        return validatorText;
      }
      return null;
    };
  }

  CustomTextFormField.withValidator({
    super.key,
    this.readOnly = false,
    required this.controller,
    required this.labelText,
    required this.validatorText,
    this.validator,
  });

  CustomTextFormField.noValidation({
    super.key,
    this.readOnly = false,
    required this.controller,
    required this.labelText,
    this.validatorText = "",
  });

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      controller: controller,
      decoration: InputDecoration(
        labelText: labelText,
        border: const OutlineInputBorder(),
      ),
      validator: validator,
      readOnly: readOnly,
      inputFormatters: [
        UppercaseInputFormatter(),
      ],
    );
  }
}

class UppercaseInputFormatter extends TextInputFormatter {
  @override
  TextEditingValue formatEditUpdate(
      TextEditingValue oldValue, TextEditingValue newValue) {
    return TextEditingValue(
      text: newValue.text.toUpperCase(),
      selection: newValue.selection,
    );
  }
}
