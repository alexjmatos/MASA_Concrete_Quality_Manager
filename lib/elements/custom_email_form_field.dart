import 'package:flutter/material.dart';

class CustomEmailFormField extends StatelessWidget {
  final TextEditingController controller;
  final String labelText;
  final String hintText;

  const CustomEmailFormField({
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
      keyboardType: TextInputType.emailAddress,
      validator: (value) {
        if (value!.isEmpty) {
          return 'Please enter an email';
        } else if (!isValidEmail(value)) {
          return 'Please enter a valid email';
        }
        return null;
      },
    );
  }

  bool isValidEmail(String value) {
    // Simple email validation using regex
    final emailRegex = RegExp(r'^[\w-\.]+@([\w-]+\.)+[\w-]{2,4}$');
    return emailRegex.hasMatch(value);
  }
}
