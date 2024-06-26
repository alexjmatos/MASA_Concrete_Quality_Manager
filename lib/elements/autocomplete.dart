import 'package:flutter/material.dart';

import 'formatters.dart';

class AutoCompleteElement extends StatefulWidget {
  final String fieldName;
  final List<String> options;
  final Function(String) onChanged;
  final TextEditingController controller;
  final bool readOnly;

  const AutoCompleteElement(
      {super.key,
      required this.fieldName,
      required this.options,
      required this.onChanged,
      required this.controller,
      this.readOnly = false});

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
        readOnly: widget.readOnly,
        validator: (value) {
          if (value!.isEmpty) {
            return "El campo no puede quedar vacio";
          } else if (!widget.options
              .any((element) => element.toUpperCase() == value.toUpperCase())) {
            return "Entrada no valida";
          }
          return null;
        },
        controller: textEditingController,
        focusNode: focusNode,
        autovalidateMode: AutovalidateMode.disabled,
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
