import 'package:flutter/material.dart';

class InputTimePicker extends StatefulWidget {
  final TextEditingController timeController = TextEditingController();

  InputTimePicker({super.key});

  @override
  State<InputTimePicker> createState() => InputTimePickerState();
}

class InputTimePickerState extends State<InputTimePicker> {
  TimeOfDay? selectedTime;

  @override
  void initState() {
    super.initState();
    selectedTime = TimeOfDay.now();
  }

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    widget.timeController.text = selectedTime!.format(context);
  }

  Future<void> _selectTime(BuildContext context) async {
    final TimeOfDay? picked = await showTimePicker(
      context: context,
      initialTime: selectedTime ?? TimeOfDay.now(),
    );
    if (picked != null && picked != selectedTime) {
      setState(() {
        selectedTime = picked;
        widget.timeController.text = picked.format(context);
      });
    }
  }

  @override
  void dispose() {
    widget.timeController.dispose();
    super.dispose();
  }

  TimeOfDay? getSelectedTime() {
    return selectedTime;
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        TextFormField(
          textAlign: TextAlign.center,
          controller: widget.timeController,
          decoration: const InputDecoration(
            isDense: true,
            contentPadding: EdgeInsets.all(4),
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
          readOnly: true,
        ),
        const SizedBox(height: 16),
        IconButton(
          icon: const Icon(Icons.access_time),
          onPressed: () => _selectTime(context),
        ),
      ],
    );
  }
}
