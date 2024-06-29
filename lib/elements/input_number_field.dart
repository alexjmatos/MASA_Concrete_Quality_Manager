import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class InputNumberField extends StatelessWidget {
  final bool acceptDecimalPoint;
  final TextEditingController controller = TextEditingController();
  final bool readOnly;

  InputNumberField(
      {super.key, this.acceptDecimalPoint = true, this.readOnly = false});

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      controller: controller,
      textAlign: TextAlign.center,
      readOnly: readOnly,
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
      inputFormatters: acceptDecimalPoint
          ? <TextInputFormatter>[
              FilteringTextInputFormatter.allow(RegExp(r'^\d*\.?\d*')),
            ]
          : <TextInputFormatter>[FilteringTextInputFormatter.digitsOnly],
    );
  }
}
