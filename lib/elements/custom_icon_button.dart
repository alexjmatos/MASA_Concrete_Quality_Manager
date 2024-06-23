import 'package:flutter/material.dart';

class CustomIconButton extends StatelessWidget {
  final IconData icon;
  final VoidCallback onPressed;
  final Color iconColor;
  final Color buttonColor;

  const CustomIconButton({
    super.key,
    required this.icon,
    required this.onPressed,
    this.iconColor = Colors.white,
    this.buttonColor = Colors.blue,
  });

  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
      onPressed: onPressed,
      style: ElevatedButton.styleFrom(
        foregroundColor: iconColor,
        backgroundColor: buttonColor,
        shape: const CircleBorder(),
        padding: const EdgeInsets.all(16), // Icon color
      ),
      child: Icon(icon, color: iconColor),
    );
  }
}
