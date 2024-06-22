import 'package:flutter/material.dart';

import '../constants/constants.dart';

class CustomSelectDropdown extends StatefulWidget {
  final String labelText;
  final List<String> items;
  final Function(String) onChanged;
  final int defaultValueIndex;

  const CustomSelectDropdown(
      {super.key,
      required this.labelText,
      required this.items,
      required this.onChanged,
      this.defaultValueIndex = 0});

  @override
  State<CustomSelectDropdown> createState() => _CustomSelectDropdownState();
}

class _CustomSelectDropdownState extends State<CustomSelectDropdown> {
  List<DropdownMenuItem<String>> getDropdownItems() {
    List<String> dropdownItems = widget.items;
    return dropdownItems
        .map((item) => DropdownMenuItem<String>(
              value: item,
              child: Text(item),
            ))
        .toList();
  }

  @override
  Widget build(BuildContext context) {
    return DropdownButtonFormField<String>(
      decoration: InputDecoration(
        labelText: widget.labelText,
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(10),
        ),
      ),
      items: getDropdownItems(),
      onChanged: (value) {
        widget.onChanged(value!);
      },
      icon: const Icon(Icons.arrow_drop_down),
      iconSize: 24,
      elevation: 16,
      style: const TextStyle(color: Colors.black, fontSize: 16),
      dropdownColor: Colors.white,
    );
  }
}
