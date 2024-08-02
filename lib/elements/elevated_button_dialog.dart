import 'package:flutter/material.dart';

class ElevatedButtonDialog extends StatelessWidget {
  final String title;
  final String description;
  final Function() onOkPressed;
  final IconData icon;
  final Color textColor;
  final Color iconColor;
  final Color buttonColor;

  const ElevatedButtonDialog(
      {super.key,
      required this.title,
      required this.description,
      required this.onOkPressed,
      required this.textColor,
      required this.icon,
      required this.iconColor,
      required this.buttonColor});

  @override
  Widget build(BuildContext context) {
    return ElevatedButton.icon(
      onPressed: () => showDialog<String>(
        context: context,
        builder: (BuildContext context) => AlertDialog(
          title: Text(title),
          content: Text(description),
          actions: <Widget>[
            TextButton(
              onPressed: () => Navigator.pop(context, 'Cancel'),
              child: const Text('Cancelar'),
            ),
            TextButton(
              onPressed: onOkPressed,
              child: const Text('Confirmar'),
            ),
          ],
        ),
      ),
      style: ButtonStyle(backgroundColor: WidgetStatePropertyAll(buttonColor)),
      label: Text(title, style: TextStyle(color: textColor)),
      icon: Icon(
        icon,
        color: iconColor,
      ),
    );
  }
}
