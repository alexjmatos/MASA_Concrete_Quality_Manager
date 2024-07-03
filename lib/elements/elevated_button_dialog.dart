import 'package:flutter/material.dart';

class ElevatedButtonDialog extends StatelessWidget {
  final String title;
  final String description;
  final Function() onOkPressed;

  const ElevatedButtonDialog(
      {super.key,
      required this.title,
      required this.description,
      required this.onOkPressed});

  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
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
      style: const ButtonStyle(backgroundColor:  WidgetStatePropertyAll(Colors.blue)),
      child: Text(title, style: const TextStyle(color: Colors.white),),
    );
  }
}
