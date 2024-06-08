import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class AutoCompleteElement extends StatefulWidget {
  final String fieldName;
  final List<String> options;
  final Function(String) onChanged;
  final TextEditingController controller;

  const AutoCompleteElement(
      {super.key,
      required this.fieldName,
      required this.options,
      required this.onChanged,
      required this.controller});

  @override
  State<AutoCompleteElement> createState() => _AutoCompleteElementState();
}

class _AutoCompleteElementState extends State<AutoCompleteElement> {
  @override
  Widget build(BuildContext context) {
    return Autocomplete<String>(
        optionsBuilder: (TextEditingValue textEditingValue) {
      if (textEditingValue.text == '') {
        return const Iterable<String>.empty();
      }
      return widget.options.where((String option) {
        return option.contains(textEditingValue.text.toUpperCase());
      });
    }, onSelected: (String selection) {
      widget.onChanged(selection); // Pass the selected value to the callback
    }, fieldViewBuilder:
            (context, textEditingController, focusNode, onFieldSubmitted) {
      textEditingController.value = widget.controller.value;
      return TextFormField(
        validator: (value) {
          if (value!.isEmpty) {
            return "El campo no puede quedar vacio";
          } else if (!widget.options.contains(value.toUpperCase())) {
            return "Entrada no valida";
          }
          return null;
        },
        controller: textEditingController,
        focusNode: focusNode,
        decoration: InputDecoration(
          label: Text(widget.fieldName),
          border: const OutlineInputBorder(),
        ),
        inputFormatters: [
          UppercaseInputFormatter(),
        ],
      );
    });
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
