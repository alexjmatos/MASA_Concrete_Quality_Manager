import 'package:flutter/material.dart';

class CustomTimePickerForm extends StatefulWidget {
  final TimeOfDay timeOfDay;
  final String label;
  final bool readOnly;
  final TextEditingController timeController = TextEditingController();
  final PickerOrientation orientation;

  CustomTimePickerForm(
      {super.key,
      required this.timeOfDay,
      required this.label,
      required this.readOnly,
      required this.orientation});

  @override
  State<CustomTimePickerForm> createState() => _CustomTimePickerFormState();
}

class _CustomTimePickerFormState extends State<CustomTimePickerForm> {
  TimeOfDay? selectedTime;

  @override
  void initState() {
    super.initState();
    selectedTime = widget.timeOfDay;
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

  TimeOfDay? getSelectedTime() {
    return selectedTime;
  }

  @override
  Widget build(BuildContext context) {
    switch (widget.orientation) {
      case PickerOrientation.vertical:
        return Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            TextFormField(
              readOnly: true,
              textAlign: TextAlign.center,
              controller: widget.timeController,
              decoration: InputDecoration(
                labelText: widget.label,
                border: const OutlineInputBorder(),
              ),
            ),
            const SizedBox(height: 16),
            IconButton(
              icon: const Icon(Icons.access_time),
              onPressed: () => _selectTime(context),
            ),
          ],
        );
      case PickerOrientation.horizontal:
        return Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Expanded(
              flex: 6,
              child: TextFormField(
                readOnly: true,
                textAlign: TextAlign.center,
                controller: widget.timeController,
                decoration: InputDecoration(
                  labelText: widget.label,
                  border: const OutlineInputBorder(),
                ),
              ),
            ),
            const SizedBox(height: 16),
            if (!widget.readOnly)
              Expanded(
                flex: 1,
                child: IconButton(
                  icon: const Icon(Icons.access_time),
                  onPressed: () => _selectTime(context),
                ),
              ),
          ],
        );
    }
  }
}

enum PickerOrientation {
  vertical,
  horizontal;
}
