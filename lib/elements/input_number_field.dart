import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

import 'formatters.dart';

class InputNumberField extends StatefulWidget {
  final bool acceptDecimalPoint;
  final bool readOnly;
  final Function(String) onChange;
  final TextEditingController controller;

  const InputNumberField(
      {super.key,
      this.acceptDecimalPoint = true,
      this.readOnly = false,
      required this.onChange,
      required this.controller});

  @override
  State<InputNumberField> createState() => _InputNumberFieldState();
}

class _InputNumberFieldState extends State<InputNumberField> {
  @override
  Widget build(BuildContext context) {
    return TextFormField(
      controller: widget.controller,
      textAlign: TextAlign.center,
      readOnly: widget.readOnly,
      onChanged: widget.onChange,
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
      keyboardType: const TextInputType.numberWithOptions(decimal: true),
      inputFormatters: widget.acceptDecimalPoint
          ? <TextInputFormatter>[
              FilteringTextInputFormatter.allow(RegExp(r'^\d*\.?\d*')),
            ]
          : <TextInputFormatter>[FilteringTextInputFormatter.digitsOnly],
    );
  }

  String getValue() {
    return widget.controller.text;
  }

  void setValue(String value) {
    widget.controller.text = value;
  }
}
