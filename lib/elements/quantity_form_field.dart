import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class QuantityFormField extends StatelessWidget {
  final TextEditingController controller;
  final String labelText;
  final String validatorText;
  final bool readOnly;
  final String defaultValue;
  final void Function(String?)? onChanged;

  const QuantityFormField({
    super.key,
    required this.controller,
    required this.labelText,
    this.readOnly = false,
    this.onChanged,
    this.validatorText = "",
    this.defaultValue = "",
  });

  const QuantityFormField.withDefault(
      {super.key,
      required this.controller,
      required this.labelText,
      required this.readOnly,
      required this.defaultValue,
      this.validatorText = "",
      this.onChanged});

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      controller: controller,
      keyboardType: const TextInputType.numberWithOptions(decimal: true),
      readOnly: readOnly,
      onChanged: onChanged,
      decoration: InputDecoration(
        labelText: labelText,
        border: const OutlineInputBorder(),
      ),
      validator: (value) {
        if (value!.isEmpty) {
          return validatorText;
        }
        return null;
      },
      inputFormatters: [
        FilteringTextInputFormatter.allow(RegExp(r'^\d*\.?\d*')),
      ],
    );
  }
}
