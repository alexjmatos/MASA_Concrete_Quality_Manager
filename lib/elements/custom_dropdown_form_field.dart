import 'package:flutter/material.dart';

class CustomDropdownFormField extends StatefulWidget {
  final String labelText;
  final List<String> items;
  final Function(String) onChanged;
  final int defaultValueIndex;

  const CustomDropdownFormField(
      {super.key,
      required this.labelText,
      required this.items,
      required this.onChanged,
      this.defaultValueIndex = 0});

  @override
  State<CustomDropdownFormField> createState() =>
      _CustomDropdownFormFieldState();
}

class _CustomDropdownFormFieldState extends State<CustomDropdownFormField> {
  String? _selectedItem;

  @override
  void initState() {
    super.initState();
    Future.delayed(
      const Duration(seconds: 1),
      () {
        setState(
          () {
            if (widget.items.isNotEmpty) {
              _selectedItem = widget.items[widget.defaultValueIndex];
            }
          },
        );
      },
    );
  }

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
