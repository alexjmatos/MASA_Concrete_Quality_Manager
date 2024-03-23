import 'package:flutter/material.dart';

class CustomNumberFormField extends StatelessWidget {
  final TextEditingController controller;
  final String labelText;
  final int maxLength;
  final String validatorText;

  const CustomNumberFormField(
      {super.key,
      required this.controller,
      required this.labelText,
      this.maxLength = 5,
      required this.validatorText});

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      controller: controller,
      keyboardType: TextInputType.number,
      maxLength: maxLength,
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
    );
  }
}
