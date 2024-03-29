import 'package:flutter/material.dart';

class AutoCompleteElement extends StatefulWidget {
  final String fieldName;
  final List<String> options;
  final Function(String) onChanged;

  const AutoCompleteElement({
    super.key,
    required this.fieldName,
    required this.options,
    required this.onChanged,
  });

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
      },
      onSelected: (String selection) {
        widget.onChanged(selection); // Pass the selected value to the callback
      },
      fieldViewBuilder:
          (context, textEditingController, focusNode, onFieldSubmitted) {
        return TextFormField(
          controller: textEditingController,
          focusNode: focusNode,
          decoration: InputDecoration(
            label: Text(widget.fieldName),
            border: const OutlineInputBorder(),
          ),
        );
      },
    );
  }
}
