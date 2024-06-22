import 'package:flutter/material.dart';

class CustomRadioButton extends StatefulWidget {
  final List<String> options;
  final String? selectedValue;
  final ValueChanged<String?> onChanged;
  final TextStyle? textStyle;
  final Color activeColor;
  final Color inactiveColor;

  const CustomRadioButton({
    super.key,
    required this.options,
    this.selectedValue,
    required this.onChanged,
    this.textStyle,
    this.activeColor = Colors.blue,
    this.inactiveColor = Colors.grey,
  });

  @override
  State<CustomRadioButton> createState() => _CustomRadioButtonState();
}

class _CustomRadioButtonState extends State<CustomRadioButton> {
  String? _selectedValue;

  @override
  void initState() {
    super.initState();
    _selectedValue = widget.selectedValue;
  }

  void _handleRadioValueChange(String? value) {
    setState(() {
      _selectedValue = value;
    });
    widget.onChanged(value);
  }

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.start,
      children: widget.options.map((option) {
        return Expanded(
          child: RadioListTile<String>(
            title: Text(
              option,
              style: widget.textStyle ?? const TextStyle(fontSize: 16),
            ),
            value: option,
            groupValue: _selectedValue,
            onChanged: _handleRadioValueChange,
            activeColor: widget.activeColor,
            selectedTileColor: widget.inactiveColor,
          ),
        );
      }).toList(),
    );
  }
}
