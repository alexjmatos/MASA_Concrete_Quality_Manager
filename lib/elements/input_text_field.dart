import 'package:flutter/material.dart';

import 'formatters.dart';

class InputTextField extends StatelessWidget {
  final int lines;
  final bool readOnly;
  final Function(String) onChange;
  final TextEditingController controller = TextEditingController();

  InputTextField(
      {super.key,
      this.lines = 1,
      this.readOnly = false,
      required this.onChange});

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      controller: controller,
      readOnly: readOnly,
      textAlign: TextAlign.center,
      maxLines: lines,
      onChanged: onChange,
      inputFormatters: [
        UppercaseInputFormatter(),
      ],
      decoration: const InputDecoration(
        isDense: true,
        fillColor: Colors.white,
        filled: true,
        border: OutlineInputBorder(
          borderSide: BorderSide.none,
        ),
        enabledBorder: OutlineInputBorder(
          borderSide: BorderSide(color: Colors.grey, width: 0.5),
        ),
        focusedBorder: OutlineInputBorder(
          borderSide: BorderSide(color: Colors.blue, width: 1),
        ),
        errorBorder: OutlineInputBorder(
          borderSide: BorderSide(color: Colors.red, width: 1),
        ),
        focusedErrorBorder: OutlineInputBorder(
          borderSide: BorderSide(color: Colors.red, width: 1),
        ),
      ),
    );
  }
}
