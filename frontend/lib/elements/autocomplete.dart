import 'package:flutter/material.dart';

class AutoCompleteElement extends StatefulWidget {
  final String fieldName;
  final List<String> options;

  const AutoCompleteElement(
      {super.key, required this.fieldName, required this.options});

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
        debugPrint('You just selected $selection');
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
