import 'package:flutter/material.dart';

class CustomDropdownFormField extends StatefulWidget {
  final String labelText;
  final List<String> items;
  final Function(String) onChanged;

  const CustomDropdownFormField({
    super.key,
    required this.labelText,
    required this.items,
    required this.onChanged,
  });

  @override
  State<CustomDropdownFormField> createState() =>
      _CustomDropdownFormFieldState();
}

class _CustomDropdownFormFieldState extends State<CustomDropdownFormField> {
  String? _selectedItem;

  @override
  Widget build(BuildContext context) {
    return DropdownButtonFormField<String>(
      value: _selectedItem,
      onChanged: (newValue) {
        setState(() {
          _selectedItem = newValue;
        });
        widget.onChanged(newValue!);
      },
      items: widget.items.map((item) {
        return DropdownMenuItem<String>(
          value: item,
          child: Text(item),
        );
      }).toList(),
      decoration: InputDecoration(
        labelText: widget.labelText,
        border: const OutlineInputBorder(),
      ),
    );
  }
}
