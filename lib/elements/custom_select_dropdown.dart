import 'package:flutter/material.dart';

class CustomSelectDropdown extends StatelessWidget {
  final String labelText;
  final List<String> items;
  final Function(String) onChanged;
  final int defaultValueIndex;

  const CustomSelectDropdown({
    super.key,
    required this.labelText,
    required this.items,
    required this.onChanged,
    this.defaultValueIndex = 0,
  });

  List<DropdownMenuItem<String>> getDropdownItems() {
    List<String> dropdownItems = items;
    return dropdownItems
        .map((item) => DropdownMenuItem<String>(
              value: item,
              child: Text(item),
            ))
        .toList();
  }

  String? getValue(){
    String? value;
    try {
      value = items[defaultValueIndex];
    } on RangeError {
      // LEAVE NULL
    }
    return value;
  }

  @override
  Widget build(BuildContext context) {
    return DropdownButtonFormField<String>(
      value: getValue(),
      decoration: InputDecoration(
        labelText: labelText,
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(10),
        ),
      ),
      items: getDropdownItems(),
      onChanged: (value) {
        onChanged(value!);
      },
      icon: const Icon(Icons.arrow_drop_down),
      iconSize: 24,
      elevation: 16,
      style: const TextStyle(color: Colors.black, fontSize: 16),
      dropdownColor: Colors.white,
    );
  }
}
